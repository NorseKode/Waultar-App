import 'package:waultar/core/models/base_model.dart';
import 'package:waultar/core/models/service_model.dart';

class GroupModel extends BaseModel {

  String name;
  bool isUsers;
  String? badge;
  DateTime? timestamp;

  GroupModel({
    int id = 0, 
    required ServiceModel service,
    required String raw,
    required this.name,
    this.isUsers = false,
    this.badge,
    this.timestamp,
  }) : super(id, service, raw);
  
}