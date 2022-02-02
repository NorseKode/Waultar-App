import 'dart:io';

List<File> getImages(List<File> fileList) {
  var imageFormats = ['.jpg', '.jpeg', '.png', '.tif', '.tiff', '.gif'];

  var images = fileList
      .map((item) => item.path)
      .where((item) => imageFormats.any((ext) => item.endsWith(ext)))
      .toList(growable: false);

  return List.generate(images.length, (index) => File(images[index]));
}

List<List<File>> sortListToFormatSubList(List<File> fileList) {
  var imageFormats = [
    '.jpg',
    '.jpeg',
    '.png',
    '.tif',
    '.tiff',
    '.gif',
    '.html',
    '.json'
  ];
  var pathMap = fileList.map((item) => item.path);

  List<List<File>> listOfLists = [];
  for (var format in imageFormats) {
    List<File> s = [];
    for (var item in pathMap) {
      item.endsWith(format)
        ? s.add(File(item))
        : {pathMap.iterator.moveNext()};
    }

    if (s.isNotEmpty) listOfLists.add(s);
  }
  return listOfLists;
}
