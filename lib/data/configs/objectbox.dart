import 'package:waultar/core/inodes/service_document.dart';
import 'package:waultar/core/inodes/tree_nodes.dart';
import 'package:path/path.dart' as dart_path;

import '../entities/misc/appsettings_objectbox.dart';
import 'objectbox.g.dart';

class ObjectBox {
  late final Store store;

  ObjectBox._create(this.store) {
    // additional setup code here
    final appSettingsBox = store.box<AppSettingsObjectBox>();
    if (appSettingsBox.count() == 0) {
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

      var comments = DataCategory(name: 'Comments', matchingFolders: [
        "facebook_comments.json",
        "post_comments.json"
      ]);
      listToAdd.add(comments);

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
    }

    var facebookService = store
        .box<ServiceDocument>()
        .query(ServiceDocument_.serviceName.equals('Facebook'))
        .build()
        .findUnique();
    if (facebookService == null) {
      facebookService = ServiceDocument(
          serviceName: 'Facebook',
          companyName: 'Meta',
          image: dart_path.normalize('/assests/service_icons/todo.svg'));
      store.box<ServiceDocument>().put(facebookService);
    }

    var instagramService = store
        .box<ServiceDocument>()
        .query(ServiceDocument_.serviceName.equals('Instagram'))
        .build()
        .findUnique();
    if (instagramService == null) {
      instagramService = ServiceDocument(
          serviceName: 'Instagram',
          companyName: 'Meta',
          image: dart_path.normalize('/assests/service_icons/todo.svg'));
      store.box<ServiceDocument>().put(instagramService);
    }
  }

  static Future<ObjectBox> create(String path) async {
    final store = await openStore(directory: path);
    return ObjectBox._create(store);
  }
}
