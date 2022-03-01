import 'package:waultar/core/inodes/inode.dart';
import 'package:waultar/data/configs/objectbox.dart';
import 'package:waultar/data/configs/objectbox.g.dart';

class DataPointRepository {
  final ObjectBox _context;
  late final Box<DataPoint> _dataBox;

  DataPointRepository(this._context) {
    _dataBox = _context.store.box<DataPoint>();
  }

  int addDataPoint(DataPoint dataPoint) => _dataBox.put(dataPoint);
}
