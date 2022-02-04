import 'package:flutter_test/flutter_test.dart';
import 'package:waultar/domain/services/parser_service.dart';
import 'package:waultar/presentation/widgets/upload/upload_files.dart';

Future<void> main() async {
  // late UploadService _service;

  setUpAll(() {
    // _service = UploadService();
  });

  tearDownAll(() async {
    
  });

  group('extract test_zip.zip file', () {
    test('print the content', () async {
      var list = await FileUploader.extractZip('test/upload/zip_test.zip');
      expect(list.isNotEmpty, true);
    });

  });
}
