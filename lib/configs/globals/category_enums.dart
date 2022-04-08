import 'package:path/path.dart' as dart_path;
import 'package:flutter/material.dart';


enum CategoryEnum {
  unknown,
  interactions,
  advertisement,
  thirdPartyExchanges,
  other,
  reactions,
  comments,
  social,
  gaming,
  shopping,
  location,
  messaging,
  preferences,
  profile,
  serach,
  loggedData,
  posts,
  stories,
  files,
}

extension CategoryMapper on CategoryEnum {
  static const colors = {
    CategoryEnum.unknown: Colors.cyan,
    CategoryEnum.interactions: Colors.red,
    CategoryEnum.advertisement: Colors.blue,
    CategoryEnum.thirdPartyExchanges: Colors.orange,
    CategoryEnum.other: Colors.brown,
    CategoryEnum.reactions: Colors.green,
    CategoryEnum.comments: Colors.purple,
    CategoryEnum.social: Colors.purpleAccent,
    CategoryEnum.gaming: Colors.blueGrey,
    CategoryEnum.shopping: Colors.pink,
    CategoryEnum.location: Colors.indigo,
    CategoryEnum.messaging: Colors.blueAccent,
    CategoryEnum.preferences: Colors.cyanAccent,
    CategoryEnum.profile: Colors.lightBlueAccent,
    CategoryEnum.serach: Colors.limeAccent,
    CategoryEnum.loggedData: Colors.yellow,
    CategoryEnum.posts: Colors.amber,
    CategoryEnum.stories: Colors.deepPurple,
    CategoryEnum.files: Colors.black38,
  };

  static const names = {
    CategoryEnum.unknown: 'Unknown',
    CategoryEnum.interactions: 'Interactions',
    CategoryEnum.advertisement: 'Advertisement',
    CategoryEnum.thirdPartyExchanges: 'Third Party Exchanges',
    CategoryEnum.other: 'Other',
    CategoryEnum.reactions: 'Reactions',
    CategoryEnum.comments: 'Comments',
    CategoryEnum.social: 'Social',
    CategoryEnum.gaming: 'Gaming',
    CategoryEnum.shopping: 'Shopping',
    CategoryEnum.location: 'Location',
    CategoryEnum.messaging: 'Messaging',
    CategoryEnum.preferences: 'Preferences',
    CategoryEnum.profile: 'Profile',
    CategoryEnum.serach: 'Serach',
    CategoryEnum.loggedData: 'Logged Data',
    CategoryEnum.posts: 'Posts',
    CategoryEnum.stories: 'Stories',
    CategoryEnum.files: 'Files',
  };

  Color get color => colors[this] ?? Colors.cyan;
  String get categoryName => names[this] ?? 'Unknown';
}

CategoryEnum getFromPath(String path) {
  var name = dart_path.basename(path);
  if (name == 'extracts' || name == 'test') {
    return CategoryEnum.unknown;
  }
  switch (name) {
    case 'activity_messages':
    case 'polls':
    case 'interactions':
    case 'reviews':
    case 'saved_items_and_collections':
    case 'your_interactions_on_facebook':
    case 'story_sticker_interactions':
    case 'ads_and_content':
    case 'saved':
      return CategoryEnum.interactions;

    case 'ads_information':
    case 'other_logged_information':
    case 'your_topics':
    case 'ads_and_businesses':
    case 'monetization':
    case 'ads_interests.json':
      return CategoryEnum.advertisement;

    case 'apps_and_websites_off_of_facebook':
      return CategoryEnum.thirdPartyExchanges;

    case 'bug_bounty':
    case "communities":
    case "facebook_accounts_center":
    case "facebook_assistant":
    case "facebook_portal":
    case "fundraisers":
    case "journalist_registration":
    case "live_audio_rooms":
    case "music_recommendations":
    case "spark_ar":
    case "your_problem_reports":
    case "apps_and_websites":
    case "contacts":
    case "loyalty_accounts":
    case "guides":
      return CategoryEnum.other;

    case 'likes':
    case 'posts_and_comments.json':
      return CategoryEnum.reactions;
    
    case 'comments.json':
    case 'your_comments_in_groups.json':
    case 'comments':
      return CategoryEnum.comments;

    case 'events':
    case 'friends_and_followers':
    case 'groups':
    case 'other_activity':
    case 'pages':
    case 'followers_and_following':
      return CategoryEnum.social;

    case 'facebook_gaming':
      return CategoryEnum.gaming;

    case 'facebook_marketplace':
    case 'facebook_payments':
    case 'recently_viewed_items':
      return CategoryEnum.shopping;

    case 'location':
    case 'your_places':
      return CategoryEnum.location;

    case 'messages':
      return CategoryEnum.messaging;

    case 'news_feed':
    case 'preferences':
    case 'autofill_information':
    case 'comments_settings':
      return CategoryEnum.preferences;

    case 'profile_information':
    case 'account_information':
    case 'login_and_account_creation':
    case 'information_about_you':
      return CategoryEnum.profile;

    case 'search':
    case 'recent_searches':
      return CategoryEnum.serach;

    case 'security_and_login_information':
    case 'past_instagram_insights':
    case 'device_information':
      return CategoryEnum.loggedData;

    case 'posts':
    case 'short_videos':
    case 'content':
      return CategoryEnum.posts;

    case 'stories':
    case 'stories.json':
      return CategoryEnum.stories;

    case 'profile_photos.json':
      return CategoryEnum.files;

    default:
      var newPath = dart_path.dirname(path);
      return getFromPath(newPath);
  }
}