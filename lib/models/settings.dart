import 'package:hive/hive.dart';
part 'settings.g.dart';

@HiveType(adapterName: 'SettingsAdapter', typeId: 0)
class Settings {
  @HiveField(0)
  final bool darkModeEnabled;

  @HiveField(1)
  final bool firstTimeAppUser;

  @HiveField(2)
  final String ?email;

  Settings({this.darkModeEnabled = false, this.firstTimeAppUser = true, this.email});
}
