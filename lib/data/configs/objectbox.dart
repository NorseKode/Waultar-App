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

      var interactions = DataCategory(
        name: "Interactions",
        matchingFoldersFacebook: [
          "activity_messages",
          "polls",
          "interactions",
          "reviews",
          "saved_items_and_collections",
          "your_interactions_on_facebook"
        ],
        matchingFoldersInstagram: [
          "likes",
          "story_sticker_interactions",
          "ads_and_content",
          "saved"
        ],
      );
      listToAdd.add(interactions);

      var advertisement = DataCategory(
        name: "Advertisement",
        matchingFoldersFacebook: [
          "ads_information",
          "other_logged_information",
          "your_topics",
        ],
        matchingFoldersInstagram: [
          "your_topics",
          "ads_and_businesses",
          "monetization",
          "ads_interests.json"
        ],
      );
      listToAdd.add(advertisement);

      var thirdPartyExchanges = DataCategory(
        name: "Third Party Exchanges",
        matchingFoldersFacebook: [
          "apps_and_websites_off_of_facebook",
        ],
        matchingFoldersInstagram: [],
      );
      listToAdd.add(thirdPartyExchanges);

      var other = DataCategory(
        name: "Other",
        matchingFoldersFacebook: [
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
          "your_problem_reports",
        ],
        matchingFoldersInstagram: [
          "apps_and_websites",
          "contacts",
          "loyalty_accounts",
          "guides",
          "fundraisers",
        ],
      );
      listToAdd.add(other);

      var reactions = DataCategory(
        name: "Reactions",
        matchingFoldersFacebook: [
          "posts_and_comments.json",
        ],
        matchingFoldersInstagram: [
          "likes",
        ],
      );
      listToAdd.add(reactions);

      var comments = DataCategory(
        name: 'Comments',
        matchingFoldersFacebook: [
          "comments.json",
          "your_comments_in_groups.json",
        ],
        matchingFoldersInstagram: [
          "comments",
        ],
      );
      listToAdd.add(comments);

      var social = DataCategory(
        name: "Social",
        matchingFoldersFacebook: [
          "events",
          "friends_and_followers",
          "groups",
          "other_activity",
          "pages",
        ],
        matchingFoldersInstagram: [
          "events",
          "followers_and_following",
        ],
      );
      listToAdd.add(social);

      var gaming = DataCategory(
        name: "Gaming",
        matchingFoldersFacebook: [
          "facebook_gaming",
        ],
        matchingFoldersInstagram: [],
      );
      listToAdd.add(gaming);

      var shopping = DataCategory(
        name: "Shopping",
        matchingFoldersFacebook: [
          "facebook_marketplace",
          "facebook_payments",
        ],
        matchingFoldersInstagram: ["recently_viewed_items"],
      );
      listToAdd.add(shopping);

      var location = DataCategory(
        name: "Location",
        matchingFoldersFacebook: [
          "location",
          "your_places",
        ],
        matchingFoldersInstagram: [],
      );
      listToAdd.add(location);

      var messaging = DataCategory(
        name: "Messaging",
        matchingFoldersFacebook: [
          "messages",
        ],
        matchingFoldersInstagram: [
          "messages",
        ],
      );
      listToAdd.add(messaging);

      var preferences = DataCategory(
        name: "Preferences",
        matchingFoldersFacebook: [
          "news_feed",
          "preferences",
        ],
        matchingFoldersInstagram: [
          "autofill_information",
          "comments_settings",
        ],
      );
      listToAdd.add(preferences);

      var profile = DataCategory(
        name: "Profile",
        matchingFoldersFacebook: [
          "profile_information",
        ],
        matchingFoldersInstagram: [
          "account_information",
          "login_and_account_creation",
          "information_about_you",
        ],
      );
      listToAdd.add(profile);

      var serach = DataCategory(
        name: "Serach",
        matchingFoldersFacebook: [
          "search",
        ],
        matchingFoldersInstagram: ["recent_searches"],
      );
      listToAdd.add(serach);

      var loggedData = DataCategory(
        name: "Logged Data",
        matchingFoldersFacebook: [
          "security_and_login_information",
        ],
        matchingFoldersInstagram: [
          "past_instagram_insights",
          "device_information",
        ],
      );
      listToAdd.add(loggedData);

      var posts = DataCategory(
        name: "Posts",
        matchingFoldersFacebook: [
          "posts",
          "short_videos",
        ],
        matchingFoldersInstagram: [
          "content",
        ],
      );
      listToAdd.add(posts);

      var stories = DataCategory(
        name: "Stories",
        matchingFoldersFacebook: [
          "stories",
        ],
        matchingFoldersInstagram: [
          "stories.json",
        ],
      );
      listToAdd.add(stories);

      var files = DataCategory(
        name: "Files",
        matchingFoldersFacebook: [
          "",
        ],
        matchingFoldersInstagram: [
          "profile_photos.json",
        ],
      );
      listToAdd.add(files);

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
