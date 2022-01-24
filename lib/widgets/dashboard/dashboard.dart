import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';
import 'package:waultar/parser/find_all_keys.dart';
import 'package:waultar/providers/theme_provider.dart';
import 'package:waultar/widgets/upload/upload_files.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class Dashboard extends StatefulWidget {
  const Dashboard({Key? key}) : super(key: key);

  @override
  _DashboardState createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  late AppLocalizations localizer;
  late ThemeProvider themeProvider;
  List<File> uploadedFiles = [];

  Widget addIcon(double size, Color color) {
    const assetName = 'lib/assets/icons/fi-rr-plus.svg';
    final Widget svg = SvgPicture.asset(assetName,
        semanticsLabel: 'plus', height: size, color: color);
    return svg;
  }

  _upload(BuildContext context, bool isFile) async {
    var file = isFile
        ? await FileUploader.uploadMultiple()
        : await FileUploader.uploadDirectory();
    file != null ? uploadedFiles = file : null;
    setState(() {});
  }

  uploadedWidgets() {
    List<Widget> files = [];
    List<Widget> images = [];
    uploadedFiles.map((item) {
      switch (item.path.split('.').last) {
        case 'png':
        case 'jpg':
          images.add(Padding(
            padding: const EdgeInsets.all(8.0),
            child: Image.file(item, height: 200),
          ));
          return null;
        default:
          files.add(Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              item.path.split('\\').last,
              style: themeProvider.themeMode().bodyText4,
            ),
          ));
          return null;
      }
    }).toList();
    return Column(children: [
      files.isEmpty
          ? const SizedBox.shrink()
          : Container(
              width: double.infinity,
              decoration: BoxDecoration(
                  color: themeProvider.themeMode().widgetBackground,
                  borderRadius: BorderRadius.circular(5)),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: files,
                ),
              ),
            ),
      files.isEmpty ? const SizedBox.shrink() : SizedBox(height: 20),
      images.isEmpty
          ? const SizedBox.shrink()
          : Container(
              width: double.infinity,
              decoration: BoxDecoration(
                  color: themeProvider.themeMode().widgetBackground,
                  borderRadius: BorderRadius.circular(5)),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Wrap(
                  children: images,
                ),
              ),
            ),
    ]);
  }

  int typeSort(var a, var b) {
    if (a is Text && b is Image)
      return -1;
    else if (b is Text && a is Image)
      return 1;
    else
      return -1;
  }

  Widget addButton() {
    return PopupMenuButton(
      tooltip: '',
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(
          Radius.circular(5.0),
        ),
      ),
      elevation: 4,
      offset: const Offset(0.0, 40.0),
      color: themeProvider.themeMode().highlightedPrimary,
      itemBuilder: (BuildContext context) => <PopupMenuEntry<String>>[
        PopupMenuItem<String>(
            onTap: () async => await _upload(context, true),
            padding: EdgeInsets.zero,
            value: localizer.newData,
            child: Padding(
              padding: const EdgeInsets.all(4.0),
              child: ListTile(
                dense: true,
                title: Row(children: [
                  addIcon(15, Colors.grey),
                  const SizedBox(
                    width: 20,
                  ),
                  Text(
                    localizer.newData,
                    style: themeProvider.themeMode().bodyText3,
                  )
                ]),
              ),
            )),
        PopupMenuItem<String>(
            padding: EdgeInsets.zero,
            value: localizer.newWidget,
            child: Padding(
              padding: const EdgeInsets.all(4.0),
              child: ListTile(
                dense: true,
                title: Row(children: [
                  addIcon(15, Colors.grey),
                  const SizedBox(
                    width: 20,
                  ),
                  Text(
                    localizer.newWidget,
                    style: themeProvider.themeMode().bodyText3,
                  )
                ]),
              ),
            ))
      ],
      child: Container(
          padding: const EdgeInsets.fromLTRB(15, 5, 15, 5),
          decoration: BoxDecoration(
              color: themeProvider.themeMode().themeColor,
              borderRadius: const BorderRadius.all(Radius.circular(5))),
          child: Row(children: [
            addIcon(10, Colors.white),
            const SizedBox(
              width: 10,
            ),
            Text(
              localizer.add,
              style: themeProvider.themeData().textTheme.bodyText2,
            )
          ])),
    );
  }

  @override
  Widget build(BuildContext context) {
    localizer = AppLocalizations.of(context)!;
    
    themeProvider = Provider.of<ThemeProvider>(context);
    return Padding(
      padding: const EdgeInsets.fromLTRB(35, 22.5, 35, 0),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                localizer.dashboard,
                style: themeProvider.themeData().textTheme.headline3,
              ),
              addButton()
            ],
          ),
          const SizedBox(height: 22.5),
          Expanded(
            child: SingleChildScrollView(child: uploadedWidgets()),
          )
        ],
      ),
    );
  }
}
