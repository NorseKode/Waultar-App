import 'package:tuple/tuple.dart';
import 'package:waultar/core/abstracts/abstract_repositories/i_timebuckets_repository.dart';
import 'package:waultar/startup.dart';

class TimeBucketsCreator {
  final ITimeBucketsRepository _timeRepo =
      locator.get<ITimeBucketsRepository>(instanceName: 'timeRepo');
  TimeBucketsCreator();

  // TODO : Call me when parsing is done
  void createTimeBuckets() {
    // _handlePosts();
    // _handleGroups();
    // _handleEvents();
  }

  // void _handlePosts() {
  //   var posts = _postRepo.getAllPostsAsEntity();
  //   for (var post in posts) {
  //     var timestamp = post.timestamp;
  //     if (timestamp != 0) {
  //       var tuple = _dissectDateTime(timestamp);
  //       _timeRepo.save(tuple.item1, tuple.item2, tuple.item3, post);
  //     }
  //   }
  // }

  // void _handleGroups() {
  //   var groups = _groupRepo.getAllGroupsAsEntity();
  //   for (var group in groups) {
  //     var timestamp = group.timestamp;
  //     if (timestamp != null) {
  //       var tuple = _dissectDateTime(timestamp);
  //       _timeRepo.save(tuple.item1, tuple.item2, tuple.item3, group);
  //     }
  //   }
  // }

  // void _handleEvents() {
  //   var events = _eventRepo.getAllEventsAsEntity();
  //   for (var event in events) {
  //     var created = event.createdTimestamp;
  //     if (created != null) {
  //       var tuple = _dissectDateTime(created);
  //       _timeRepo.save(tuple.item1, tuple.item2, tuple.item3, event);
  //     }
  //     var starting = event.startTimestamp;
  //     if (starting != null) {
  //       var tuple = _dissectDateTime(starting);
  //       _timeRepo.save(tuple.item1, tuple.item2, tuple.item3, event);
  //     }
  //     var ending = event.endTimestamp;
  //     if (ending != null) {
  //       var tuple = _dissectDateTime(ending);
  //       _timeRepo.save(tuple.item1, tuple.item2, tuple.item3, event);
  //     }
  //   }
  // }

  Tuple3<int, int, int> _dissectDateTime(DateTime timestamp) {
    int year = timestamp.year;
    int month = timestamp.month;
    int day = timestamp.day;
    return Tuple3(year, month, day);
  }
}
