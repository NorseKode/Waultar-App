import 'package:waultar/core/models/media/media_model.dart';
import 'package:waultar/core/models/misc/activity_model.dart';
import 'package:waultar/core/models/misc/change_model.dart';
import 'package:waultar/core/models/misc/email_model.dart';
import 'package:waultar/core/models/misc/service_model.dart';
import 'package:waultar/core/models/model_helper.dart';

class ProfileModel {
  int id;
  late ServiceModel service;
  Uri uri;
  String? username;
  String fullName;
  MediaModel? profilePicture;
  List<String>? otherNames;
  List<EmailModel> emails;
  String? gender;
  String? bio;
  String? currentCity;
  List<String>? phoneNumbers;
  bool? isPhoneConfirmed;
  DateTime createdTimestamp;
  bool? isPrivate;
  List<String>? websites;
  DateTime? dateOfBirth;
  String? bloodInfo;
  String? friendPeerGroup;
  List<ChangeModel>? changes;
  List<ActivityModel> activities;
  String? eligibility;
  List<String>? metadata;
  String raw;

  ProfileModel({
    this.id = 0,
    required this.service,
    required this.uri,
    this.username,
    required this.fullName,
    this.profilePicture,
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

  ProfileModel.fromFacebook(Map<String, dynamic> json)
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
    service = ServiceModel(id: 0, name: 'name', company: 'company', image: Uri(path: 'image'));
  }

  static dynamic _tempData;

  static dynamic instagramDataValuesHelper(var json, String key) {
    _tempData ??= json["string_map_data"];

    if (_tempData.containsKey(key)) {
      return (_tempData[key])["value"];
    } else {
      return null;
    }
  }

  ProfileModel.fromInstragram(Map<String, dynamic> json)
      : id = 0,
        uri = Uri(path: ""),
        username = instagramDataValuesHelper(json, "Username"),
        fullName = instagramDataValuesHelper(json, "Name"),
        otherNames = null,
        // TODO
        emails = <EmailModel>[],
        gender = instagramDataValuesHelper(json, "Gender"),
        // TODO
        bio = instagramDataValuesHelper(json, "Bio"),
        currentCity = instagramDataValuesHelper(json, "City Name"),
        phoneNumbers = <String>[instagramDataValuesHelper(json, "Phone Number")],
        isPhoneConfirmed =
            instagramDataValuesHelper(json, "Phone Confirmed").toLowerCase() == "true"
                ? true
                : instagramDataValuesHelper(json, "Phone Confirmed").toLowerCase() == "false"
                    ? false
                    : null,
        createdTimestamp = DateTime.fromMicrosecondsSinceEpoch(0),
        isPrivate = instagramDataValuesHelper(json, "Private Account").toLowerCase() == "true"
            ? true
            : instagramDataValuesHelper(json, "Private Account").toLowerCase() == "false"
                ? false
                : null,
        websites = [instagramDataValuesHelper(json, "Website")],
        bloodInfo = null,
        friendPeerGroup = null,
        // TODO
        changes = <ChangeModel>[],
        // TODO
        activities = <ActivityModel>[],
        // TODO
        eligibility = null,
        // TODO
        metadata = <String>[],
        raw = json.toString() {
    var jsonMapData = json["string_map_data"];

    if (jsonMapData.containsKey("Date of birth")) {
      var value = (jsonMapData["Date of birth"])["value"].toString();
      var birthdayObject = value.split("-");
      dateOfBirth = DateTime.utc(
          int.parse(birthdayObject[0]), int.parse(birthdayObject[1]), int.parse(birthdayObject[2]));
    }

    if (jsonMapData.containsKey("Phone Confirmation Method")) {
      metadata!.add(jsonMapData["Phone Confirmation Method"].toString());
    }

    // if (json.containsKey("media_map_data")) {
    //   profilePicture = ImageModel.fromJson((json["media_map_data"])["Profile Photo"], this);
    // }

    // TODO
    service = ServiceModel(id: 0, name: 'name', company: 'company', image: Uri(path: 'image'));
  }

  @override
  String toString() {
    return "username: $username, fullname: $fullName";
  }
}
