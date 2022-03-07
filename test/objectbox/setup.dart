import 'dart:io';

import 'package:waultar/core/inodes/inode.dart';
import 'package:waultar/data/configs/objectbox.dart';
import 'package:waultar/data/configs/objectbox.g.dart';

import 'package:path/path.dart' as dart_path;
import 'package:waultar/data/entities/index.dart';
import 'package:waultar/data/entities/misc/service_objectbox.dart';
// import 'objectbox.g.dart';

class ObjectBoxMock implements ObjectBox {
  @override
  late final Store store;

  ObjectBoxMock._create(this.store) {
    // additional setup code here
    final appSettingsBox = store.box<AppSettingsObjectBox>();
    if (appSettingsBox.isEmpty()) {
      var initialAppSettings = AppSettingsObjectBox(0, false);
      appSettingsBox.put(initialAppSettings);
    }

    final _categoryBox = store.box<DataCategory>();
    if (_categoryBox.count() == 0) {
      var listToAdd = <DataCategory>[];

      var interactions = DataCategory(name: "Interactions", matchingFolders: [
        "activity_messages",
        "polls",
        "interactions",
        "reviews",
        "saved_items_and_collections",
        "your_interactions_on_facebook"
      ]);
      listToAdd.add(interactions);

      var advertisement = DataCategory(name: "Advertisement", matchingFolders: [
        "ads_information",
        "other_logged_information",
        "your_topics"
      ]);
      listToAdd.add(advertisement);

      var thirdPartyExchanges = DataCategory(
          name: "Third Party Exchanges",
          matchingFolders: ["apps_and_websites_off_of_facebook"]);
      listToAdd.add(thirdPartyExchanges);

      var other = DataCategory(name: "Other", matchingFolders: [
        "bug_bounty",
        "communities",
        "facebook_accounts_center",
        "facebook_assistant",
        "facebook_portal",
        "fundraisers",
        "journalist_registration",
        "live_audio_rooms",
        "music_recommendations",
        "spark_ar",
        "your_problem_reports"
      ]);
      listToAdd.add(other);

      var reactions = DataCategory(name: "Reactions", matchingFolders: [
        "comments_and_reactions",
      ]);
      listToAdd.add(reactions);

      var social = DataCategory(name: "Social", matchingFolders: [
        "events",
        "friends_and_followers",
        "groups",
        "other_activity",
        "pages"
      ]);
      listToAdd.add(social);

      var gaming =
          DataCategory(name: "Gaming", matchingFolders: ["facebook_gaming"]);
      listToAdd.add(gaming);

      var shopping = DataCategory(
          name: "Shopping",
          matchingFolders: ["facebook_marketplace", "facebook_payments"]);
      listToAdd.add(shopping);

      var location = DataCategory(
          name: "Location", matchingFolders: ["location", "your_places"]);
      listToAdd.add(location);

      var messaging =
          DataCategory(name: "Messaging", matchingFolders: ["messages"]);
      listToAdd.add(messaging);

      var preferences = DataCategory(
          name: "Preferences", matchingFolders: ["news_feed", "preferences"]);
      listToAdd.add(preferences);

      var profile = DataCategory(
          name: "Profile", matchingFolders: ["profile_information"]);
      listToAdd.add(profile);

      var serach = DataCategory(name: "Serach", matchingFolders: ["search"]);
      listToAdd.add(serach);

      var loggedData = DataCategory(
          name: "Logged Data",
          matchingFolders: ["security_and_login_information"]);
      listToAdd.add(loggedData);

      var posts = DataCategory(
          name: "Posts", matchingFolders: ["posts", "short_videos"]);
      listToAdd.add(posts);

      var stories = DataCategory(name: "Stories", matchingFolders: ["stories"]);
      listToAdd.add(stories);

      _categoryBox.putMany(listToAdd);
      var facebookService = store
          .box<ServiceObjectBox>()
          .query(ServiceObjectBox_.name.equals('Facebook'))
          .build()
          .findUnique();
      if (facebookService == null) {
        facebookService =
            ServiceObjectBox(name: 'Facebook', company: 'Meta', image: '/TODO');
        store.box<ServiceObjectBox>().put(facebookService);
      }

      var instagramService = store
          .box<ServiceObjectBox>()
          .query(ServiceObjectBox_.name.equals('Instagram'))
          .build()
          .findUnique();
      if (instagramService == null) {
        instagramService = ServiceObjectBox(
            name: 'Instagram', company: 'Meta', image: '/TODO');
        store.box<ServiceObjectBox>().put(instagramService);
      }
    }
  }

  static Future<ObjectBoxMock> create() async {
    final store = await openStore(directory: 'test/objectbox');
    return ObjectBoxMock._create(store);
  }
}

Future<void> deleteTestDb() async {
  final scriptDir = File(Platform.script.toFilePath()).parent;
  final datafile =
      File(dart_path.normalize('${scriptDir.path}/test/objectbox/data.mdb'));
  final lockfile =
      File(dart_path.normalize('${scriptDir.path}/test/objectbox/lock.mdb'));
  try {
    await datafile.delete();
    await lockfile.delete();
  } catch (e) {
    return;
  }
}
