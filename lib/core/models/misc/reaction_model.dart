import 'package:waultar/core/models/profile/profile_model.dart';

import '../base_model.dart';

class ReactionModel extends BaseModel {
  final String reaction;

  ReactionModel(int id, ProfileModel profile, String raw, this.reaction)
      : super(id, profile, raw);
}
