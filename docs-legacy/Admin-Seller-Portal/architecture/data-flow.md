# Data Flow

## Typical API Request Flow

```
1. HTTP Request → routes/api/v1/api.php
2. Route → Controller (app/Http/Controllers/Api/V1/)
3. Controller → Validate Request (FormRequest or manual)
4. Controller → Call Model or Service
5. Model → Query Database (Eloquent ORM)
6. Database → Return Data
7. Controller → Format Response (JSON Resource or array)
8. HTTP Response → Client
```

## Example: Creating a Package

```php
// 1. Route (routes/vendor.php)
Route::post('/packages', [VendorPackageController::class, 'store'])
    ->middleware('auth:vendor');

// 2. Controller (app/Http/Controllers/Vendor/PackageController.php)
public function store(PackageStoreRequest $request)
{
    // 3. Validation already done by PackageStoreRequest

    // 4. Create package
    $package = Package::create([
        'restaurant_id' => auth('vendor')->user()->restaurant_id,
        'name' => $request->name,
        'description' => $request->description,
        'base_price' => $request->base_price,
        'status' => false, // Pending admin approval
    ]);

    // 5. Create configurations
    foreach ($request->configurations as $configData) {
        $config = $package->configurations()->create([
            'group_title' => $configData['group_title'],
            'min_choices' => $configData['min_choices'],
            'max_choices' => $configData['max_choices'],
        ]);

        // 6. Create options
        foreach ($configData['options'] as $optionData) {
            $config->options()->create([
                'food_id' => $optionData['food_id'],
                'additional_charge' => $optionData['additional_charge'],
            ]);
        }
    }

    // 7. Return response
    return response()->json([
        'message' => 'Package created successfully. Pending admin approval.',
        'package' => $package->load('configurations.options.food'),
    ], 201);
}
```

---
