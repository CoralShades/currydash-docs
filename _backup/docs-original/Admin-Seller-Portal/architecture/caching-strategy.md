# Caching Strategy

## Current Implementation

**Configuration**: `config/cache.php`

```php
'default' => env('CACHE_DRIVER', 'file'),

'stores' => [
    'file' => [
        'driver' => 'file',
        'path' => storage_path('framework/cache/data'),
    ],

    'redis' => [
        'driver' => 'redis',
        'connection' => 'cache',
        'lock_connection' => 'default',
    ],
],
```

**Current Usage** (Ad-hoc approach):
```php
// Business settings caching
public static function getWebConfig($key)
{
    return Cache::remember('business_setting_' . $key, 3600, function() use ($key) {
        return BusinessSetting::where('key', $key)->first()->value;
    });
}

// Limited selective caching
// No systematic cache invalidation strategy
```

**Issues**:
- ❌ No cache layer for expensive queries
- ❌ No systematic cache invalidation
- ❌ Limited Redis usage
- ❌ No query result caching
- ❌ No page/fragment caching

## Recommended Caching Strategy

**Proposed Implementation**:

```php
// Cache restaurant catalog
public function index()
{
    $cache_key = 'restaurants_zone_' . auth()->user()->zone_id . '_page_' . request('page', 1);

    $restaurants = Cache::remember($cache_key, 3600, function() {
        return Restaurant::with('food', 'packages')
            ->active()
            ->paginate(20);
    });

    return response()->json($restaurants);
}

// Cache invalidation on update
public function update(Restaurant $restaurant)
{
    $restaurant->update($request->all());

    // Clear zone cache
    Cache::forget('restaurants_zone_' . $restaurant->zone_id . '_*');

    // Clear restaurant-specific cache
    Cache::forget('restaurant_' . $restaurant->id);
}

// Cache package catalog
public function getPackages($restaurant_id)
{
    return Cache::remember('packages_restaurant_' . $restaurant_id, 3600, function() use ($restaurant_id) {
        return Package::where('restaurant_id', $restaurant_id)
            ->with('configurations.options.food')
            ->active()
            ->get();
    });
}
```

**Cache Invalidation Events**:
```php
// Model observer
class PackageObserver
{
    public function updated(Package $package)
    {
        Cache::forget('packages_restaurant_' . $package->restaurant_id);
        Cache::forget('package_' . $package->id);
    }
}
```

---
