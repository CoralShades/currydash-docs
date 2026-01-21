# Notification System

## Multi-Channel Architecture

CurryDash implements a **multi-channel notification system**:

**Channels**:
```
1. Push Notifications (Firebase Cloud Messaging)
2. Email (SMTP, Laravel Mail)
3. SMS (Nexmo, Twilio)
4. In-App Notifications (Database notifications)
5. Database Logs (Audit trail)
```

## Notification Models

```
Notification (General notifications)
├── id, title, description, image
├── status enum: 'active', 'inactive'
├── tergat: 'customer', 'vendor', 'delivery_man'
├── created_at, updated_at

NotificationMessage (Templated messages)
├── id, title, description
├── order_id, module (order, subscription, etc.)
├── created_at, updated_at

NotificationSetting (Global settings)
├── id, key (e.g., 'order_placed_notification')
├── value boolean (enabled/disabled)

RestaurantNotificationSetting (Per-restaurant)
├── restaurant_id
├── push_notification_for_order
├── push_notification_for_message
├── email_notification_for_order
└── Configuration flags

UserNotification (User-specific in-app)
├── id, user_id, title, description
├── is_read boolean
├── created_at, updated_at
└── BelongsTo: User
```

## Notification Trait

**Location**: `app/Traits/NotificationDataSetUpTrait.php` (300+ lines)

```php
trait NotificationDataSetUpTrait
{
    /**
     * Setup order notification
     */
    public function setup_order_notification($order, $event)
    {
        $notification_data = [
            'title' => "Order #{$order->id} {$event}",
            'description' => "Your order has been {$event}",
            'order_id' => $order->id,
            'image' => $order->restaurant->logo_full_url,
            'type' => 'order',
        ];

        // Send to customer
        if ($order->user) {
            $this->send_push_notification(
                $order->user->firebase_token,
                $notification_data['title'],
                $notification_data['description']
            );

            $this->send_email_notification(
                $order->user->email,
                'order_' . $event,
                ['order' => $order]
            );
        }

        // Send to vendor
        if ($order->restaurant->vendor) {
            $this->send_push_notification(
                $order->restaurant->vendor->firebase_token,
                "New Order #{$order->id}",
                "You have a new order worth ${order->order_amount}"
            );
        }

        // Send to delivery man (if assigned)
        if ($order->delivery_man) {
            $this->send_push_notification(
                $order->delivery_man->firebase_token,
                "Delivery Assignment",
                "You have been assigned order #{$order->id}"
            );
        }
    }

    /**
     * Send push notification via FCM
     */
    public function send_push_notification($fcm_token, $title, $body, $data = [])
    {
        $fcm_credentials = json_decode(file_get_contents(storage_path('app/firebase-credentials.json')), true);

        $notification = [
            'title' => $title,
            'body' => $body,
            'icon' => asset('storage/app/public/logo.png'),
            'click_action' => 'FLUTTER_NOTIFICATION_CLICK',
        ];

        $fcmClient = new FcmClient($fcm_credentials);
        $fcmClient->send($fcm_token, $notification, $data);
    }

    /**
     * Send email notification
     */
    public function send_email_notification($email, $template, $data)
    {
        Mail::to($email)->send(new OrderNotificationMail($template, $data));
    }

    /**
     * Send SMS notification
     */
    public function send_sms_notification($phone, $message)
    {
        // Via SmsGateway trait
        $this->sendSms($phone, $message);
    }
}
```

## Notification Events

**Order Lifecycle**:
```
Order Events → Notifications:
├── placed → Customer, Vendor
├── confirmed → Customer
├── processing → Customer
├── out_for_delivery → Customer, DeliveryMan
├── delivered → Customer, Vendor
├── canceled → Customer, Vendor
└── refunded → Customer
```

**Subscription Events**:
```
Subscription Events → Notifications:
├── created → Customer
├── renewed → Customer, Vendor (restaurant subscription)
├── paused → Customer
├── resumed → Customer
├── canceled → Customer
├── expired → Customer, Vendor
└── payment_failed → Customer
```

---
