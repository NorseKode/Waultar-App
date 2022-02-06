
import 'package:drift/drift.dart';
import 'package:waultar/core/models/index.dart';
import 'package:waultar/data/configs/drift_config.dart';

ImageEntityCompanion toImageCompanion(ImageModel image) {
  return const ImageEntityCompanion(
    // path: Value(image.path),
    // raw: Value(image.raw),
    // timestamp: Value(image.timestamp)
  );
}

AppSettingsEntityCompanion toAppSettingsCompanion(AppSettingsModel appSettings) {
  return AppSettingsEntityCompanion(
    darkmode: Value(appSettings.darkmode)
  );
}

ProfileEntityCompanion toProfileCompanion(ProfileModel profile) {
  return ProfileEntityCompanion(
    username: Value(profile.username),
    name: Value(profile.name),
    email: Value(profile.email),
    gender: Value(profile.gender),
    bio: Value(profile.bio),
    phoneNumber: Value(profile.phoneNumber),
    dateOfBirth: Value(profile.dateOfBirth),
    profileUri: Value(profile.profileUri),
    raw: Value(profile.raw)
  );
}