import 'package:waultar/core/inodes/inode.dart';
import 'package:waultar/data/configs/objectbox.dart';
import 'package:waultar/data/configs/objectbox.g.dart';

class DataPointNameRepository {
  final ObjectBox _context;
  late final Box<DataPointName> _nameBox;

  DataPointNameRepository(this._context) {
    _nameBox = _context.store.box<DataPointName>();
  }

  DataPointName? getByName(String name) {
    var dataName = _nameBox
        .query(DataPointName_.name.equals(name))
        .build()
        .findUnique();
    return dataName;
  }

  DataPointName? getNameById(int id) => _nameBox.get(id); 

  List<DataPoint>? getDataPointsByName(DataPointName name) {
    var entity = _nameBox.get(name.id);
    if (entity != null) {
      return entity.dataPoints.toList();
    }

    return null;
  }

  int addDataName(String name) {
    var existing = _nameBox
        .query(DataPointName_.name.equals(name))
        .build()
        .findUnique();
        
    if (existing == null) {
      return _nameBox.put(DataPointName(name: name));
    }

    return existing.id;
  }
}
