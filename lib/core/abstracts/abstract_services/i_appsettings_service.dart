
abstract class IAppSettingsService {
  Future<bool> getDarkMode();
  Future toogleDarkMode(bool darkMode);
}