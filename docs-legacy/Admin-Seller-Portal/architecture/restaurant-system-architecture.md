# Restaurant System Architecture

## Overview

The Restaurant system supports **dual business models**:

1. **Commission Model** - Platform earns % per order
2. **Subscription Model** - Vendor pays monthly/yearly subscription fee

**Restaurant Model** (68 columns - heavily evolved):

```
Restaurant
├── id, vendor_id, zone_id, cuisine_id
├── name, logo, cover_photo
├── minimum_order, delivery_charge, tax
├── restaurant_model enum: 'commission', 'subscription'
├── package_id (default package for orders)
├── order_subscription_active boolean (enables customer subscriptions)
├── POS, self_delivery_system, delivery flags
├── opening_time, closing_time, off_day (schedule)
├── veg, non_veg, cutlery (dietary flags)
├── schedule_order (advanced scheduling support)
├── halal_tag_status, is_halal (certification)
├── gst_status, gst_code (tax registration)
├── free_delivery boolean (admin can enable)
├── rating_count, avg_rating (reviews)
├── positive_rating, negative_rating
├── total_order (order count)
├── HasMany: Food, Order, Package, RestaurantSubscription
├── HasOne: RestaurantConfig, RestaurantWallet, RestaurantSchedule
├── BelongsTo: Vendor, Zone, Cuisine, Package (default)
└── Global Scopes: ZoneScope, RestaurantScope

RestaurantConfig (24 columns - Extended settings)
├── restaurant_id
├── halal_tag_status, is_halal, dine_in
├── extra_packaging_status, extra_packaging_amount
├── customer_date_order_sratus, customer_order_date
├── instant_order, extra_packaging_amount
├── cutlery boolean
└── Configuration flags

RestaurantWallet (Financial tracking)
├── restaurant_id
├── balance, total_earned, total_withdrawn
├── pending_withdraw
└── HasMany: WithdrawRequest
```

## Business Model Toggle

**Commission Model**:
```php
// Per-order commission
if ($restaurant->restaurant_model === 'commission') {
    $commission_rate = $restaurant->commission ?? config('default_commission'); // e.g., 15%
    $admin_commission = $order->order_amount * ($commission_rate / 100);
    $vendor_payment = $order->order_amount - $admin_commission;
}
```

**Subscription Model**:
```php
// Monthly/yearly subscription fee
if ($restaurant->restaurant_model === 'subscription') {
    // Check active subscription
    $subscription = RestaurantSubscription::where('restaurant_id', $restaurant->id)
        ->where('expiry_date', '>', now())
        ->where('is_canceled', false)
        ->first();

    if (!$subscription) {
        // Vendor access restricted
        return response()->json(['message' => 'Please renew your subscription'], 403);
    }

    // Check order limits
    if ($subscription->max_order && $restaurant->total_order >= $subscription->max_order) {
        return response()->json(['message' => 'Order limit reached for current plan'], 403);
    }

    // No per-order commission
    $vendor_payment = $order->order_amount;
}
```

## Zone-Based Filtering (Global Scope)

```php
// app/Scopes/ZoneScope.php
class ZoneScope implements Scope
{
    public function apply(Builder $builder, Model $model)
    {
        if (auth()->guard('admin')->check()) {
            $admin = auth('admin')->user();
            if ($admin->zone_id) {
                $builder->where('zone_id', $admin->zone_id);
            }
        }
    }
}

// Usage:
// When admin with zone_id=5 queries restaurants:
Restaurant::all(); // Automatically filtered to zone_id=5
```

---
