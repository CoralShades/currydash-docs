# Subscription System Architecture

## Overview

The CurryDash subscription system supports **two types** of subscriptions:

1. **Restaurant Subscriptions** - Platform fees for vendors/sellers (subscription vs commission business model)
2. **Customer Subscriptions** - Recurring delivery subscriptions for customers (HelloFresh-style meal subscriptions)

**Jira Projects**: CUR-114 (lifecycle), CAR-004 (vendor billing), CPFP-15 (data model)

## Restaurant Subscription Model

**Purpose**: Manage vendor platform access via subscription plans

**Models** (3 core models):
```
SubscriptionPackage (Master Plan Template)
├── id, package_name, price, validity (days)
├── Features: chat, review, pos, mobile_app, self_delivery
├── max_order, max_product (usage limits)
├── is_trial boolean
└── HasMany: RestaurantSubscription, SubscriptionTransaction

RestaurantSubscription (Active Subscription per Restaurant)
├── id, restaurant_id, package_id
├── expiry_date, price, validity
├── Features: chat, review, pos, mobile_app, self_delivery
├── max_order, max_product
├── is_canceled, canceled_by
├── HasOne: SubscriptionTransaction (latest)
└── HasMany: SubscriptionTransaction

SubscriptionTransaction (Financial Records)
├── id, restaurant_id, package_id, restaurant_subscription_id
├── paid_amount, payment_method, status
├── is_trial, validity
├── created_by (admin/vendor)
└── BelongsTo: Restaurant, SubscriptionPackage
```

**Business Model Toggle**:
```php
// Restaurant model
restaurant_model enum:
├── 'commission' - Pay % per order
└── 'subscription' - Pay monthly/yearly subscription fee

// When subscription model:
if (restaurant->restaurant_model === 'subscription') {
    // Check active subscription
    $active_subscription = $restaurant->restaurant_subscription()
        ->where('expiry_date', '>', now())
        ->where('is_canceled', false)
        ->first();

    if (!$active_subscription) {
        // Restrict vendor access
    }
}
```

## Customer Subscription Model

**Purpose**: Recurring meal delivery for customers

**Models** (4 core models):
```
Subscription (User/Customer-based subscriptions)
├── id, user_id, restaurant_id, quantity
├── billing_amount, paid_amount, status
├── start_at, end_at
├── delivery_preference_time
├── pause, pause_start_date, pause_end_date, pause_count
├── HasMany: SubscriptionSchedule, SubscriptionLog, SubscriptionPause
└── Computed: is_paused_today, dynamic_status (active/paused/expired)

SubscriptionSchedule (Delivery Schedules)
├── id, subscription_id
├── day (0-6 for days of week, or specific date)
├── type enum: 'daily', 'weekly', 'monthly'
└── BelongsTo: Subscription

SubscriptionPause (Pause Periods)
├── id, subscription_id
├── from (date), to (date)
├── Scope: CheckDate
└── BelongsTo: Subscription

SubscriptionLog (Order Tracking)
├── id, subscription_id, order_id, delivery_man_id
├── order_status tracking
└── BelongsTo: Subscription, Order, DeliveryMan

SubscriptionBillingAndRefundHistory (Audit Trail)
├── id, subscription_id
├── transaction_type, transaction_amount
├── created_by (admin/vendor)
└── Financial audit trail
```

## Subscription Scheduling Logic

**Daily Subscription**:
```php
// Create order every day
SubscriptionSchedule::create([
    'subscription_id' => $subscription->id,
    'type' => 'daily',
]);

// Cron job (daily):
$active_subs = Subscription::where('status', 'active')
    ->whereHas('schedules', fn($q) => $q->where('type', 'daily'))
    ->whereDate('start_at', '<=', now())
    ->whereDate('end_at', '>=', now())
    ->whereDoesntHave('pauses', fn($q) => $q->whereDate('from', '<=', now())->whereDate('to', '>=', now()))
    ->get();

foreach ($active_subs as $sub) {
    // Create order for today
    createSubscriptionOrder($sub);
}
```

**Weekly Subscription**:
```php
// Deliver on specific days (e.g., Monday, Wednesday, Friday)
SubscriptionSchedule::create(['subscription_id' => $id, 'type' => 'weekly', 'day' => 1]); // Monday
SubscriptionSchedule::create(['subscription_id' => $id, 'type' => 'weekly', 'day' => 3]); // Wednesday
SubscriptionSchedule::create(['subscription_id' => $id, 'type' => 'weekly', 'day' => 5]); // Friday

// Cron job:
$today_day = now()->dayOfWeek; // 0-6
$weekly_subs = Subscription::where('status', 'active')
    ->whereHas('schedules', fn($q) => $q->where('type', 'weekly')->where('day', $today_day))
    ->whereNot('is_paused_today')
    ->get();
```

**Monthly Subscription**:
```php
// Deliver on specific date each month (e.g., 1st and 15th)
SubscriptionSchedule::create(['subscription_id' => $id, 'type' => 'monthly', 'day' => 1]);
SubscriptionSchedule::create(['subscription_id' => $id, 'type' => 'monthly', 'day' => 15]);

// Cron job:
$today_date = now()->day;
$monthly_subs = Subscription::where('status', 'active')
    ->whereHas('schedules', fn($q) => $q->where('type', 'monthly')->where('day', $today_date))
    ->get();
```

## Pause Functionality

```php
// Pause subscription (vacation mode)
SubscriptionPause::create([
    'subscription_id' => $subscription->id,
    'from' => '2025-12-20',
    'to' => '2026-01-05',
]);

// Model scope
public function getIsPausedTodayAttribute()
{
    return $this->pauses()
        ->whereDate('from', '<=', now())
        ->whereDate('to', '>=', now())
        ->exists();
}

// Dynamic status
public function getDynamicStatusAttribute()
{
    if ($this->is_paused_today) return 'paused';
    if ($this->end_at < now()) return 'expired';
    if ($this->status === 'active') return 'active';
    return $this->status;
}
```

---
