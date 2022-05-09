import 'package:waultar/configs/globals/app_logger.dart';
import 'package:waultar/data/configs/objectbox.dart';
import 'package:waultar/data/configs/objectbox.g.dart';
import 'package:waultar/data/entities/media/file_document.dart';
import 'package:waultar/data/entities/media/image_document.dart';
import 'package:waultar/data/entities/media/link_document.dart';
import 'package:waultar/data/entities/media/video_document.dart';
import 'package:waultar/startup.dart';

class MediaRepository {
  final ObjectBox _context;
  final _logger = locator.get<BaseLogger>(instanceName: 'logger');
  late final Box<ImageDocument> _imageBox;
  late final Box<VideoDocument> _videoBox;
  late final Box<FileDocument> _fileBox;
  late final Box<LinkDocument> _linkBox;

  MediaRepository(this._context) {
    _imageBox = _context.store.box<ImageDocument>();
    _videoBox = _context.store.box<VideoDocument>();
    _fileBox = _context.store.box<FileDocument>();
    _linkBox = _context.store.box<LinkDocument>();
  }

  List<ImageDocument> getAllImages() => _imageBox.getAll();
  List<ImageDocument> getImagesPagination(int offset, int limit) {
    var builder = _imageBox.query();
    
    var query = builder.build();
    query
      ..offset = offset
      ..limit = limit;
    return query.find();
  }

  List<ImageDocument> getImagesForTaggingPagination(int offset, int limit) {
    var query = _imageBox.query(ImageDocument_.mediaTags.equals("")).build();
    query
      ..offset = offset
      ..limit = limit;
    return query.find();
  }

  List<int> updateImages(List<ImageDocument> images) {
    return _imageBox.putMany(images);
  }

  int getAmountOfUnTaggedImages() {
    // var imgs = _imageBox.query(ImageDocument_.mediaTags.equals("")).build().find();
    // for (var img in imgs) {
    //   print(img.mediaTags);
    // }
    return _imageBox.query(ImageDocument_.mediaTags.equals("")).build().count();
  }

  List<ImageDocument> searchImagesPagination(
      List<String> tags, List<int> profileIds, int offset, int limit) {
    var queryInput = ImageDocument_.mediaTags.contains(
      tags.removeAt(0).trim(),
      caseSensitive: false,
    );

    for (var tag in tags) {
      if (tag.isNotEmpty) {
        queryInput = queryInput.and(ImageDocument_.mediaTags.contains(
          tag.trim(),
          caseSensitive: false,
        ));
      }
    }

    var builder = _imageBox.query(queryInput);

    builder.link(ImageDocument_.profile, ProfileDocument_.id.oneOf(profileIds));

    builder.order(ImageDocument_.id, flags: Order.descending);

    var query = builder.build();

    query
      ..offset = offset
      ..limit = limit;

    return query.find();
  }

  int deleteAllImageTags() {
    var res = 0;

    for (var image in _imageBox.getAll()) {
      image.mediaTagScores = <String>[];
      image.mediaTags = "";
      res += _imageBox.put(image);
    }

    return res;
  }

  List<VideoDocument> getAllVideos() => _videoBox.getAll();
  List<VideoDocument> getVideosPagination(int offset, int limit) {
    var query = _videoBox.query().build();
    query
      ..offset = offset
      ..limit = limit;

    return query.find();
  }

  List<FileDocument> getAllFiles() => _fileBox.getAll();
  List<FileDocument> getFilesPagination(int offset, int limit) {
    var query = _fileBox.query().build();
    query
      ..offset = offset
      ..limit = limit;

    return query.find();
  }

  List<LinkDocument> getAllLinks() => _linkBox.getAll();
}
