import 'package:objectbox/internal.dart';
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
        category: CategoryEnum.interactions,
      );
      listToAdd.add(interactions);

      var advertisement = DataCategory(
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
        category: CategoryEnum.advertisement,
      );
      listToAdd.add(advertisement);

      var thirdPartyExchanges = DataCategory(
        matchingFoldersFacebook: [
          "apps_and_websites_off_of_facebook",
        ],
        matchingFoldersInstagram: [],
        category: CategoryEnum.thirdPartyExchanges,
      );
      listToAdd.add(thirdPartyExchanges);

      var other = DataCategory(
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
        category: CategoryEnum.other,
      );
      listToAdd.add(other);

      var reactions = DataCategory(
        matchingFoldersFacebook: [
          "posts_and_comments.json",
        ],
        matchingFoldersInstagram: [
          "likes",
        ],
        category: CategoryEnum.reactions,
      );
      listToAdd.add(reactions);

      var comments = DataCategory(
        matchingFoldersFacebook: [
          "comments.json",
          "your_comments_in_groups.json",
        ],
        matchingFoldersInstagram: [
          "comments",
        ],
        category: CategoryEnum.comments,
      );
      listToAdd.add(comments);

      var social = DataCategory(
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
        category: CategoryEnum.social,
      );
      listToAdd.add(social);

      var gaming = DataCategory(
        matchingFoldersFacebook: [
          "facebook_gaming",
        ],
        matchingFoldersInstagram: [],
        category: CategoryEnum.gaming,
      );
      listToAdd.add(gaming);

      var shopping = DataCategory(
        matchingFoldersFacebook: [
          "facebook_marketplace",
          "facebook_payments",
        ],
        matchingFoldersInstagram: [
          "recently_viewed_items",
        ],
        category: CategoryEnum.shopping,
      );
      listToAdd.add(shopping);

      var location = DataCategory(
        matchingFoldersFacebook: [
          "location",
          "your_places",
        ],
        matchingFoldersInstagram: [],
        category: CategoryEnum.location,
      );
      listToAdd.add(location);

      var messaging = DataCategory(
        matchingFoldersFacebook: [
          "messages",
        ],
        matchingFoldersInstagram: [
          "messages",
        ],
        category: CategoryEnum.messaging,
      );
      listToAdd.add(messaging);

      var preferences = DataCategory(
        matchingFoldersFacebook: [
          "news_feed",
          "preferences",
        ],
        matchingFoldersInstagram: [
          "autofill_information",
          "comments_settings",
        ],
        category: CategoryEnum.preferences,
      );
      listToAdd.add(preferences);

      var profile = DataCategory(
        matchingFoldersFacebook: [
          "profile_information",
        ],
        matchingFoldersInstagram: [
          "account_information",
          "login_and_account_creation",
          "information_about_you",
        ],
        category: CategoryEnum.profile,
      );
      listToAdd.add(profile);

      var serach = DataCategory(
        matchingFoldersFacebook: [
          "search",
        ],
        matchingFoldersInstagram: [
          "recent_searches",
        ],
        category: CategoryEnum.serach,
      );
      listToAdd.add(serach);

      var loggedData = DataCategory(
        matchingFoldersFacebook: [
          "security_and_login_information",
        ],
        matchingFoldersInstagram: [
          "past_instagram_insights",
          "device_information",
        ],
        category: CategoryEnum.loggedData,
      );
      listToAdd.add(loggedData);

      var posts = DataCategory(
        matchingFoldersFacebook: [
          "posts",
          "short_videos",
        ],
        matchingFoldersInstagram: [
          "content",
        ],
        category: CategoryEnum.posts,
      );
      listToAdd.add(posts);

      var stories = DataCategory(
        matchingFoldersFacebook: [
          "stories",
        ],
        matchingFoldersInstagram: [
          "stories.json",
        ],
        category: CategoryEnum.stories,
      );
      listToAdd.add(stories);

      var files = DataCategory(
        matchingFoldersFacebook: [
          "",
        ],
        matchingFoldersInstagram: [
          "profile_photos.json",
        ],
        category: CategoryEnum.files,
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

  ObjectBox._fromIsolate(this.store);

  static Future<ObjectBox> fromIsolate(String path) async {
    final store = Store.attach(getObjectBoxModel(), path);
    return ObjectBox._fromIsolate(store);
  }
}
