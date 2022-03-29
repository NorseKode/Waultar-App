// ignore_for_file: avoid_print
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:waultar/core/abstracts/abstract_repositories/i_service_repository.dart';
import 'package:waultar/core/abstracts/abstract_services/i_collections_service.dart';
import 'package:waultar/core/abstracts/abstract_services/i_parser_service.dart';
import 'package:waultar/core/parsers/tree_parser.dart';
import 'package:waultar/data/entities/nodes/category_node.dart';
import 'package:waultar/data/entities/nodes/name_node.dart';
import 'package:waultar/presentation/providers/theme_provider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:waultar/presentation/widgets/general/util_widgets/default_button.dart';
import 'package:waultar/presentation/widgets/snackbar_custom.dart';
import 'package:waultar/presentation/widgets/upload/uploader.dart';
import 'package:waultar/startup.dart';
import 'package:path/path.dart' as dart_path;

class Browse extends StatefulWidget {
  const Browse({Key? key}) : super(key: key);

  @override
  _BrowseState createState() => _BrowseState();
}

class _BrowseState extends State<Browse> {
  late AppLocalizations localizer;
  late ThemeProvider themeProvider;

  final TreeParser parser = locator.get<TreeParser>(instanceName: 'parser');
  final IServiceRepository _serviceRepo =
      locator.get<IServiceRepository>(instanceName: 'serviceRepo');
  final _parserService =
      locator.get<IParserService>(instanceName: 'parserService');

  bool isLoading = false;
  var _progressMessage = "Initializing";

  final ICollectionsService _collectionsService =
      locator.get<ICollectionsService>(instanceName: 'collectionsService');

  late List<DataCategory> _categories;
  late List<DataPointName> _names;

  @override
  void initState() {
    super.initState();
    _categories = _collectionsService.getAllCategories();
    if (_categories.isEmpty) {
      _names = [];
    } else {
      _names = _collectionsService.getAllNamesFromCategory(_categories.first);
    }
  }

  _onUploadProgress(String message, bool isDone) {
    setState(() {
      _progressMessage = message;
      isLoading = !isDone;
      if (!isLoading) {
        _categories = _collectionsService.getAllCategories();
      }
    });
  }

  uploadButton() {
    return DefaultButton(
      onPressed: () async {
        var files = await Uploader.uploadDialogue(context);

        if (files != null) {
          SnackBarCustom.useSnackbarOfContext(
              context, localizer.startedLoadingOfData);

          setState(() {
            isLoading = true;
          });

          var zipFile = files.item1
              .singleWhere((element) => dart_path.extension(element) == ".zip");

          await _parserService.parseIsolates(
              zipFile, _onUploadProgress, files.item2);
          // await _parserService.parseMain(zipFile, files.item2);

        }
      },
      text: localizer.upload,
    );
  }

  categoriesColumn() {
    return ListView.builder(
      // shrinkWrap: true,
      scrollDirection: Axis.vertical,
      itemCount: _categories.length,
      itemBuilder: (_, index) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            InkWell(
              onTap: () {
                print(_categories[index].category.name);
                setState(() {
                  _names = _collectionsService
                      .getAllNamesFromCategory(_categories[index]);
                });
              },
              child: Text(_categories[index].category.name +
                  "   " +
                  _categories[index].count.toString()),
            ),
            const Divider(
              thickness: 2.0,
            )
          ],
        );
      },
    );
  }

  namesColumn() {
    return ListView.builder(
      scrollDirection: Axis.vertical,
      // shrinkWrap: true,
      itemCount: _names.length,
      itemBuilder: (_, index) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            InkWell(
              onTap: () {
                print(_names[index].name);
              },
              child: Text(
                  _names[index].name + "   " + _names[index].count.toString()),
            ),
            const Divider(
              thickness: 2.0,
            )
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    localizer = AppLocalizations.of(context)!;
    themeProvider = Provider.of<ThemeProvider>(context);

    return isLoading
        ? Center(
            child: Column(
            children: [
              Text(_progressMessage),
              const CircularProgressIndicator(),
            ],
          ))
        : Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Text(
                    "Browse",
                    style: themeProvider.themeData().textTheme.headline3,
                  ),
                  const SizedBox(
                    width: 20,
                  ),
                  uploadButton()
                ],
              ),
              const SizedBox(
                height: 20,
              ),
              _categories.length < 2
                  ? Container(
                      child: const Text("You haven't uploaded any data yet "),
                    )
                  : Flexible(
                      child: GridView.count(
                        physics: const NeverScrollableScrollPhysics(),
                        childAspectRatio: 0.7,
                        crossAxisCount: 2,
                        crossAxisSpacing: 10,
                        // shrinkWrap: true,
                        children: [
                          categoriesColumn(),
                          namesColumn(),
                        ],
                      ),
                    ),
            ],
          );
  }
}
