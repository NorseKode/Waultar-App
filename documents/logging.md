# Logging

see following example
```dart
import 'package:waultar/configs/globals/app_logger.dart';

var appLogger = locator.get<AppLogger>(instanceName: 'logger');

var message = "example";
appLogger.logger.info("unknown data: $message");
```
