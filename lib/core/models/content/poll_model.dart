import 'package:waultar/core/models/base_model.dart';
import 'package:waultar/core/models/profile/profile_model.dart';

class PollModel extends BaseModel {
  
  String? question;
  bool isUsers;

  // store options in as raw json
  String? options;
  DateTime? timestamp;

  PollModel({
    int id = 0, 
    required ProfileModel profile,
    required String raw,
    this.question,
    this.isUsers = false,
    this.options,
    this.timestamp,
  }) : super(id, profile, raw);
  
}