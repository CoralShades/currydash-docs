# Service Layer & Business Logic

## Current State

**Architecture Pattern**: **Monolithic Helpers + Traits**

The current codebase uses a **hybrid approach** with business logic scattered across:

1. **CentralLogics/helpers.php** (2000+ lines of static methods)
2. **Traits** (PlaceNewOrder, PaymentGatewayTrait, NotificationDataSetUpTrait)
3. **Controllers** (embedded business logic)

**Example Current Pattern**:
```php
// CentralLogics/helpers.php (Static methods)
class Helpers {
    public static function error_processor($validator) { ... }
    public static function variation_price($product, $variations) { ... }
    public static function get_full_url($type, $filename, $storage) { ... }
    // + 100 more static methods
}

// Trait-based logic
trait PlaceNewOrder {
    private function makeOrderDetails($cart_item, $order_id) { ... } // 900 lines
}

// Controller with embedded logic
class OrderController extends Controller {
    use PlaceNewOrder;

    public function placeOrder(Request $request) {
        DB::transaction(function() use ($request) {
            // 200+ lines of business logic here
        });
    }
}
```

**Issues with Current Approach**:
- ❌ Tight coupling to static methods
- ❌ Hard to test in isolation
- ❌ No dependency injection
- ❌ Business logic mixed with HTTP concerns
- ❌ Difficult to swap implementations

## Recommended Service Layer Architecture

**Proposed Structure**:
```
app/Services/
├── OrderService.php
│   ├── placeOrder(User $user, array $items): Order
│   ├── calculateTotal(Order $order): float
│   ├── processPayment(Order $order, string $method): bool
│   └── assignDeliveryMan(Order $order): void
│
├── PackageService.php
│   ├── createPackage(Restaurant $restaurant, array $data): Package
│   ├── updatePackage(Package $package, array $data): Package
│   ├── validateCustomization(Package $package, array $selections): bool
│   └── formatForApi(Package $package): array
│
├── SubscriptionService.php
│   ├── createSubscription(User $user, array $data): Subscription
│   ├── pauseSubscription(Subscription $sub, Carbon $from, Carbon $to): bool
│   ├── cancelSubscription(Subscription $sub, string $reason): bool
│   ├── processRecurringOrder(Subscription $sub): Order
│   └── checkRenewal(Subscription $sub): bool
│
├── PaymentService.php
│   ├── processPayment(Order $order, string $gateway): PaymentResult
│   ├── verifyPayment(string $transaction_id): bool
│   ├── refundPayment(Order $order, float $amount): bool
│   └── handleWebhook(string $gateway, array $payload): void
│
└── NotificationService.php
    ├── sendOrderNotification(Order $order, string $event): void
    ├── sendSubscriptionNotification(Subscription $sub, string $event): void
    ├── sendPushNotification(User $user, string $title, string $body): void
    └── sendEmail(User $user, string $template, array $data): void
```

**Example Refactored Controller**:
```php
class OrderController extends Controller
{
    protected $orderService;
    protected $paymentService;
    protected $notificationService;

    public function __construct(
        OrderService $orderService,
        PaymentService $paymentService,
        NotificationService $notificationService
    ) {
        $this->orderService = $orderService;
        $this->paymentService = $paymentService;
        $this->notificationService = $notificationService;
    }

    public function placeOrder(PlaceOrderRequest $request)
    {
        $order = $this->orderService->placeOrder(
            auth()->user(),
            $request->cart_items
        );

        if ($request->payment_method !== 'cash_on_delivery') {
            $payment = $this->paymentService->processPayment(
                $order,
                $request->payment_method
            );

            if (!$payment->success) {
                return response()->json(['error' => 'Payment failed'], 402);
            }
        }

        $this->notificationService->sendOrderNotification($order, 'placed');

        return response()->json(['order' => $order], 201);
    }
}
```

**Benefits**:
- ✅ Testable (mock dependencies)
- ✅ Reusable across controllers
- ✅ Clear separation of concerns
- ✅ Easier to maintain and refactor
- ✅ Dependency injection for flexibility

**Implementation Status**: ⚠️ **Partially Implemented**
- TaxModule has `CalculateTaxService` (good example)
- Most business logic still in Helpers/Traits
- Recommendation: Gradual refactoring to service classes

---
