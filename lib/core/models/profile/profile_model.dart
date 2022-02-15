import 'package:waultar/core/models/misc/activity_model.dart';
import 'package:waultar/core/models/misc/change_model.dart';
import 'package:waultar/core/models/misc/email_model.dart';
import 'package:waultar/core/models/misc/service_model.dart';
import 'package:waultar/core/models/model_helper.dart';

class ProfileModel {
  final int id;
  late ServiceModel service;
  final Uri uri;
  final String? username;
  final String fullName;
  List<String>? otherNames;
  final List<EmailModel> emails;
  final String? gender;
  final String? bio;
  final String? currentCity;
  List<String>? phoneNumbers;
  final bool? isPhoneConfirmed;
  final DateTime createdTimestamp;
  final bool? isPrivate;
  final List<String>? websites;
  DateTime? dateOfBirth;
  final String? bloodInfo;
  final String? friendPeerGroup;
  final List<ChangeModel>? changes;
  final List<ActivityModel> activities;
  final String? eligibility;
  List<String>? metadata;
  final String raw;

  ProfileModel({
    this.id = 0,
    required this.service,
    required this.uri,
    this.username,
    required this.fullName,
    this.otherNames,
    required this.emails,
    this.gender,
    this.bio,
    this.currentCity,
    this.phoneNumbers,
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

  ProfileModel.fromJson(Map<String, dynamic> json)
      : id = 0,
        uri = Uri(path: json["profile_uri"]),
        username = json["username"],
        fullName = (json["name"])["full_name"],
        // TODO
        otherNames = <String>[],
        emails = <EmailModel>[],
        gender = (json["gender"])["gender_option"],
        // TODO
        bio = json["bio"],
        currentCity = (json["current_city"])["name"],
        phoneNumbers = <String>[],
        // TODO
        isPhoneConfirmed = false,
        createdTimestamp = ModelHelper.intToTimestamp(json["registration_timestamp"]) ??
            DateTime.fromMicrosecondsSinceEpoch(0),
        // TODO
        isPrivate = false,
        // TODO
        websites = null,
        bloodInfo = json["blood_info"].toString(),
        // TODO
        friendPeerGroup = json["TODO"],
        // TODO
        changes = <ChangeModel>[],
        // TODO
        activities = <ActivityModel>[],
        // TODO
        eligibility = json["TODO"],
        // TODO
        metadata = <String>[],
        raw = json.toString() {
    if (json.containsKey("birthday")) {
      var birthdayObject = json["birthday"];
      dateOfBirth =
          DateTime.utc(birthdayObject["year"], birthdayObject["month"], birthdayObject["day"]);
    }

    if (json.containsKey("family_members")) {
      metadata!.addAll(json["family_members"].map<String>((element) => element.toString()));
    }
    if (json.containsKey("previous_relationships")) {
      metadata!.addAll(json["previous_relationships"].map<String>((element) => element.toString()));
    }
    if (json.containsKey("pages")) {
      metadata!.addAll(json["pages"].map<String>((element) => element.toString()));
    }

    if (json.containsKey("other_names")) {
      otherNames =
          (json["other_names"]).map<String>((element) => element["name"].toString()).toList();
    }
    if (json.containsKey("phone_numbers")) {
      phoneNumbers = (json["phone_numbers"])
          .map<String>((element) => element["phone_number"].toString())
          .toList();
    }

    // TODO
    service = ServiceModel(0, 'name', 'company', Uri(path: 'image'));
  }
}
