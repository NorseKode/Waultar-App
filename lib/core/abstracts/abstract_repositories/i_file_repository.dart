import 'package:waultar/core/models/index.dart';

abstract class IFileRepository {
  int addFile(FileModel file);
  FileModel? getFileById(int id);
  List<FileModel>? getAllFiles();
  List<FileModel>? getAllFilesByService(ServiceModel service);
  List<FileModel>? getAllFilesByProfile(ProfileModel profile);
  int removeAll();
}