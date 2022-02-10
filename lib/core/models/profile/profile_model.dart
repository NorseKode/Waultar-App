import 'package:waultar/core/models/misc/activity_model.dart';
import 'package:waultar/core/models/misc/change_model.dart';
import 'package:waultar/core/models/misc/email_model.dart';
import 'package:waultar/core/models/misc/service_model.dart';

class ProfileModel {
  final int id;
  final ServiceModel service;
  final Uri uri;
  final String? username;
  final String fullName;
  final List<EmailModel> emails;
  final bool? gender;
  final String? bio;
  final String? currentCity;
  final String? phoneNumber;
  final bool? isPhoneConfirmed;
  final DateTime createdTimestamp;
  final bool? isPrivate;
  final List<String>? websites;
  final DateTime? dateOfBirth;
  final String? bloodInfo;
  final String? friendPeerGroup;
  final List<ChangeModel>? changes;
  final List<ActivityModel> activities;
  final String? eligibility;
  final String? metadata;
  final String raw;

  ProfileModel({
    this.id = 0, 
    required this.service,
    required this.uri,
    this.username,
    required this.fullName,
    required this.emails,
    this.gender,
    this.bio,
    this.currentCity,
    this.phoneNumber,
    this.isPhoneConfirmed,
    required this.createdTimestamp,
    this.isPrivate,
    this.websites,
    this.dateOfBirth,
    this.bloodInfo,
    this.friendPeerGroup,
    this.changes,
    required this.activities,
    this.eligibility,
    this.metadata,
    required this.raw,
  });
}

// import 'package:waultar/core/models/base_model.dart';
// import 'package:waultar/core/models/profile_model.dart';
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
//     required profileModel profile, 
//     required String raw,

//   }) : super(id, profile, raw);


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
