import 'package:objectbox/objectbox.dart';
import 'package:waultar/core/abstracts/abstract_repositories/i_appsettings_repository.dart';
import 'package:waultar/core/models/misc/appsettings_model.dart';
import 'package:waultar/data/configs/objectbox.dart';
import 'package:waultar/data/entities/misc/appsettings_entity.dart';

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
    var settings = _appSettingsBox.get(1)!;
    return AppSettingsModel(settings.id, settings.darkmode);
  }

  @override
  Future updateSettings(AppSettingsModel appSettings) async {
    var settings = _appSettingsBox.get(1)!;
    settings.darkmode = appSettings.darkmode;

    int id = await _appSettingsBox.putAsync(settings);
    
    if (id != 1) {
      throw ObjectBoxException(
          'AppSettings did not update, but instead created a new entry');
    }
  }

  @override
  Stream<AppSettingsModel> watchSettings() async* {
    var stream = _appSettingsBox.query().build().stream();
    await stream.forEach((setting) => setting.toModel());
  }
}
