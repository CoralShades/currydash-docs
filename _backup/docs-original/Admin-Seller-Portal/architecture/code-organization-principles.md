# Code Organization Principles

## 1. Single Responsibility Principle

Each class should have one reason to change:

**Good**:
```php
// PackageController - handles HTTP requests/responses
// PackageService - handles business logic
// Package Model - handles data representation
```

**Avoid**:
```php
// PackageController doing business logic, validation, notification - too many responsibilities
```

## 2. Dependency Injection

Inject dependencies via constructor:

```php
class PackageController extends Controller
{
    protected $packageService;

    public function __construct(PackageService $packageService)
    {
        $this->packageService = $packageService;
    }

    public function store(Request $request)
    {
        return $this->packageService->create($request->all());
    }
}
```

## 3. Eloquent Relationships

Use Eloquent relationships instead of manual joins:

**Good**:
```php
$packages = Package::with(['configurations.options.food'])
    ->where('restaurant_id', $restaurantId)
    ->get();
```

**Avoid**:
```php
$packages = DB::table('packages')
    ->join('package_configurations', ...)
    ->join('package_options', ...)
    ->join('food', ...)
    ->get();
```

## 4. Query Scopes

Reusable query logic in model scopes:

```php
// In Package model
public function scopeActive($query)
{
    return $query->where('status', true);
}

public function scopeByRestaurant($query, $restaurantId)
{
    return $query->where('restaurant_id', $restaurantId);
}

// Usage
$packages = Package::active()->byRestaurant($restaurantId)->get();
```

## 5. Form Request Validation

Separate validation logic:

```php
// app/Http/Requests/PackageStoreRequest.php
class PackageStoreRequest extends FormRequest
{
    public function rules()
    {
        return [
            'restaurant_id' => 'required|exists:restaurants,id',
            'name' => 'required|string|max:255',
            'base_price' => 'required|numeric|min:0',
            'configurations' => 'required|array|min:1',
        ];
    }
}

// Controller
public function store(PackageStoreRequest $request)
{
    // Validation already done, $request->validated() contains clean data
}
```

---
