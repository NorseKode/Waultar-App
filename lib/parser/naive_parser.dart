import 'package:drift/drift.dart';
import 'package:waultar/models/tables/images_table.dart';
import 'package:waultar/parser/parse_helper.dart';
import 'package:waultar/widgets/upload/upload_util.dart';

import 'base_entity.dart';

void readObject<T>(List<T> acc, var data, bool functionCheck(var value), T constructor(var value)) {
  if (data is Map<String, dynamic>) {
    for (var val in data.values) {
      if (functionCheck(val)) {
        var img = constructor(val);
        if (img != null) {
          acc.add(img);
        }
      } else {
        readObject<T>(acc, val, functionCheck, constructor);
      }
    }
  } else if (data is List<dynamic>) {
    for (var item in data) {
      var img = constructor(item);

      if (img == null) {
        readObject<T>(acc, item, functionCheck, constructor);
      } else {
        acc.add(img);
      }
    }
  } else {
    // TODO: error handling?!?!?
  }
}

parseDirectory(String path) async {
  // var files = getAllFilesFrom(path);
  var images = <Image>[];
  var data = await getJsonString(path);
  var fun = (var value) {
    return value is Map<String, dynamic> && value.containsKey("uri");
  };

  readObject<Image>(images, data, fun, Image.fromJson2);
  
  print(images.length);

  for (var img in images) {
    print(img.toString());
  }

  return images;
}