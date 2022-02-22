import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:waultar/core/abstracts/abstract_repositories/i_service_repository.dart';
import 'package:waultar/domain/services/parser_service.dart';
import 'package:waultar/presentation/providers/theme_provider.dart';
import 'package:waultar/presentation/widgets/upload/upload_files.dart';
import 'package:waultar/presentation/widgets/upload/uploader.dart';
import 'package:waultar/startup.dart';
import 'package:path/path.dart' as dart_path;

class Dashboard extends StatefulWidget {
  const Dashboard({Key? key}) : super(key: key);

  @override
  _DashboardState createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  late AppLocalizations localizer;
  late ThemeProvider themeProvider;
  List<File> uploadedFiles = [];
  final IServiceRepository _serviceRepo =
      locator.get<IServiceRepository>(instanceName: 'serviceRepo');

  bool loading = false;

  Widget addIcon(double size, Color color) {
    const assetName = 'lib/assets/icons/fi-rr-plus.svg';
    final Widget svg =
        SvgPicture.asset(assetName, semanticsLabel: 'plus', height: size, color: color);
    return svg;
  }

  // _upload(BuildContext context, bool isFile) async {
  //   var file = isFile
  //       ? await FileUploader.uploadMultiple()
  //       : await FileUploader.uploadFilesFromDirectory();
  //   file != null ? uploadedFiles = file : null;
  //   setState(() {});
  // }

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
      files.isEmpty ? const SizedBox.shrink() : const SizedBox(height: 20),
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
    if (a is Text && b is Image) {
      return -1;
    } else if (b is Text && a is Image) {
      return 1;
    } else {
      return -1;
    }
  }

  Widget addButton(BuildContext parentContext) {
    return ElevatedButton(
      onPressed: () async {
        var files = await Uploader.uploadDialogue(context);
        if (files != null) {
          var service = _serviceRepo.get(files.item2);

          if (service != null) {
            setState(() {
              loading = true;
            });
            var zipFiles =
                files.item1.where((element) => dart_path.extension(element) == ".zip").toList();

            var inputMap = {'path': dart_path.normalize(zipFiles.first), 'extracts_folder': locator.get<String>(instanceName: 'extracts_folder')};
            var uploadedFiles = await compute(extractZip, inputMap);
            await ParserService().parseAll(uploadedFiles, service).whenComplete(() => setState(() {
                  loading = false;
                }));
          }
        }
      },
      child: Container(
        padding: const EdgeInsets.fromLTRB(15, 5, 15, 5),
        decoration: BoxDecoration(
            color: themeProvider.themeMode().themeColor,
            borderRadius: const BorderRadius.all(Radius.circular(5))),
        child: Row(
          children: [
            addIcon(10, Colors.white),
            const SizedBox(
              width: 10,
            ),
            Text(
              localizer.add,
              style: themeProvider.themeData().textTheme.bodyText2,
            )
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    localizer = AppLocalizations.of(context)!;

    themeProvider = Provider.of<ThemeProvider>(context);
    return loading
        ? const Center(child: CircularProgressIndicator())
        : Padding(
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
                    addButton(context),
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
