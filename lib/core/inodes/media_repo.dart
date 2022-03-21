import 'package:waultar/core/inodes/media_documents.dart';
import 'package:waultar/data/configs/objectbox.dart';
import 'package:waultar/data/configs/objectbox.g.dart';

class MediaRepository {
  final ObjectBox _context;
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
    var query = _imageBox.query().build();
    query
      ..offset = offset
      ..limit = limit;
    return query.find();
  }

  List<VideoDocument> getAllVideos() => _videoBox.getAll();
  List<FileDocument> getAllFiles() => _fileBox.getAll();
  List<LinkDocument> getAllLinks() => _linkBox.getAll();
}
