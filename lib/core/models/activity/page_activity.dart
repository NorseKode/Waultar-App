import 'package:waultar/core/models/base_model.dart';
import 'package:waultar/core/models/content/page_model.dart';
import 'package:waultar/core/models/profile/profile_model.dart';

class PageActivity extends BaseModel {
  final DateTime timestamp;
  final Activity activity;
  final PageModel page;
  PageActivity(
      int id, ProfileModel profile, String raw, this.timestamp, this.activity, this.page)
      : super(id, profile, raw);
}

enum Activity { like, unlike, follow, unfollow }
