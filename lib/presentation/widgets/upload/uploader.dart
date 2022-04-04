import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:tuple/tuple.dart';
import 'package:waultar/presentation/utils/text_validators.dart';
import 'package:waultar/presentation/widgets/general/util_widgets/default_button.dart';

import 'upload_files.dart';

class Uploader {
  static Future<Tuple3<List<String>, String, String>?> uploadDialogue(BuildContext context) async {
    var localizer = AppLocalizations.of(context)!;

    return showDialog<Tuple3<List<String>, String, String>?>(
      context: context,
      builder: (BuildContext context) {
        var services = ["Facebook", "Instagram"];
        var dropDownValue = services[0];
        var usernameTextController = TextEditingController();
        var formKey = GlobalKey<FormState>();

        return SimpleDialog(
          title: Text(localizer.upload),
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(20, 10, 20, 10),
              child: Form(
                key: formKey,
                child: TextFormField(
                  decoration: const InputDecoration(
                    icon: Icon(Icons.person),
                    hintText: "Service profile username",
                    label: Text("Username"),
                  ),
                  controller: usernameTextController,
                  validator: TextValidators.waultarServiceUsername,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(20, 10, 20, 10),
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
            Padding(
              padding: const EdgeInsets.fromLTRB(20, 10, 20, 10),
              child: DefaultButton(
                onPressed: () async {
                  if (formKey.currentState != null && formKey.currentState!.validate()) {
                    var files = await FileUploader.uploadMultiple();

                    if (files != null) {
                      Navigator.pop(
                        context,
                        Tuple3(
                          files.map((e) => e.path).toList(),
                          usernameTextController.text,
                          dropDownValue,
                        ),
                      );
                    }
                  }
                },
                text: localizer.uploadFiles,
              ),
            ),
          ],
        );
      },
    );
  }
}
