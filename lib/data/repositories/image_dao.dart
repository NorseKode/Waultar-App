import 'package:drift/drift.dart';
import 'package:waultar/core/abstracts/abstract_repositories/i_image_repository.dart';
import 'package:waultar/core/models/image_model.dart';
import 'package:waultar/data/configs/drift_config.dart';
import 'package:waultar/data/entities/index.dart';
import 'package:waultar/data/repositories/companion_mapper.dart';

part 'image_dao.g.dart';

@DriftAccessor(tables: [ImageEntity])
class ImageDao extends DatabaseAccessor<WaultarDb> with _$ImageDaoMixin implements IImageRepository{
  ImageDao(WaultarDb db) : super(db);

  /// returns id of created entry
  @override
  Future<int> addImage(ImageModel image) {
    var companion = toImageCompanion(image);
    return into(imageEntity).insert(companion);
  }

  @override
  Future<ImageModel> getImageById(int id) {
    return (select(imageEntity)..where((i) => i.id.equals(id))).getSingle();
  }

  @override
  Future<List<ImageModel>> getAllImages() => select(imageEntity).get();

  /// read all images sorted by timestamp in descending order
  @override
  Future<List<ImageModel>> getAllImagesSortedByDate() {
    return (select(imageEntity)..orderBy([(i) => OrderingTerm.desc(i.timestamp)])).get();
  }
}
