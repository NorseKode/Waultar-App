import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:waultar/core/abstracts/abstract_repositories/i_service_repository.dart';
import 'package:waultar/core/abstracts/abstract_services/i_collections_service.dart';
import 'package:waultar/core/inodes/inode.dart';
import 'package:waultar/core/inodes/inode_parser.dart';
import 'package:waultar/core/models/content/post_model.dart';
import 'package:waultar/domain/services/browse_service.dart';
import 'package:waultar/domain/services/parser_service.dart';
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

  final IServiceRepository _serviceRepo =
      locator.get<IServiceRepository>(instanceName: 'serviceRepo');

  bool isLoading = false;

  // final InodeParserService _inodeParserService =
  //     locator.get<InodeParserService>(instanceName: 'inodeParser');
  final ICollectionsService _collectionsService =
      locator.get<ICollectionsService>(instanceName: 'collectionsService');
  late List<DataCategory> _categories;

  @override
  void initState() {
    super.initState();
    _categories = _collectionsService.getAllCategories();
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
            // await _inodeParserService
            //     .parse(uploadedFiles)
            //     .whenComplete(() => setState(() {
            //           isLoading = false;
            //           SnackBarCustom.useSnackbarOfContext(
            //               context, localizer.doneLoadingData);
            //         }));
          }
        }
      },
      text: localizer.upload,
    );
  }

  categoriesColumn() {
    return Expanded(
      flex: 1,
      child: ListView.builder(
        scrollDirection: Axis.vertical,
        itemCount: _categories.length,
        itemBuilder: (_, index) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              InkWell(
                onTap: () => print(_categories[index].name),
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
      ),
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
              const SizedBox(
                height: 20,
              ),
              categoriesColumn()
            ],
          );
  }
}
