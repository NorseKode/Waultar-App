import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:tuple/tuple.dart';

import 'upload_files.dart';

class Uploader {
  static Future<Tuple2<List<String>, String>?> uploadDialogue(BuildContext context) async {
    var localizer = AppLocalizations.of(context)!;

    return showDialog<Tuple2<List<String>, String>?>(
      context: context,
      builder: (BuildContext context) {
        var services = ["Facebook", "Instagram"];
        var dropDownValue = services[0];

        return SimpleDialog(
          title: Text(localizer.upload),
          children: [
            // SimpleDialogOption(
            //   onPressed: () async {
            //     var directory = await FileUploader.uploadDirectory();
            //     Navigator.pop(context, directory != null ? [directory] : [""]);
            //   },
            //   child: Text(localizer.uploadDirectory),
            // ),
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: StatefulBuilder(
                builder: (BuildContext context, StateSetter dropDownState) {
                  return DropdownButton<String>(
                    value: dropDownValue,
                    items: services.map<DropdownMenuItem<String>>(
                      (String service) {
                        return DropdownMenuItem<String>(value: service, child: Text(service));
                      },
                    ).toList(),
                    onChanged: (String? temp) {
                      dropDownState(() {
                        dropDownValue = temp!;
                      });
                    },
                  );
                },
              ),
            ),
            SimpleDialogOption(
              onPressed: () async {
                var files = await FileUploader.uploadMultiple();
                
                if (files != null) {
                  Navigator.pop(context, Tuple2(files.map((e) => e.path).toList(), dropDownValue));
                }
              },
              child: Text(localizer.uploadFiles),
            ),
          ],
        );
      },
    );
  }
}
