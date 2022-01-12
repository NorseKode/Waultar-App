import 'dart:convert';
import 'dart:io';

// import 'package:waultar/widgets/upload/upload_files.dart';

// String trySeveralNames(Map<String, dynamic> json, List<String> pathNames) {
//   for (var name in pathNames) {
//     if (json.containsKey(name)) {
//       return json[name];
//     }
//   }

//   return '';
// }

String? aux(var data) {
  if (data.containsKey('uri')) {
    return data['uri'];
  } else if (data is Map<String, dynamic>) {
    for (var item in data.values) {
      if (item is Map<String, dynamic>) {
        return aux(item);
      } else if (item is List<dynamic>) {

      }
    }
  } else if (data is List<dynamic>) {
    for (var item in data) {
      return aux(data);
    }
  }
}

void main() async {
  // var file = await FileUploader.uploadSingle();
  var file = File('D:\\OneDrive\\NorseKode\\data\\facebook-lukasvlarsen\\posts\\your_posts_1.json');

  if (file != null) {
    var jsonString = await file.readAsString();
    var jsonData = jsonDecode(jsonString);

    for (Map<String, dynamic> item in jsonData) {
      var res = aux(item);

      if (res != null) {
        print('res');
      }
    }
  }

  print("done");
}