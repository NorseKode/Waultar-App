import 'package:waultar/data/entities/timebuckets/buckets.dart';

abstract class IBucketsRepository {
  void createBuckets(DateTime dataPointsCreatedAfter);
}

class IRepository {
  /*
  T get(int id);
  */
}

// class BucketsRepository extends IBucketsRepository {
//   int createYear(YearBucket year) {
    
//   }
//   int createMonth(MonthBucket year) {
    
//   }
//   int createDay(DayBucket year) {

//   }
//   int createHour(YearBucket year) {

//   }
// }