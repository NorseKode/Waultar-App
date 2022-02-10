import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import 'upload_files.dart';
class Uploader {
  static Future<List<String>?> uploadDialogue(BuildContext context) {
    var localizer = AppLocalizations.of(context)!;

    return showDialog<List<String>?>(
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
                Navigator.pop(context, files != null ? files.map((e) => e.path).toList() : [""]);
              },
              child: Text(localizer.uploadFiles),
            )
          ],
        );
      },
    );
  }
}
