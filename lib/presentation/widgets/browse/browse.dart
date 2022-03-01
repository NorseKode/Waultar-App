import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:waultar/core/abstracts/abstract_repositories/i_service_repository.dart';
import 'package:waultar/core/models/content/post_model.dart';
import 'package:waultar/domain/services/browse_service.dart';
import 'package:waultar/domain/services/parser_service.dart';
import 'package:waultar/presentation/providers/theme_provider.dart';
import 'package:waultar/presentation/widgets/general/default_widgets/default_widget.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:waultar/presentation/widgets/general/default_widgets/post_widget.dart';
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

  buttons() {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: [
          ElevatedButton(
            onPressed: () {
              setState(() {
                _models = _browseService.getProfiles();
              });
            },
            child: Text(localizer.profile),
          ),
          const SizedBox(
            width: 20,
          ),
          ElevatedButton(
            onPressed: () {
              setState(() {
                _models = _browseService.getPosts() ?? [];
              });
            },
            child: Text(localizer.posts),
          ),
          const SizedBox(
            width: 20,
          ),
          ElevatedButton(
            onPressed: () {
              // setState(() {
              //   _models = _browseService.getGroups();
              // });
            },
            child: Text(localizer.groups),
          ),
          const SizedBox(
            width: 20,
          ),
          ElevatedButton(
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
                      .where(
                          (element) => dart_path.extension(element) == ".zip")
                      .toList();

                  var inputMap = {
                    'path': dart_path.normalize(zipFiles.first),
                    'extracts_folder':
                        locator.get<String>(instanceName: 'extracts_folder')
                  };
                  var uploadedFiles = await compute(extractZip, inputMap);
                  await ParserService()
                      .parseAll(uploadedFiles, service)
                      .whenComplete(() => setState(() {
                            isLoading = false;
                            SnackBarCustom.useSnackbarOfContext(
                                context, localizer.doneLoadingData);
                          }));
                }
              }
            },
            child: Text(localizer.upload),
          ),
          const SizedBox(
            width: 20,
          ),
          ElevatedButton(
            onPressed: () {
              setState(() {
                _models = [];
              });
            },
            child: Text(localizer.clear),
          ),
          const SizedBox(
            width: 20,
          ),
        ],
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
              Text(
                "Browse",
                style: themeProvider.themeData().textTheme.headline3,
              ),
              const SizedBox(
                height: 20,
              ),
              buttons(),
              const SizedBox(
                height: 20,
              ),
              Expanded(
                child: SingleChildScrollView(
                  child: _models != null
                      ? SizedBox(
                          width: MediaQuery.of(context).size.width - 290,
                          child: Wrap(
                            spacing: 20,
                            runSpacing: 20,
                            children: List.generate(
                              _models!.length,
                              (index) => _models! is PostModel
                                  ? PostWidget(post: _models![index])
                                  : DefaultWidget(
                                      title: "Title",
                                      child: Text(
                                        _models![index].toString(),
                                      ),
                                    ),
                            ),
                          ))
                      : Container(),
                ),
              )
            ],
          );
  }
}

//Post list example:
    // List<Widget> postWidgets = List.generate(
    //     polls.length,
    //     (index) => PostWidget(
    //             post: PostModel(
    //                 tags: [
    //               TagModel(0, "Dinner Time!"),
    //               TagModel(0, "Lukin Off Arse"),
    //             ],
    //                 medias: [
    //               ImageModel(
    //                   profile: ParseHelper.profile,
    //                   raw: "",
    //                   uri: Uri(path: "lib/assets/graphics/Logo.png")),
    //               ImageModel(
    //                   profile: ParseHelper.profile,
    //                   raw: "",
    //                   uri: Uri(path: "lib/assets/graphics/data_graphic.png"))
    //             ],
    //                 mentions: [
    //               PersonModel(
    //                   profile: ParseHelper.profile, name: "LukASS", raw: ""),
    //               PersonModel(
    //                   profile: ParseHelper.profile, name: "LukasOff", raw: "")
    //             ],
    //                 isArchived: true,
    //                 title:
    //                     "Malou Landsgaard posted this on Lukas Offenbergs timeline",
    //                 description:
    //                     "Hi guys! I just wanna say that I had a great time today! See you next time",
    //                 profile: ParseHelper.profile,
    //                 raw: '',
    //                 timestamp: DateTime.now())));
