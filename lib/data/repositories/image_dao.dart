import 'package:drift/drift.dart';
import 'package:waultar/core/models/tables/images_table.dart';
import 'package:waultar/data/configs/drift_config.dart';

part 'image_dao.g.dart';

@DriftAccessor(tables: [ImagesTable])
class ImageDao extends DatabaseAccessor<WaultarDb> with _$ImageDaoMixin {
  ImageDao(WaultarDb db) : super(db);

  /// returns id of created entry
  Future<int> addImage(Image image) {
    return into(imagesTable).insert(image);
  }

  Future<Image> getImageById(int id) {
    return (select(imagesTable)..where((i) => i.id.equals(id))).getSingle();
  }

  Future<List<Image>> getAllImages() => select(imagesTable).get();

  /// read all images sorted by timestamp in descending order
  Future<List<Image>> getAllImagesSortedByDate() {
    return (select(imagesTable)..orderBy([(i) => OrderingTerm.desc(i.timestamp)])).get();
  }
}
