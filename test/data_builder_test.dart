import 'dart:convert';
import 'dart:io';

import 'package:flutter_test/flutter_test.dart';
import 'package:pretty_json/pretty_json.dart';
import 'package:waultar/core/inodes/data_builder.dart';
import 'package:waultar/core/inodes/service_document.dart';
import 'package:waultar/core/inodes/tree_nodes.dart';
import 'package:path/path.dart' as dart_path;
import 'package:waultar/data/configs/objectbox.dart';

import 'objectbox/test_utils.dart';

Future<void> main() async {
  late final ObjectBox _context;
  final DataCategory testCategory =
      DataCategory(name: 'TEST', matchingFolders: []);
  final scriptDir = File(Platform.script.toFilePath()).parent;
  final String fbBasePath = '${scriptDir.path}/test/objectbox/data/Facebook/';
  final ServiceDocument fbService = ServiceDocument(
      serviceName: 'Facebook', companyName: 'Meta', image: 'some path');

  String instagramPostWithManyImages = '''
  {
      "media": [
        {
          "uri": "posts/media/your_posts/Landscape-Color-Test.jpg",
          "creation_timestamp": 1601488182,
          "title": ""
        },
        {
          "uri": "posts/media/your_posts/Landscape-Color-Test.jpg",
          "creation_timestamp": 1601488182,
          "title": ""
        },
        {
          "uri": "posts/media/your_posts/Landscape-Color-Test.jpg",
          "creation_timestamp": 1601488182,
          "title": ""
        },
        {
          "uri": "posts/media/your_posts/Landscape-Color-Test.jpg",
          "creation_timestamp": 1601488182,
          "title": ""
        }
      ],
      "title": "This is a test",
      "creation_timestamp": 1601488182
  }
''';

  String fbpostWithOneImage = '''
    {
      "timestamp": 1354805114,
      "attachments": [
        {
          "data": [
            {
              "media": {
                "uri": "posts/media/your_posts/Landscape-Color-Test.jpg",
                "creation_timestamp": 1354805114,
                "media_metadata": {
                  "photo_metadata": {
                    "exif_data": [
                      {
                        "upload_ip": "192.192.192.128"
                      }
                    ]
                  }
                },
                "title": "Mobiloverf\u00c3\u00b8rsler",
                "description": "Sne sne!"
              }
            }
          ]
        }
      ],
      "data": [
        {
          "post": "Sne sne!"
        }
      ],
      "title": "Malou Elmelund Landsgaard har tilf\u00c3\u00b8jet et nyt billede."
    }
  ''';

  const String fbpostWithTwoImages = '''
    {
      "timestamp": 1273171899,
      "attachments": [
        {
          "data": [
            {
              "media": {
                "uri": "posts/media/your_posts/Landscape-Color-Test.jpg",
                "creation_timestamp": 1273171899,
                "title": "Mobile Uploads",
                "description": "Flot landskab"
              }
            },
            {
              "media": {
                "uri": "posts/media/your_posts/ITU-Test.jpg",
                "creation_timestamp": 1273171899,
                "title": "Mobile Uploads",
                "description": "Det her er ITU"
              }
            }
          ]
        }
      ],
      "data": [
        {
          "post": "Tja hvad skal man sige"
        }
      ],
      "title": "Lukas Vinther Offenberg Larsen added a new photos."
    }
  ''';
  group('Facebook databuilder', () {
    test(' - datapoint with one image relation', () {
      var dataName = DataPointName(name: 'Test name');
      var builder = DataBuilder(fbBasePath);

      builder
        ..setName(dataName)
        ..setCategory(testCategory)
        ..setService(fbService)
        ..setData(fbpostWithOneImage);

      final dataPoint = builder.build();
      expect(dataPoint.images.isNotEmpty, true);
      var image = dataPoint.images.first;
      var imageData = jsonDecode(image.data);
      expect(
          image.uri,
          dart_path.normalize(
              '$fbBasePath/posts/media/your_posts/Landscape-Color-Test.jpg'));
      expect(imageData.length, 5);
      expect(image.service.hasValue, true);
      expect(image.service.target!.serviceName, 'Facebook');
    });

    test(' - datapoint with two image relations', () {
      var dataName = DataPointName(name: 'Test name');
      var builder = DataBuilder(fbBasePath);

      builder
        ..setName(dataName)
        ..setCategory(testCategory)
        ..setService(fbService)
        ..setData(fbpostWithTwoImages);

      final dataPoint = builder.build();
      expect(dataPoint.images.length, 2);
    });
  });

  group('Builder with instagram post', () {
    test(' - post with four images', () {
      var dataName = DataPointName(name: 'Test name');
      var builder = DataBuilder(fbBasePath);

      builder
        ..setName(dataName)
        ..setCategory(testCategory)
        ..setService(fbService)
        ..setData(instagramPostWithManyImages);
      final dataPoint = builder.build();
      expect(dataPoint.images.length, 4);
      expect(
          dataPoint.images.first.uri,
          dart_path.normalize(
              '$fbBasePath/posts/media/your_posts/Landscape-Color-Test.jpg'));
    });
  });
}
