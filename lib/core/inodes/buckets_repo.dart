import 'package:waultar/data/configs/objectbox.dart';
import 'package:waultar/data/configs/objectbox.g.dart';
import 'package:waultar/data/entities/timebuckets/buckets.dart';

abstract class IBucketsRepository {
  void createBuckets(DateTime dataPointsCreatedAfter);
}

class IRepository {
  /*
  T get(int id);
  */
}

class BucketsRepository extends IBucketsRepository {

  final ObjectBox _context;
  late final Box<YearBucket> _yearBox;
  late final Box<MonthBucket> _monthBox;
  late final Box<DayBucket> _dayBox;

  BucketsRepository(this._context) {
    _yearBox = _context.store.box<YearBucket>();
    _monthBox = _context.store.box<MonthBucket>();
    _dayBox = _context.store.box<DayBucket>();
  }

  @override
  void createBuckets(DateTime dataPointsCreatedAfter) {
    throw UnimplementedError();
  }
  
}