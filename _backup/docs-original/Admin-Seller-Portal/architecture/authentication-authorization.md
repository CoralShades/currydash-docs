# Authentication & Authorization

## JWT Token-Based Authentication

**Purpose**: Stateless authentication for mobile/web API clients

**Flow**:

```mermaid
sequenceDiagram
    participant C as Mobile/Web Client
    participant A as API (/api/v1/auth)
    participant D as Database

    C->>A: POST /auth/login (email, password)
    A->>D: Verify credentials
    D-->>A: User found
    A->>A: Generate JWT tokens
    A-->>C: {access_token, refresh_token, user}

    C->>A: GET /packages (Authorization: Bearer {access_token})
    A->>A: Validate JWT
    A->>D: Fetch packages
    D-->>A: Package data
    A-->>C: JSON response

    Note over C,A: Token expires after 24 hours

    C->>A: POST /auth/refresh (refresh_token)
    A->>A: Validate refresh token
    A->>A: Generate new access_token
    A-->>C: {access_token}
```

## Authentication Guards

**Configuration**: `config/auth.php`

```php
'guards' => [
    'web' => [
        'driver' => 'session',
        'provider' => 'users',
    ],

    'api' => [
        'driver' => 'jwt',
        'provider' => 'users',  // Customer API
    ],

    'admin' => [
        'driver' => 'jwt',
        'provider' => 'admins',
    ],

    'vendor' => [
        'driver' => 'jwt',
        'provider' => 'vendors',
    ],
],

'providers' => [
    'users' => [
        'driver' => 'eloquent',
        'model' => App\Models\User::class,
    ],

    'admins' => [
        'driver' => 'eloquent',
        'model' => App\Models\Admin::class,
    ],

    'vendors' => [
        'driver' => 'eloquent',
        'model' => App\Models\Vendor::class,
    ],
],
```

## Middleware Protection

**Route Protection**:
```php
// Customer API routes (PACK, CCW)
Route::middleware('auth:api')->group(function () {
    Route::get('/profile', [ProfileController::class, 'show']);
    Route::post('/cart', [CartController::class, 'store']);
    Route::post('/orders', [OrderController::class, 'store']);
});

// Admin routes (CAD)
Route::middleware('auth:admin')->group(function () {
    Route::get('/dashboard', [DashboardController::class, 'index']);
    Route::post('/vendors/approve/{id}', [VendorController::class, 'approve']);
});

// Vendor routes (CAR)
Route::middleware('auth:vendor')->group(function () {
    Route::get('/orders', [VendorOrderController::class, 'index']);
    Route::post('/packages', [VendorPackageController::class, 'store']);
});
```

## Role-Based Access Control (RBAC)

**Roles**:
- **Customer** (User model) - Can order, customize packages, manage subscriptions
- **Vendor** (Vendor model) - Can manage menu, fulfill orders, view analytics
- **Admin** (Admin model) - Can manage platform, approve vendors, resolve disputes

**Permission Levels** (Admin):
```php
// app/Models/Admin.php
const ROLES = [
    'super_admin' => 'Full platform access',
    'admin' => 'Standard admin access',
    'moderator' => 'Content moderation only',
];

public function hasPermission($permission)
{
    return in_array($permission, $this->permissions ?? []);
}
```

---
