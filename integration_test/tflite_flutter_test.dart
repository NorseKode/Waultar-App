
// ignore_for_file: avoid_print

import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:path_provider/path_provider.dart';
import 'package:tflite_flutter/tflite_flutter.dart' as tfl;

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  test('tfl version', () {
    expect(tfl.version, isNotEmpty);
    print('Tenserflow Lite version: ${tfl.version}');
  });

  
}