import 'dart:io';
import 'package:waultar/screens/temp/test1.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:waultar/models/settings.dart';
import 'package:waultar/widgets/upload/uploader.dart';
import 'package:waultar/screens/temp/file_sorting.dart';

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
      print("test1 - given empty list returns empty list");
      List<File> fileList = [];
      var actual = _getImages(fileList).length;
      expect(actual, 0);
    });

    test("test2 - given list returns image files", () async {
      print("test2 - given list returns image files");
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
    List<List<File>> _sortFileLists(List<File> fileList) {
      var imageFormats = ['.jpg', '.jpeg', '.png', '.tif', '.tiff', '.gif'];
      var pathMap = fileList.map((item) => item.path);

      List<List<File>> listOfLists = [];
      imageFormats.forEach((format) async {
        List<File> s = [];
        pathMap.forEach((item) => item.endsWith(format)
            ? s.add(File(item))
            : {pathMap.iterator.moveNext()});

        if (s.isNotEmpty) listOfLists.add(s);
      });
      return listOfLists;
    }

    test("test1 - given empty list returns empty list", () async {
      print("test1 - given empty list returns empty list");
      List<File> fileList = [];
      var actual = _sortFileLists(fileList);
      expect(actual, []);
    });

    test("test2 - given list returns list with lists", () async {
      print("test2 - given list returns list with lists");
      List<File> fileList = [
        File("/lib/assets/Paws_blue.png"),
        File("file.html"),
        File("image.jpeg")
      ];
      var actual = _sortFileLists(fileList).length;
      expect(actual, 2);
    });
  });

  tearDownAll(() async {});
}
