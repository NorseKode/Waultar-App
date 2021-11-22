// import 'package:hive/hive.dart';
// import 'package:hive_flutter/hive_flutter.dart';
// import 'package:waultar/models/settings.dart';
// import 'package:waultar/repositories/index.dart';

// class DbFactory {

//   // DbFactory();

//   Future<void> build() async
//   {
//     await Hive.initFlutter();
//     await openSettings();
//     registerAdapters();
//     initRepos();
//   }

//   late SettingsRepository _settingsRepository;
//   late LazyBox _settingsBox;
//   LazyBox get settingsBox => _settingsBox;
//   Future<void> openSettings() async => _settingsBox = await Hive.openLazyBox('settings');
  
//   void registerAdapters() 
//   {
//     Hive.registerAdapter(SettingsAdapter());
//     // ..
//   }

//   void initRepos() {
//     this._settingsRepository = new SettingsRepository(_settingsBox);
//   }

// }

