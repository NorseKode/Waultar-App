import 'package:hive/hive.dart';
part 'settings.g.dart';

@HiveType(adapterName: 'SettingsAdapter', typeId: 3)
class Settings {
  @HiveField(0)
  final bool darkModeEnabled;

  @HiveField(1)
  final bool firstTimeAppUser;

  @HiveField(2)
  final String ?email;

  @HiveField(3)
  final String key = 'settings';

  Settings({this.darkModeEnabled = false, this.firstTimeAppUser = true, this.email});
}
