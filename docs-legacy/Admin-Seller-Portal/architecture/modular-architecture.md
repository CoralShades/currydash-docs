# Modular Architecture

## Laravel Modules (nWidart)

**Package**: `nwidart/laravel-modules`

**Purpose**: Organize large applications into self-contained modules

**Module Status** (`modules_statuses.json`):
```json
{
    "TaxModule": true,
    "PaymentModule": true,
    "NotificationModule": false
}
```

## Creating a New Module

```bash
# Generate module scaffold
php artisan module:make ModuleName

# Generate controller within module
php artisan module:make-controller ControllerName ModuleName

# Generate model within module
php artisan module:make-model ModelName ModuleName

# Generate migration within module
php artisan module:make-migration create_table_name ModuleName
```

## Module Best Practices

1. **Single Responsibility**: Each module handles one business capability
2. **Self-Contained**: Module should work independently
3. **Clear Interfaces**: Define contracts for inter-module communication
4. **Avoid Direct Dependencies**: Use service providers and dependency injection

---
