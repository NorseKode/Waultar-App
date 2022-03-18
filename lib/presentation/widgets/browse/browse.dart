import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:waultar/core/abstracts/abstract_repositories/i_service_repository.dart';
import 'package:waultar/core/abstracts/abstract_services/i_collections_service.dart';
import 'package:waultar/core/inodes/tree_nodes.dart';
import 'package:waultar/core/inodes/tree_parser.dart';
import 'package:waultar/domain/services/browse_service.dart';
import 'package:waultar/domain/services/time_buckets_creator.dart';
import 'package:waultar/presentation/providers/theme_provider.dart';
import 'package:waultar/presentation/widgets/general/default_widgets/default_widget.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:waultar/presentation/widgets/general/default_widgets/post_widget.dart';
import 'package:waultar/presentation/widgets/general/util_widgets/default_button.dart';
import 'package:waultar/presentation/widgets/snackbar_custom.dart';
import 'package:waultar/presentation/widgets/upload/upload_files.dart';
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
  final _browseService = BrowseService();

  List<dynamic>? _models;
  late ThemeProvider themeProvider;

  final TreeParser parser = locator.get<TreeParser>(instanceName: 'parser');

  final IServiceRepository _serviceRepo =
      locator.get<IServiceRepository>(instanceName: 'serviceRepo');

  bool isLoading = false;

  // final InodeParserService _inodeParserService =
  //     locator.get<InodeParserService>(instanceName: 'inodeParser');
  final ICollectionsService _collectionsService =
      locator.get<ICollectionsService>(instanceName: 'collectionsService');
  late List<DataCategory> _categories;
  late List<DataPointName> _names;

  @override
  void initState() {
    super.initState();
    _categories = _collectionsService.getAllCategories();
    _names = _collectionsService.getAllNamesFromCategory(_categories.first);
  }

  uploadButton() {
    return DefaultButton(
      onPressed: () async {
        var files = await Uploader.uploadDialogue(context);

        if (files != null) {
          SnackBarCustom.useSnackbarOfContext(
              context, localizer.startedLoadingOfData);
          var service = _serviceRepo.get(files.item2);

          if (service != null) {
            setState(() {
              isLoading = true;
            });
            var zipFiles = files.item1
                .where((element) => dart_path.extension(element) == ".zip")
                .toList();

            var inputMap = {
              'path': dart_path.normalize(zipFiles.first),
              'extracts_folder':
                  locator.get<String>(instanceName: 'extracts_folder'),
              'service_name': service.name
            };
            var uploadedFiles = await compute(extractZip, inputMap);
            await parser
                .parseManyPaths(uploadedFiles)
                .whenComplete(() => setState(() {
                      _categories = _collectionsService.getAllCategories();
                      isLoading = false;
                      SnackBarCustom.useSnackbarOfContext(
                          context, localizer.doneLoadingData);
                    }));
          }
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
                print(_categories[index].name);
                setState(() {
                  _names = _collectionsService
                      .getAllNamesFromCategory(_categories[index]);
                });
              },
              child: Text(_categories[index].name +
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
        ? const Center(child: CircularProgressIndicator())
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
              Flexible(
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
