import 'dart:convert';
import 'dart:io';

import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:waultar/models/tables/images_table.dart';
import 'package:waultar/widgets/upload/upload_files.dart';
import 'package:path/path.dart' as p;

import 'content_dto.dart';

String trySeveralNames(Map<String, dynamic> json, List<String> pathNames) {
  for (var name in pathNames) {
    if (json.containsKey(name) && json[name] is String) {
      return json[name];
    }
  }

  for (var object in json.values) {
    if (object is Map<String, dynamic>) {
      return trySeveralNames(object, pathNames);
    }
  }

  return '';
}

getJsonString(var path) async {
  File file = File(path);
  var jsonString = await file.readAsString();
  return jsonDecode(jsonString);
}

Image? aux(var data, String keyword, Function funToCall) {
  if (data is Map<String, dynamic>) {
    if (data.containsKey(keyword)) {
      var image = Image.fromJson(data[keyword]);
      return image;
    } else {
      for (var key in data.keys) {
        return aux(data[key], keyword, funToCall);
      }
    }
  } else if (data is List<dynamic>) {
    for (var object in data) {
      return aux(object, keyword, funToCall);
    }
  }
}

loadImages(List<Image> acc, var data) {
  if (data is Map<String, dynamic>) {
    for (var val in data.values) {
      if (val is Map<String, dynamic> && val.containsKey("uri")) {
        var img = Image.fromJson(val);
        if (img != null) {
          acc.add(img);
        }
      } else {
        loadImages(acc, val);
      }
    }
  } else if (data is List<dynamic>) {
    for (var item in data) {
      var img = Image.fromJson(item);

      if (img == null) {
        loadImages(acc, item);
      } else {
        acc.add(img);
      }
    }
  }
}

callMe(var path) async {
  var images = <Image>[];
  var data = await getJsonString(path);

  loadImages(images, data);

  // if (data is Map<String, dynamic>) {
  //   if (data.containsKey("photos")) {
  //     loadImages(images, data);
  //   }
  // } else if (data is List<dynamic>) {
  //   for (var item in data) {
  //     var image = Image.fromJson(item);

  //     if (image != null) {
  //       images.add(image);
  //     }
  //   }
  // }

  print(images.length);

  return images;
}

copyFolderToDocuments(String dir) async {
  var context = p.Context(style: Style.windows);
  var files = await FileUploader.getAllFilesFrom(dir);
  var appPath = await getApplicationDocumentsDirectory();
  var path = context.join(appPath.path, "Waultar");

  for (var file in files) {
    var tempFile = File(path + file);
    var exists = await tempFile.exists();
    if (!exists) {
      tempFile.create(recursive: true);
    }

    var oldFile = File(dir + file);
    var newPath = context.canonicalize(tempFile.path);
    oldFile.copy(context.canonicalize(newPath));
  }
}

// String? aux(var data) {
//   if (data.containsKey('uri')) {
//     return data['uri'];
//   } else if (data is Map<String, dynamic>) {
//     for (var item in data.values) {
//       if (item is Map<String, dynamic>) {
//         return aux(item);
//       } else if (item is List<dynamic>) {

//       }
//     }
//   } else if (data is List<dynamic>) {
//     for (var item in data) {
//       return aux(data);
//     }
//   }
// }

// void main() async {
//   // var file = await FileUploader.uploadSingle();
//   // var file = File('D:\\OneDrive\\NorseKode\\data\\facebook-lukasvlarsen\\posts\\your_posts_1.json');
//   var file = File('\\Users\\lukas\\OneDrive\\NorseKode\\data\\facebook-lukasvlarsen\\comments_and_reactions\\comments.json');
//   var result = <ContentDTO>[];

//   if (file != null) {
//     var jsonString = await file.readAsString();
//     var jsonData = jsonDecode(jsonString);

//     List<dynamic> welp = jsonData['comments_v2'];

//     for (var item in welp) {
//       var element = ContentDTO.fromJson(item, ["welp"], ["title"], ["description", "comment"]);
//       print(element);
//       result.add(element);
//     }

//     print(result.length);

//     // for (Map<String, dynamic> item in jsonData) {
//     //   var res = aux(item);

//     //   if (res != null) {
//     //     print('res');
//     //   }
//     // }
//   }

//   print("done");
// }