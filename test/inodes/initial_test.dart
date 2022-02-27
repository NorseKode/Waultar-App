import 'dart:io';

import 'package:flutter_test/flutter_test.dart';
import 'package:path/path.dart' as path_dart;
import 'package:waultar/core/inodes/inode.dart';
import 'package:waultar/core/inodes/inode_parser.dart';
import '../test_helper.dart';

main() {
  var facebookProfileV2File = File(path_dart.join(
      TestHelper.pathToCurrentFile(), "data", "profile_information.json"));

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

      for (var element in dataPoints) {
        // ignore: avoid_print
        print(element.toString());
      }

      expect(dataPoints.length, 1);
    });
  });
}
