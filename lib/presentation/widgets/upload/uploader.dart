import 'package:flutter/material.dart';
import 'package:waultar/configs/globals/scaffold_main.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import 'upload_files.dart';
class Uploader {
  static uploadDialogue(BuildContext context) {
    var localizer = AppLocalizations.of(context)!;

    return showDialog(
      context: context,
      builder: (BuildContext context) {
        return SimpleDialog(
          title: Text(localizer.upload),
          children: [
            SimpleDialogOption(
              onPressed: () async {
                var directory = await FileUploader.uploadDirectory();
                Navigator.pop(context, directory != null ? [directory] : [""]);
              },
              child: Text(localizer.uploadDirectory),
            ),
            SimpleDialogOption(
              onPressed: () async {
                var files = await FileUploader.uploadMultiple();
                Navigator.pop(context, files != null ? files : [""]);
              },
              child: Text(localizer.uploadFiles),
            )
          ],
        );
      },
    );
  }
}
