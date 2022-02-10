// import 'package:waultar/core/models/base_model.dart';
// import 'package:waultar/core/models/service_model.dart';
// import 'package:waultar/core/parsers/parse_helper.dart';

// class ProfileModel extends BaseModel {
//   String username;
//   String name;
//   String email;
//   String gender;
//   String bio;
//   String phoneNumber;
//   DateTime dateOfBirth;
//   String profileUri;

//   ProfileModel({
//     int id = 0, 
//     required ServiceModel service, 
//     required String raw,

//   }) : super(id, service, raw);


//   // ProfileModel._fromJson(Map<String, dynamic> json)
//   //     : id = null,
//   //       username = ParseHelper.trySeveralNames(json, ["Username"]),
//   //       name = ParseHelper.trySeveralNames(json, ["full_name"]),
//   //       email = ParseHelper.trySeveralNames(json, ["emails", "Email"]),
//   //       gender = ParseHelper.trySeveralNames(json, ["gender_option", "Gender"]),
//   //       bio = ParseHelper.trySeveralNames(json, ["Bio"]),
//   //       phoneNumber = ParseHelper.trySeveralNames(json, ["phone_number"]),
//   //       dateOfBirth = DateTime
//   //           .now(), // DateTime.parse(ParseHelper.trySeveralNames(json, [])),
//   //       profileUri = ParseHelper.trySeveralNames(json, ["profile_uri"]),
//   //       raw = json.toString();

//   ProfileModel fromJson(var json) {
//     return ProfileModel._fromJson(json);
//   }
  
//   static ProfileModel fromJson2(var json) {
//     return ProfileModel._fromJson(json);
//   }

//   // @override
//   // String toString() {
//   //   return "id: $id, path: $path, timestamp: $timestamp";
//   // }
// }
