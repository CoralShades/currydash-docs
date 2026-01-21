# Design Patterns

## Model-View-Controller (MVC)

Laravel's default pattern:

```
Request → Route → Controller → Model → Database
                      ↓
                    View (Blade template for admin/vendor dashboards)
                      OR
                    JSON (for API endpoints)
```

## Controller → Model Pattern (Simplified)

**Used in**: Simple CRUD operations

**Example**: Package listing
```php
// Route
Route::get('/packages', [PackageController::class, 'index']);

// Controller (app/Http/Controllers/Api/V1/PackageController.php)
public function index(Request $request)
{
    $packages = Package::where('restaurant_id', $request->restaurant_id)
        ->with(['configurations.options.food'])
        ->get();

    return response()->json($packages);
}

// Model (app/Models/Package.php)
class Package extends Model
{
    public function configurations()
    {
        return $this->hasMany(PackageConfiguration::class)->orderBy('sort_order');
    }
}
```

## Repository Pattern (Emerging)

**Status**: Not fully implemented, but recommended for complex queries

**When to Use**: Complex business logic, multiple data sources, testability

**Example Structure** (if implemented):
```php
// Interface
interface PackageRepositoryInterface
{
    public function findByRestaurant($restaurantId);
    public function createWithConfigurations(array $data);
}

// Implementation
class PackageRepository implements PackageRepositoryInterface
{
    public function findByRestaurant($restaurantId)
    {
        return Package::where('restaurant_id', $restaurantId)
            ->with(['configurations.options.food'])
            ->get();
    }
}

// Controller
class PackageController extends Controller
{
    protected $packageRepo;

    public function __construct(PackageRepositoryInterface $packageRepo)
    {
        $this->packageRepo = $packageRepo;
    }

    public function index(Request $request)
    {
        $packages = $this->packageRepo->findByRestaurant($request->restaurant_id);
        return response()->json($packages);
    }
}
```

**Registration** (in `app/Providers/AppServiceProvider.php`):
```php
public function register()
{
    $this->app->bind(
        PackageRepositoryInterface::class,
        PackageRepository::class
    );
}
```

## Observer Pattern

**Purpose**: Respond to model events (creating, created, updating, updated, deleting, deleted)

**Example**: `app/Observers/OrderObserver.php`
```php
class OrderObserver
{
    public function created(Order $order)
    {
        // Send notification to vendor
        // Log order creation
        // Update restaurant statistics
    }

    public function updated(Order $order)
    {
        // Notify customer of status change
        // Log status history
    }
}
```

**Registration** (in `app/Providers/EventServiceProvider.php`):
```php
public function boot()
{
    Order::observe(OrderObserver::class);
}
```

---
