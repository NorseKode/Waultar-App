import 'package:path/path.dart' as dart_path;

class PathHelper {
  static String getCommonPath(String path1, String path2) {
    var commonPath = StringBuffer();

    for (var i = 0; i < path1.length; i++) {
      if (path1[i] == path2[i]) {
        commonPath.write(path1[i]);
      } else {
        break;
      }
    }
    return commonPath.toString();
  }

  static bool hasCommonPath(String path1, String path2) {
    var dirNamePath1 = dart_path.dirname(path1);
    var dirNamePath2 = dart_path.dirname(path2);

    return dirNamePath1 == dirNamePath2;
  }
}
