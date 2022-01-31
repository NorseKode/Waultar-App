import 'package:drift/drift.dart';
import 'package:waultar/models/tables/images_table.dart';
import 'package:waultar/parser/parse_helper.dart';
import 'package:waultar/widgets/upload/upload_util.dart';
import 'package:path/path.dart' as dartPath;

import 'base_entity.dart';

void readObject<T>(List<T> acc, var data, bool isValidObject(var value),
    bool doesFileAlreadyExists(List<T> acc, T value)?, T constructor(var value)) {
  if (data is Map<String, dynamic>) {
    for (var value in data.values) {
      if (isValidObject(value)) {
        var object = constructor(value);
        if (doesFileAlreadyExists == null) {
          acc.add(object);
        } else if (!doesFileAlreadyExists(acc, object)) {
          acc.add(object);
        }
      } else {
        readObject<T>(acc, value, isValidObject, doesFileAlreadyExists, constructor);
      }
    }
  } else if (data is List<dynamic>) {
    for (var item in data) {
      var object = constructor(item);

      if (object == null) {
        readObject<T>(acc, item, isValidObject, doesFileAlreadyExists, constructor);
      } else {
        acc.add(object);
      }
    }
  } else {
    // TODO: error handling?!?!?
  }
}

parseDirectory(String path) async {
  var files = await getAllFilesFrom(path);
  var images = <Image>[];
  // var data = await getJsonString(path);
  var fun = (var value) {
    return value is Map<String, dynamic> && value.containsKey("uri");
  };
  var fun2 = (List<Image> acc, Image img) {
    return acc.where((element) => element.path == img.path) == 0 ? false : true;
  };

  for (var file in files) {
    if (dartPath.extension(file.path) == '.json') {
      var data = await getJsonStringFromFile(file);
      readObject<Image>(images, data, fun, fun2, Image.fromJson2);
    }
  }

  print(images.length);

  return images;
}
