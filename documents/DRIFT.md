# DRIFT

## Declaring tables

Table names should be as :

```dart
class Foos extends Table {..}
```

the generated dart object will then be named `Foo` automatically without the plural indicating "s".

If you want to specify object name :

```dart
@DataClassName('Configs')
class Configurations extends Table {..}
```

In order to maintain readability, we should decorate all tables with custom data class names. Note, that Drift will ALWAYS strip away the trailing "s" if no custom decoration is applied, so in many cases it will be necessary to provide custom naming anyway - for instance, `Categories` would become `Categorie` which is just stupid. Also Note, that the data class name and table name CANNOT be the same.

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

If there are conflicts, try (just use this one always) :

```bash
flutter packages pub run build_runner build --delete-conflicting-outputs
```

## Testing
