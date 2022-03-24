import 'dart:io';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:waultar/configs/globals/globals.dart';
import 'package:waultar/configs/globals/helper/performance_helper.dart';
import 'package:waultar/core/abstracts/abstract_repositories/i_service_repository.dart';
import 'package:waultar/core/abstracts/abstract_services/i_ml_service.dart';
import 'package:waultar/core/inodes/media_repo.dart';
import 'package:waultar/presentation/providers/theme_provider.dart';
import 'package:waultar/presentation/widgets/general/default_widgets/default_widget.dart';

import 'package:waultar/presentation/widgets/general/util_widgets/default_button.dart';

import 'package:waultar/startup.dart';

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
  final _mlService = locator.get<IMLService>(instanceName: 'mlService');
  final _mediaRepo = locator.get<MediaRepository>(instanceName: 'mediaRepo');
  var _imagesToTagCount = 0;
  var _isLoading = false;

  Widget _imageTaggingWidget() {
    return DefaultWidget(
      title: "Image Classification",
      child: Column(
        children: [
          Text("Untagged Images Count: $_imagesToTagCount"),
          Text("Estimated Time To Tag All: ${(_imagesToTagCount * 0.5) / 60} minuets"),
          DefaultButton(
            text: "Tag Images",
            onPressed: () {
              PerformanceHelper? performance;
              setState(() {
                _isLoading = true;
              });

              if (ISPERFORMANCETRACKING) {
                performance = PerformanceHelper(
                  pathToPerformanceFile: locator.get<String>(instanceName: 'performance_folder'),
                  parentKey: "Image tagging",
                );
                performance.start();
              }

              _mlService.classifyImagesFromDB();

              if (ISPERFORMANCETRACKING) {
                performance!.stopParentAndWriteToFile(
                  "image-tagging",
                  metadata: "Image count: $_imagesToTagCount",
                );
              }

              setState(() {
                _isLoading = false;
              });
            },
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    localizer = AppLocalizations.of(context)!;
    themeProvider = Provider.of<ThemeProvider>(context);
    final services = _serviceRepo.getAll();
    _imagesToTagCount = _mediaRepo.getAmountOfUnTaggedImages();

    // List<Widget> serviceWidgets = List.generate(
    //     services.length, (e) => ServiceWidget(service: services[e]));
    List<Widget> serviceWidgets = [];

    return _isLoading
        // ignore: avoid_unnecessary_containers
        ? Container(
            child: const Center(
              child: CircularProgressIndicator(),
            ),
          )
        : Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                localizer.dashboard,
                style: themeProvider.themeData().textTheme.headline3,
              ),
              const SizedBox(height: 20),
              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SingleChildScrollView(
                        //service widgets
                        scrollDirection: Axis.horizontal,
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: List.generate(
                            serviceWidgets.length,
                            (index) => Padding(
                              padding: const EdgeInsets.only(right: 20),
                              child: serviceWidgets[index],
                            ),
                          ),
                        ),
                      ),
                      if (_imagesToTagCount > 0) const SizedBox(height: 20),
                      if (_imagesToTagCount > 0) _imageTaggingWidget(),
                      const SizedBox(height: 20),
                      Text(
                        localizer.yourSocialDataOverview,
                        style: themeProvider.themeData().textTheme.headline4,
                      ), //dashboard widgets

                      const SizedBox(height: 20),
                    ],
                  ),
                ),
              )
            ],
          );
  }
}
