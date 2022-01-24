import 'dart:convert';
import 'dart:io';

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