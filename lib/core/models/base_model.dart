import 'package:waultar/core/models/profile/profile_model.dart';
import 'package:waultar/core/models/ui_model.dart';

abstract class BaseModel {  
  int id = 0;
  final ProfileModel profile;
  final String raw;

  BaseModel(this.id, this.profile, this.raw);

  @override
  Map<String, String> toMap() {
    return {
      "profile": profile.toString()
    };
  }
}
