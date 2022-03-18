abstract class IAppSettingsService {
  bool getDarkMode();
  Future toogleDarkMode(bool darkMode);
  Future<void> toggleIsPerformanceTracking(bool value);
}
