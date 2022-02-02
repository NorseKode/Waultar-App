import 'dart:io';
import 'package:flutter_test/flutter_test.dart';
import 'package:waultar/presentation/screens/temp/file_sorting.dart';

void main() {
  setUpAll(() async {});

  group('file sorter - getImages', () {
    var imageFormats = ['.jpg', '.jpeg', '.png', '.tif', '.tiff', '.gif'];

    _getImages(List<File> fileList) {
      var images = fileList
          .map((item) => item.path)
          .where((item) => imageFormats.any((ext) => item.endsWith(ext)))
          .toList(growable: false);

      return List.generate(images.length, (index) => File(images[index]));
    }

    test("test1 - given empty list returns empty list", () async {
      List<File> fileList = [];
      var actual = _getImages(fileList).length;
      expect(actual, 0);
    });

    test("test2 - given list returns image files", () async {
      List<File> fileList = [
        File("image.png"),
        File("file.html"),
        File("image.jpeg")
      ];
      var actual = _getImages(fileList).length;
      expect(actual, 2);
    });
  });

  group('file sorter - sortFileLists', () {
    test("test3 - given empty list returns empty list", () async {
      List<File> fileList = [];
      var actual = sortListToFormatSubList(fileList);
      expect(actual, []);
    });

    test("test4 - given list returns list with lists", () async {
      List<File> fileList = [
        File("/lib/assets/Paws_blue.png"),
        File("file.html"),
        File("image.jpeg")
      ];
      var actual = sortListToFormatSubList(fileList).length;
      expect(actual, 3);
    });
  });

  tearDownAll(() async {});
}
