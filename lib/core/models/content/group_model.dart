import 'package:waultar/core/models/base_model.dart';
import 'package:waultar/core/models/profile/profile_model.dart';

class GroupModel extends BaseModel {
  String name;
  bool isUsers;
  String? badge;
  DateTime? timestamp;

  GroupModel({
    int id = 0,
    required ProfileModel profile,
    required String raw,
    required this.name,
    this.isUsers = false,
    this.badge,
    this.timestamp,
  }) : super(id, profile, raw);

  // GroupModel.fromJson(Map<String, dynamic> json, ProfileModel profile)
  //     : name = json.containsKey("title")
  //           ? json["title"].toString().getGroupName()
  //           : "",
  //       timestamp = json.containsKey("timestamp")
  //           ? DateTime.fromMillisecondsSinceEpoch(json["timestamp"])
  //           : null,
  //       super(0, profile, json.toString());
}

extension GroupName on String {
  String getGroupName() {
    if (this.contains("Du blev medlem af")) {
      return this.replaceFirst("Du blev medlem af ", "");
    }

    if (this.contains("Du er stoppet med at")) {
      return this
          .replaceFirst("Du er stoppet med at v\u00c3\u00a6re medlem af ", "");
    }

    return "";
  }
}
