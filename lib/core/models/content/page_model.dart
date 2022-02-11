import 'package:waultar/core/models/base_model.dart';
import 'package:waultar/core/models/profile/profile_model.dart';

class PageModel extends BaseModel {
  final String name;
  final bool isUsers;

  // only if isUsers == true
  final Uri? uri;

  PageModel({
    int id = 0, 
    required ProfileModel profile, 
    required String raw,
    required this.name,
    required this.isUsers,
    this.uri,
  }) : super(id, profile, raw);
  
}