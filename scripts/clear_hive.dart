import 'package:hive_flutter/hive_flutter.dart';

main() 
async {
  await Hive.initFlutter();
  await Hive.openBox('settings');
  Hive.deleteFromDisk();
}