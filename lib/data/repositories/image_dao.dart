import 'package:drift/drift.dart';
import 'package:waultar/core/models/image_model.dart';
import 'package:waultar/data/configs/drift_config.dart';
import 'package:waultar/data/entities/index.dart';

part 'image_dao.g.dart';

@DriftAccessor(tables: [ImageEntity])
class ImageDao extends DatabaseAccessor<WaultarDb> with _$ImageDaoMixin {
  ImageDao(WaultarDb db) : super(db);

  /// returns id of created entry
  Future<int> addImage(ImageModel image) {
    var companion = ImageEntityCompanion(
      path: Value(image.path),
      raw: Value(image.raw),
      timestamp: Value(image.timestamp),
    );
    return into(imageEntity).insert(companion);
  }

  Future<ImageModel> getImageById(int id) {
    return (select(imageEntity)..where((i) => i.id.equals(id))).getSingle();
  }

  Future<List<ImageModel>> getAllImages() => select(imageEntity).get();

  /// read all images sorted by timestamp in descending order
  Future<List<ImageModel>> getAllImagesSortedByDate() {
    return (select(imageEntity)..orderBy([(i) => OrderingTerm.desc(i.timestamp)])).get();
  }
}
