import 'package:path/path.dart' as path_dart;

class Extensions {
  static final _imageExtensions = [".jpg", ".png", ".gif"];
  static final _videoExtensions = [".mp4", ".mov"];
  static final _audioExtensions = [".mp3"];
  static final _fileExtensions = [".pdf", ".docx", ".pptx", ".md"];

  static bool isImage(String path) {
    return _checkExtension(path, _imageExtensions);
  }

  static bool isVideo(String path) {
    return _checkExtension(path, _videoExtensions);
  }

  static bool isAudio(String path) {
    return _checkExtension(path, _audioExtensions);
  }

  static bool isFile(String path) {
    return _checkExtension(path, _fileExtensions);
  }

  static bool isJson(String path) {
    return path_dart.extension(path) == '.json';
  }

  static FileType getFileType(String path) {
    if (isImage(path)) {
      return FileType.image;
    } else if (isVideo(path)) {
      return FileType.video;
    } else if (isAudio(path)) {
      return FileType.audio;
    } else if (isFile(path)) {
      return FileType.file;
    }
  
    return FileType.unknown;
  }

  static bool _checkExtension(String path, List<String> extensions) {
    if (extensions.contains(path_dart.extension(path))) {
      return true;
    } else {
      return false;
    }
  }
}

enum FileType {
  unknown,
  image,
  video,
  audio,
  file,
  link
}