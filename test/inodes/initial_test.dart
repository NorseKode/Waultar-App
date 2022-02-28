import 'dart:convert';
import 'dart:io';

import 'package:flutter_test/flutter_test.dart';
import 'package:path/path.dart' as path_dart;
import 'package:pretty_json/pretty_json.dart';
import 'package:waultar/core/inodes/inode.dart';
import 'package:waultar/core/inodes/inode_parser.dart';
import '../test_helper.dart';

main() {
  var facebookProfileV2File = File(path_dart.join(
      TestHelper.pathToCurrentFile(), "data", "v2_profile_information.json"));

  var flattenTestFile = File(path_dart.join(
      TestHelper.pathToCurrentFile(folder: 'inodes'), "data", "flatten_data.json"));

  var simpleFlatten = File(path_dart.join(
      TestHelper.pathToCurrentFile(folder: 'inodes'), "data", "one_flatten_data.json"));

  final InodeParser _parser = InodeParser();

  setUpAll(() {
    TestHelper.clearTestLogger();
    TestHelper.createTestLogger();
  });

  group("Test parsing of profile data as inodes : ", () {
    test('Facebook profile via v2_profile_information.json', () async {
      var resultStream = _parser.parseFile(facebookProfileV2File);
      var dataPoints = await resultStream
          .where((event) => event is InodeDataPoint)
          .cast<InodeDataPoint>()
          .where((datapoint) =>
              datapoint.dataPointName.target!.name == 'profile_v2')
          .toList();

      // for (var element in dataPoints) {
      //   // ignore: avoid_print
      //   print(element.toString());
      // }

      expect(dataPoints.length, 1);
    });

    test('flatten test', () async {
      var json = await _parser.getJson(simpleFlatten);
      var result = _parser.flatten(simpleFlatten.path, json);
      
      // ignore: avoid_print
      print(prettyJson(result));
    });

  });
}
