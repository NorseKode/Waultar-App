import 'package:flutter_test/flutter_test.dart';
import 'package:waultar/domain/services/upload_service.dart';

Future<void> main() async {
  late UploadService _service;

  setUpAll(() {
    _service = UploadService();
  });

  tearDownAll(() async {
    
  });

  group('extract test_zip.zip file', () {
    test('print the content', () async {
      var archive = _service.extractZip('test/upload/zip_test.zip');
      expect(archive.isNotEmpty, true);
    });

  });
}
