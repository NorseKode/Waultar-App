import 'package:flutter/material.dart';
import 'package:waultar/globals/scaffold_main.dart';

import 'upload_files.dart';

class UploaderComponent extends StatefulWidget {
  const UploaderComponent({Key? key}) : super(key: key);

  @override
  _UploaderComponentState createState() => _UploaderComponentState();
}

class _UploaderComponentState extends State<UploaderComponent> {
  _uploadFilesButton(BuildContext context, bool isFile) {
    return ElevatedButton(
      onPressed: () async {
        var file =
            isFile ? await FileUploader.uploadMultiple() : await FileUploader.uploadDirectory();

        Navigator.pop(context, file);
      },
      child: Text(isFile ? 'Upload file' : 'Upload folder'),
    );
  }

  @override
  Widget build(BuildContext context) {
    return getScaffoldMain(
      context,
      Center(
        child: Column(
          children: [
            const Text('uploader'),
            _uploadFilesButton(context, true),
            _uploadFilesButton(context, false),
          ],
        ),
      ),
    );
  }
}
