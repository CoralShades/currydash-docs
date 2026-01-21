# File Storage & CDN

## Storage Configuration

**Location**: `config/filesystems.php`

```php
'disks' => [
    'local' => [
        'driver' => 'local',
        'root' => storage_path('app'),
    ],

    'public' => [
        'driver' => 'local',
        'root' => storage_path('app/public'),
        'url' => env('APP_URL').'/storage',
        'visibility' => 'public',
    ],

    's3' => [
        'driver' => 's3',
        'key' => env('AWS_ACCESS_KEY_ID'),
        'secret' => env('AWS_SECRET_ACCESS_KEY'),
        'region' => env('AWS_DEFAULT_REGION'),
        'bucket' => env('AWS_BUCKET'),
        'url' => env('AWS_URL'),
    ],

    'spaces' => [
        'driver' => 's3',
        'key' => env('DO_SPACES_KEY'),
        'secret' => env('DO_SPACES_SECRET'),
        'endpoint' => env('DO_SPACES_ENDPOINT'),
        'region' => env('DO_SPACES_REGION'),
        'bucket' => env('DO_SPACES_BUCKET'),
    ],
],
```

## Storage Model (Polymorphic)

**Purpose**: Track which cloud provider stores each file

```php
// app/Models/Storage.php
class Storage extends Model
{
    protected $table = 'storage';

    // Polymorphic relationship
    public function data()
    {
        return $this->morphTo();
    }

    // data_type: Package, Restaurant, Food, etc.
    // data_id: ID of the entity
    // key: 'image', 'logo', 'cover', etc.
    // value: 'public', 's3', 'spaces'
}

// Usage:
Storage::create([
    'data_type' => 'Package',
    'data_id' => $package->id,
    'key' => 'image',
    'value' => 'public', // or 's3' or 'spaces'
]);
```

## Dynamic URL Generation

**Location**: `app/CentralLogics/helpers.php`

```php
class Helpers
{
    public static function get_full_url($type, $filename, $storage_disk = 'public')
    {
        $base_urls = [
            'public' => url('/storage'),
            's3' => env('AWS_URL'),
            'spaces' => env('DO_SPACES_URL'),
        ];

        $base_url = $base_urls[$storage_disk] ?? $base_urls['public'];

        return $base_url . '/' . $type . '/' . $filename;
    }
}

// Model accessor
public function getImageFullUrlAttribute()
{
    $storage_disk = $this->storage()->where('key', 'image')->first()->value ?? 'public';
    return Helpers::get_full_url('package', $this->image, $storage_disk);
}
```

## File Upload Locations

| File Type | Path | Default Disk | Models |
|-----------|------|--------------|--------|
| Package images | package/ | public/s3 | Package |
| Restaurant logo | restaurant/ | public/s3 | Restaurant |
| Restaurant cover | restaurant/ | public/s3 | Restaurant |
| Food images | food/ | public/s3 | Food |
| Admin images | admin/ | public | Admin |
| User avatars | profile/ | public/s3 | User |
| Banner images | banner/ | public/s3 | Banner |
| Category images | category/ | public/s3 | Category |
| Order proofs | order/ | public/s3 | Order |

## Upload Helper

**Location**: `app/CentralLogics/filemanager.php`

```php
class FileManagerLogic
{
    public static function upload($dir, $format, $image, $disk = 'public')
    {
        $imageName = Carbon::now()->toDateString() . '-' . uniqid() . '.' . $format;

        if ($disk === 's3') {
            $path = Storage::disk('s3')->putFileAs($dir, $image, $imageName);
        } else if ($disk === 'spaces') {
            $path = Storage::disk('spaces')->putFileAs($dir, $image, $imageName);
        } else {
            $image->storeAs('public/' . $dir, $imageName);
        }

        return $imageName;
    }
}
```

---
