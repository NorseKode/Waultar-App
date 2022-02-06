import 'package:objectbox/objectbox.dart';
import 'package:waultar/core/abstracts/abstract_repositories/i_appsettings_repository.dart';
import 'package:waultar/core/models/appsettings_model.dart';
import 'package:waultar/data/configs/objectbox.dart';
import 'package:waultar/data/entities/appsettings_entity.dart';
import 'package:waultar/startup.dart';

class AppSettingsRepository implements IAppSettingsRepository {
  // final ObjectBox context = locator<ObjectBox>(instanceName: 'context');
  late final ObjectBox _context;
  late final Box<AppSettingsBox> _appSettingsBox;

  AppSettingsRepository(ObjectBox context) {
    _context = context;
    _appSettingsBox = _context.store.box<AppSettingsBox>();
  }

  @override
  AppSettingsModel getSettings() {
    var settings = _appSettingsBox.get(1);
    return settings!.toModel();
  }

  @override
  Future updateSettings(AppSettingsModel appSettings) async {
    _appSettingsBox
        .putAsync(AppSettingsBox(1, appSettings.darkmode));
  }

  @override
  Stream<AppSettingsModel> watchSettings() async* {
    var stream = _appSettingsBox.query().build().stream();
    await stream.forEach((setting) => setting.toModel());
  }
}
