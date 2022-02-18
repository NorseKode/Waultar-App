import 'package:waultar/core/abstracts/abstract_repositories/i_file_repository.dart';
import 'package:waultar/core/models/index.dart';
import 'package:waultar/data/configs/objectbox.dart';
import 'package:waultar/data/configs/objectbox.g.dart';
import 'package:waultar/data/entities/media/file_objectbox.dart';
import 'package:waultar/data/repositories/model_builders/i_model_director.dart';
import 'package:waultar/data/repositories/objectbox_builders/i_objectbox_director.dart';

class FileRepository implements IFileRepository {
  late final ObjectBox _context;
  late final Box<FileObjectBox> _fileBox;
  late final IObjectBoxDirector _entityDirector;
  late final IModelDirector _modelDirector;

  FileRepository(this._context, this._entityDirector, this._modelDirector) {
    _fileBox = _context.store.box<FileObjectBox>();
  }

  @override
  int addFile(FileModel file) {
    var entity = _entityDirector.make<FileObjectBox>(file);
    int id = _fileBox.put(entity);
    return id;
  }

  @override
  List<FileModel>? getAllFiles() {
    var files = _fileBox.getAll();

    if (files.isEmpty) {
      return null;
    }

    var fileModels = <FileModel>[];
    for (var file in files) {
      var model = _modelDirector.make<FileModel>(file);
      fileModels.add(model);
    }
    return fileModels;
  }

  @override
  List<FileModel>? getAllFilesByProfile(ProfileModel profile) {
    var builder = _fileBox.query();
    builder.link(
        FileObjectBox_.profile, ProfileObjectBox_.id.equals(profile.id));
    var files = builder.build().find();

    if (files.isEmpty) {
      return null;
    }

    var fileModels = <FileModel>[];
    for (var file in files) {
      fileModels.add(_modelDirector.make<FileModel>(file));
    }
    return fileModels;
  }

  @override
  List<FileModel>? getAllFilesByService(ServiceModel service) {
    var builder = _fileBox.query();
    builder.link(
        FileObjectBox_.profile, ProfileObjectBox_.service.equals(service.id));
    var files = builder.build().find();

    if (files.isEmpty) {
      return null;
    }

    var fileModels = <FileModel>[];
    for (var file in files) {
      fileModels.add(_modelDirector.make<FileModel>(file));
    }
    return fileModels;
  }

  @override
  FileModel? getFileById(int id) {
    var file = _fileBox.get(id);

    if (file == null) {
      return null;
    } else {
      return _modelDirector.make<FileModel>(file);
    }
  }
}
