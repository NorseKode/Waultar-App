import 'package:waultar/core/models/base_model.dart';
import 'package:waultar/core/models/service_model.dart';

class PollModel extends BaseModel {
  
  String? question;
  bool isUsers;

  // store options in as raw json
  String? options;

  PollModel({
    int id = 0, 
    required ServiceModel service,
    required String raw,
    this.question,
    this.isUsers = false,
    this.options,
  }) : super(id, service, raw);
  
}