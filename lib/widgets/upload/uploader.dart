import 'package:flutter/material.dart';
import 'package:waultar/globals/scaffold_main.dart';

import 'upload_files.dart';

class UploaderComponent extends StatefulWidget {
  const UploaderComponent({Key? key}) : super(key: key);

  @override
  _UploaderComponentState createState() => _UploaderComponentState();
}

class _UploaderComponentState extends State<UploaderComponent> {
  _uploadSingleFileButton(BuildContext context) {
    return ElevatedButton(
      onPressed: () async {
        var file = await FileUploader.uploadSingle();
        if (file != null) {
          print(file.path);
        }

        Navigator.pop(context, file);
      },
      child: const Text('Press'),
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
            _uploadSingleFileButton(context),
          ],
        ),
      ),
    );
  }
}
