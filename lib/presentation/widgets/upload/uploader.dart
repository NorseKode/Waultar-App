import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:provider/provider.dart';
import 'package:tuple/tuple.dart';
import 'package:waultar/presentation/providers/theme_provider.dart';
import 'package:waultar/presentation/utils/text_validators.dart';
import 'package:waultar/presentation/widgets/general/default_widgets/default_button.dart';
import 'package:waultar/presentation/widgets/general/default_widgets/default_dropdown.dart';

import 'upload_files.dart';

class Uploader {
  static Future<Tuple3<List<String>, String, String>?> uploadDialogue(
      BuildContext context) async {
    var localizer = AppLocalizations.of(context)!;
    ThemeProvider _themeProvider =
        Provider.of<ThemeProvider>(context, listen: false);
    var usernameTextController = TextEditingController();

    return showDialog<Tuple3<List<String>, String, String>?>(
      context: context,
      builder: (BuildContext context) {
        var services = ["Facebook", "Instagram"];
        var dropDownValue = services[0];

        var formKey = GlobalKey<FormState>();

        return SimpleDialog(
          title: Text(localizer.upload),
          backgroundColor: _themeProvider.themeData().scaffoldBackgroundColor,
          children: [
            // Padding(
            //   padding: const EdgeInsets.fromLTRB(20, 10, 20, 10),
            //   child: Form(
            //     key: formKey,
            //     child: TextFormField(
            //       decoration: const InputDecoration(
            //         icon: Icon(Icons.person),
            //         hintText: "Service profile username",
            //         label: Text("Username"),
            //       ),
            //       controller: usernameTextController,
            //       validator: TextValidators.waultarServiceUsername,
            //     ),
            //   ),
            // ),

            Padding(
                padding: const EdgeInsets.fromLTRB(20, 10, 20, 10),
                child: Form(
                  key: formKey,
                  child: TextFormField(
                      style: const TextStyle(fontSize: 12),
                      cursorWidth: 1,
                      controller: usernameTextController,
                      validator: TextValidators.waultarServiceUsername,
                      decoration: InputDecoration(
                        contentPadding: const EdgeInsets.all(15),
                        isDense: true,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(5.0),
                          borderSide: BorderSide.none,
                        ),
                        filled: true,
                        fillColor: (const Color(0xFF272837)),
                        hintText: "Choose profile username",
                        hintStyle: const TextStyle(letterSpacing: 0.3),
                      )),
                )),
            Padding(
              padding: const EdgeInsets.fromLTRB(20, 10, 20, 10),
              child: StatefulBuilder(
                builder: (BuildContext context, StateSetter dropDownState) {
                  return DefaultDropdown(
                    value: DefaultMenuItem(
                        name: dropDownValue, value: dropDownValue),
                    items: services.map<DefaultMenuItem>(
                      (String service) {
                        return DefaultMenuItem(name: service, value: service);
                      },
                    ).toList(),
                    onChanged: (DefaultMenuItem? temp) {
                      dropDownState(() {
                        dropDownValue =
                            temp != null ? temp.value : dropDownValue;
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
                  if (formKey.currentState != null &&
                      formKey.currentState!.validate()) {
                    var files = await FileUploader.uploadMultiple();

                    if (files != null) {
                      Navigator.pop(
                        context,
                        Tuple3(
                          files.map((e) => e.path).toList(),
                          usernameTextController.text.trim(),
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
