# Order System Architecture

## Overview

The CurryDash order system is feature-rich with **99 columns** in the orders table, supporting:

- Multi-item orders (food + packages simultaneously)
- Package customization tracking
- Subscription-linked orders
- Multiple payment methods
- Guest checkout
- Order proof images
- Delivery tips
- Tax calculations (TaxModule integration)

**Database Stats:**
- **orders** table: 99 columns (created May 2021, 50+ enhancements)
- **order_details** table: 24 columns (line items, package-aware)
- **order_package_selections** table: 5 columns (package option tracking)

## Order Models

```
Order (99 columns - comprehensive)
├── user_id (FK), restaurant_id (FK), delivery_man_id (FK)
├── order_amount, coupon_discount_amount, delivery_charge
├── total_tax_amount, restaurant_discount_amount, admin_discount_amount
├── order_status enum: pending, confirmed, processing, out_for_delivery, delivered, canceled, etc.
├── payment_method enum: cash_on_delivery, digital_payment, wallet, offline_payment
├── payment_status enum: unpaid, paid, failed, refunded
├── subscription_id (links to subscription orders)
├── zone_id, distance
├── dm_tips, cutlery, is_guest
├── additional_charge, extra_packaging_amount, ref_bonus_amount
├── order_proof (JSON array of proof images)
├── scheduled (boolean), delivery_date, delivery_time
├── HasMany: OrderDetail, OrderPayment, OrderDeliveryHistory
├── HasOne: OrderReference, CashBackHistory
└── BelongsTo: User/Guest, Restaurant, DeliveryMan, Subscription, Zone

OrderDetail (24 columns - Line items)
├── order_id, food_id, package_id, item_campaign_id
├── is_package boolean (distinguishes package vs food orders)
├── quantity, price, discount_on_food
├── total_add_on_price, add_ons (JSON array)
├── variation (JSON), tax_amount, tax_status
├── created_at, updated_at
├── HasMany: OrderPackageSelection (when is_package=true)
└── BelongsTo: Food, Order, Package, ItemCampaign

OrderPackageSelection (5 columns - Package customization audit)
├── id, order_detail_id, package_option_id, food_id
├── price, quantity
└── BelongsTo: OrderDetail, PackageOption, Food

Cart (11 columns - Pre-order shopping cart)
├── user_id, item_id, package_id, is_guest
├── item_type (polymorphic: Food or ItemCampaign)
├── price, quantity
├── add_on_ids (array), add_on_qtys (array)
├── variation (JSON for food variations)
├── options (JSON - stores package selections before checkout)
└── BelongsTo: Package
```

## Order Placement Flow

**Step 1: Cart to Order Conversion**

Handled by `app/Traits/PlaceNewOrder.php` (900+ lines):

```php
trait PlaceNewOrder {
    private function makeOrderDetails($cart_item, $order_id)
    {
        if ($cart_item->is_package) {
            // Package order
            $package = Package::find($cart_item->package_id);

            $order_detail = OrderDetail::create([
                'order_id' => $order_id,
                'package_id' => $cart_item->package_id,
                'is_package' => true,
                'quantity' => $cart_item->quantity,
                'price' => $package->base_price,
            ]);

            // Create package selections
            foreach ($cart_item->options as $option_id) {
                $option = PackageOption::find($option_id);
                OrderPackageSelection::create([
                    'order_detail_id' => $order_detail->id,
                    'package_option_id' => $option->id,
                    'food_id' => $option->food_id,
                    'price' => $option->additional_charge,
                    'quantity' => 1,
                ]);
            }
        } else {
            // Regular food order
            $food = Food::find($cart_item->item_id);

            OrderDetail::create([
                'order_id' => $order_id,
                'food_id' => $cart_item->item_id,
                'is_package' => false,
                'quantity' => $cart_item->quantity,
                'price' => $this->calculate_variation_price($food, $cart_item->variation),
                'add_ons' => $cart_item->add_on_ids,
                'total_add_on_price' => $this->calculate_addon_price($cart_item->add_on_ids),
                'variation' => $cart_item->variation,
            ]);
        }
    }

    private function calculate_variation_price($variations, $quantity) { ... }
    private function calculate_addon_price($addons, $quantity) { ... }
    private function apply_discount($price, $discount) { ... }
    private function calculate_tax($price, $tax_rate) { ... }
}
```

**Step 2: Financial Settlement**

Handled by `app/CentralLogics/order.php`:

```php
class OrderLogic {
    public static function create_transaction($order_id, $order_amount, $restaurant_amount)
    {
        // Calculate commission
        $commission = $order_amount * (config('commission_rate') / 100);
        $vendor_payment = $restaurant_amount - $commission;

        // Record transaction
        Transaction::create([
            'order_id' => $order_id,
            'vendor_id' => $order->restaurant->vendor_id,
            'order_amount' => $order_amount,
            'restaurant_amount' => $restaurant_amount,
            'admin_commission' => $commission,
            'restaurant_discount' => $order->restaurant_discount_amount,
            'admin_discount' => $order->admin_discount_amount,
            'free_delivery' => $order->free_delivery_by_admin,
            'vendor_payable' => $vendor_payment,
        ]);
    }

    public static function cashbackToWallet($order) { ... }
    public static function expense_calculation($order) { ... }
}
```

## Order Status State Machine

```php
// Order status flow
pending → confirmed → processing → out_for_delivery → delivered
                                  ↓
                               canceled (at any stage)
                                  ↓
                               refunded (if payment processed)

// Validation:
- Cannot cancel after out_for_delivery (vendor decision)
- Cannot mark delivered without delivery_man_id (if platform delivery)
- Cannot process payment twice
```

---
