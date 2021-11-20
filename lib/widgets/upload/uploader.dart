import 'package:flutter/material.dart';
import 'package:waultar/globals/scaffold_main.dart';
import 'package:waultar/widgets/upload/upload_files.dart';

class UploaderView extends StatefulWidget {
  const UploaderView({Key? key}) : super(key: key);

  @override
  _UploaderViewState createState() => _UploaderViewState();
}

class _UploaderViewState extends State<UploaderView> {
  
  _pickSignleFilesButton() {
    return ElevatedButton(
      onPressed: () async {
        var files = await FileUploader.uploadSingle();
        var int = 2;
      },
      child: const Text('Pick Multiple Files'),
    );
  }
  
  _pickMultipleFilesButton() {
    return ElevatedButton(
      onPressed: () async {
        var files = await FileUploader.uploadMultiple();
        var int = 2;
      },
      child: const Text('Pick Multiple Files'),
    );
  }

  @override
  Widget build(BuildContext context) {
    return getScaffoldMain(
      context,
      Center(
        child: Column(
          children: [
            const Text('Uploader'),
            _pickSignleFilesButton(),
            _pickMultipleFilesButton(),
          ],
        ),
      ),
    );
  }
}
