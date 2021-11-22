# DRIFT

## Declaring tables

## Queries

### Querying with native SQL

### Querying with the drift API

## Migrations

If you change or add table definitions, you MUST increment the schemaversion in our drift_configs. Just increment the version [here](../lib/db/drift_config.dart)

```dart
@override 
int get schemaVersion => 1;
```

To run migrations :

```bash
flutter packages pub run build_runner build
```

If there are conflicts, try :

```bash
flutter packages pub run build_runner build --delete-conflicting-outputs
```

## Testing
