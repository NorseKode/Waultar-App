import 'package:waultar/core/inodes/tree_nodes.dart';
import 'package:waultar/data/configs/objectbox.dart';
import 'package:waultar/data/configs/objectbox.g.dart';

class DataPointNameRepository {
  final ObjectBox _context;
  late final Box<DataPointName> _nameBox;

  DataPointNameRepository(this._context) {
    _nameBox = _context.store.box<DataPointName>();
  }

  DataPointName? getByName(String name) {
    var dataName =
        _nameBox.query(DataPointName_.name.equals(name)).build().findUnique();
    return dataName;
  }

  int addSingle(DataPointName name) => _nameBox.put(name);
  List<int> addMany(List<DataPointName> names) => _nameBox.putMany(names);

  DataPointName? getNameById(int id) => _nameBox.get(id);

  List<DataPoint> getDataPointsByName(DataPointName name) {
    return _nameBox.get(name.id)!.dataPoints.toList();
  }

  List<DataPointName> getAll() => _nameBox.getAll();

  int addDataName(String name) {
    var existing =
        _nameBox.query(DataPointName_.name.equals(name)).build().findUnique();

    if (existing == null) {
      return _nameBox.put(DataPointName(name: name));
    }

    return existing.id;
  }

  List<String> getAllNames() {
    return _nameBox.getAll().map((e) => e.name).toList();
  }
}
