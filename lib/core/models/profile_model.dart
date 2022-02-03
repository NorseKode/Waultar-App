import 'package:waultar/core/models/base_model.dart';
import 'package:waultar/core/parsers/parse_helper.dart';

class ProfileModel extends BaseModel {
  final int? id;
  final String? username;
  final String? name;
  final String email;
  final String gender;
  final String bio;
  final String? phoneNumber;
  final DateTime dateOfBirth;
  final String profileUri;
  final String raw;

  ProfileModel(this.id, this.username, this.name, this.email, this.gender, this.bio,
      this.phoneNumber, this.dateOfBirth, this.profileUri, this.raw);

   ProfileModel._fromJson(Map<String, dynamic> json)
      : id = null,
        username = ParseHelper.trySeveralNames(json, ["Username"]),
        name = ParseHelper.trySeveralNames(json, ["full_name"]),
        email = ParseHelper.trySeveralNames(json, []),
        gender = ParseHelper.trySeveralNames(json, []),
        bio = ParseHelper.trySeveralNames(json, []),
        phoneNumber = ParseHelper.trySeveralNames(json, []),
        dateOfBirth = DateTime.now(),// DateTime.parse(ParseHelper.trySeveralNames(json, [])),
        profileUri = ParseHelper.trySeveralNames(json, []),
        raw = json.toString();

  static ProfileModel fromJson(var json) {
    return ProfileModel._fromJson(json);
  }

  // @override
  // String toString() {
  //   return "id: $id, path: $path, timestamp: $timestamp";
  // }
}
