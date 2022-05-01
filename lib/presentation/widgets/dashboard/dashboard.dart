import 'dart:io';
import 'dart:math';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:tuple/tuple.dart';
import 'package:waultar/configs/globals/service_enums.dart';
import 'package:waultar/core/abstracts/abstract_repositories/i_service_repository.dart';
import 'package:waultar/core/abstracts/abstract_services/i_dashboard_service.dart';
import 'package:waultar/core/abstracts/abstract_services/i_parser_service.dart';
import 'package:waultar/core/abstracts/abstract_services/i_sentiment_service.dart';
import 'package:waultar/data/entities/misc/profile_document.dart';
import 'package:waultar/presentation/providers/theme_provider.dart';
import 'package:waultar/presentation/widgets/general/util_widgets/default_button.dart';
import 'package:waultar/presentation/widgets/machine_models/image_classify_single_widget%20.dart';
import 'package:waultar/presentation/widgets/general/default_widgets/default_button.dart';

import 'package:waultar/presentation/widgets/machine_models/sentiment_widget.dart';
import 'package:waultar/presentation/widgets/general/default_widgets/default_widget.dart';
import 'package:waultar/presentation/widgets/general/default_widgets/default_widget_box.dart';
import 'package:waultar/presentation/widgets/dashboard/service_widget.dart';

import 'package:waultar/presentation/widgets/machine_models/image_classify_widget.dart';
import 'package:waultar/presentation/widgets/snackbar_custom.dart';
import 'package:waultar/presentation/widgets/upload/uploader.dart';

import 'package:waultar/startup.dart';
import 'package:path/path.dart' as dart_path;

class Dashboard extends StatefulWidget {
  Dashboard({Key? key}) : super(key: key);

  @override
  _DashboardState createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  final _dashboardService = locator.get<IDashboardService>(
    instanceName: 'dashboardService',
  );
  final _parserService = locator.get<IParserService>(
    instanceName: 'parserService',
  );
  final sentimentService = locator.get<ISentimentService>(instanceName: 'sentimentService');
  late AppLocalizations localizer;
  late ThemeProvider themeProvider;
  late List<ProfileDocument> profiles;
  late List<Tuple2<String, double>> weekdays;
  Tuple2<String, double> mostActive = const Tuple2('Unknown', 0);
  var testText = TextEditingController();
  var _isLoading = false;
  var _progressMessage = "Initializing";
  double testScore = -1;
  Map<int, int> serviceAlpha = {};

  @override
  Widget build(BuildContext context) {
    localizer = AppLocalizations.of(context)!;
    themeProvider = Provider.of<ThemeProvider>(context);
    profiles = _dashboardService.getAllProfiles();
    weekdays = _dashboardService.getActiveWeekday();
    if (profiles.isNotEmpty) _alphaGenerator();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: _isLoading
          ? [
              Text(_progressMessage),
              const CircularProgressIndicator(),
            ]
          : [
              Text(
                localizer.dashboard,
                style: themeProvider.themeData().textTheme.headline3,
              ),
              TextField(controller: threadCountController),
              _uploadButton(),
              const SizedBox(height: 20),
              Expanded(
                child: profiles.isNotEmpty
                    ? SingleChildScrollView(child: _dashboardWidgets())
                    : Text(
                        "Upload data to use dashboard",
                        style: themeProvider.themeData().textTheme.headline4,
                      ),
              )
            ],
    );
  }

  _onUploadProgress(String message, bool isDone) {
    setState(() {
      _progressMessage = message;
      _isLoading = !isDone;
      if (!_isLoading) {
        _progressMessage = "Initializing";
      }
    });
  }

  var threadCountController = TextEditingController();
  _uploadButton() {
    return DefaultButton(
      constraints: const BoxConstraints(maxWidth: 200),
      onPressed: () async {
        var files = await Uploader.uploadDialogue(context);
        if (files != null) {
          SnackBarCustom.useSnackbarOfContext(context, localizer.startedLoadingOfData);

          setState(() {
            _isLoading = true;
          });

          var zipFile =
              files.item1.singleWhere((element) => dart_path.extension(element) == ".zip");

          // await _parserService.parseIsolates(
          //   zipFile,
          //   _onUploadProgress,
          //   files.item3,
          //   ProfileDocument(name: files.item2),
          // );
          // await _parserService.parseIsolatesParallel(
          //   zipFile,
          //   _onUploadProgress,
          //   files.item3,
          //   ProfileDocument(name: files.item2),
          // );

          await _parserService.parseIsolatesPara(
            zipFile,
            _onUploadProgress,
            files.item3,
            ProfileDocument(name: files.item2),
            threadCount: int.parse(threadCountController.text),
          );
        }
      },
      text: localizer.upload,
    );
  }

  void _alphaGenerator() {
    var before = profiles.first.service;
    var count = 0;

    for (int i = 0; i < profiles.length; i++) {
      if (profiles[i].service.target!.id != before.target!.id) {
        count = 0;
      }

      serviceAlpha.addAll({i: count});
      count++;
      before = profiles[i].service;
    }
    if (profiles.isNotEmpty && weekdays.isNotEmpty) {
      mostActive = weekdays.reduce(
          (value, element) => value.item2 <= element.item2 ? element : value);
    }
  }

  Widget _dashboardWidgets() {
    var widgets = Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Overview",
          style: themeProvider.themeData().textTheme.headline4,
        ),
        const SizedBox(height: 15),
        Wrap(
          spacing: 20,
          runSpacing: 20,
          children: [
            Container(
                height: 300,
                width: 300,
                constraints:
                    const BoxConstraints(minHeight: 300, minWidth: 300),
                child: _circleGraph()),
            Container(
                width: 300,
                constraints:
                    const BoxConstraints(minHeight: 300, minWidth: 300),
                child: graphOverview()),
          ],
        ),
        const SizedBox(height: 20),
        Row(
          // spacing: double.infinity,
          // runSpacing: 20,
          children: [
            _mostActiveYear(),
            SizedBox(width: 20),
            Container(
              height: 95,
              child: DefaultWidgetBox(
                  child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("Most Active time of day",
                      style: themeProvider.themeData().textTheme.headline4!),
                  Text("3 - 4 PM",
                      style: themeProvider.themeData().textTheme.headline3!)
                ],
              )),
            ),
            SizedBox(width: 20),
            Expanded(
              child: Container(
                height: 95,
                child: DefaultWidgetBox(
                    child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("Some other stat here",
                        style: themeProvider.themeData().textTheme.headline4!),
                    Text("",
                        style: themeProvider.themeData().textTheme.headline3!)
                  ],
                )),
              ),
            ),
          ],
        ),
        const SizedBox(height: 20),
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
                child: Container(
              height: 200,
              child: DefaultWidget(
                title: "Your first post",
                child: Container(),
              ),
            )),
            const SizedBox(width: 20),
            Expanded(
                child: Container(
              height: 200,
              child: DefaultWidget(
                title: "Graph",
                child: Container(),
              ),
            )),
          ],
        )
      ],
    );

    var analysis = Container(
      width: 350,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Analysis",
            style: themeProvider.themeData().textTheme.headline4,
          ),
          const SizedBox(height: 15),
          ImageClassifyWidget(),
          const SizedBox(height: 20),
          _sentimentTestWidget(),
          const SizedBox(height: 20),
          SentimentWidget()
        ],
      ),
    );

    return Column(
      children: [
        Row(children: [Expanded(child: _services())]),
        const SizedBox(height: 20),
        MediaQuery.of(context).size.width < 1275
            ? Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [widgets, SizedBox(height: 20), analysis])
            : Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
                Expanded(child: widgets),
                SizedBox(width: 20),
                analysis
              ])
      ],
    );
  }

  Widget _services() {
    List<Widget> serviceWidgets =
        List.generate(profiles.length, (e) => ServiceWidget(service: profiles[e]));

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Services",
          style: themeProvider.themeData().textTheme.headline4,
        ),
        const SizedBox(height: 15),
        Wrap(
          runSpacing: 20,
          spacing: 20,
          children: List.generate(
            serviceWidgets.length,
            (index) => serviceWidgets[index],
          ),
        ),
      ],
    );
  }

  Widget graphOverview() {
    var dpSum = profiles.fold<int>(
        0,
        (previousValue, element) =>
            previousValue +
            element.categories.fold(
                0, (previousValue, element) => previousValue + element.count));
    return DefaultWidget(
        title: "Service Distribution",
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 20),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(NumberFormat.compact().format(dpSum),
                    style: themeProvider.themeData().textTheme.headline3!),
                Text("Total datapoints uploaded",
                    style: themeProvider.themeData().textTheme.headline4)
              ],
            ),
            SizedBox(height: 30),
            Container(
              child: Wrap(
                spacing: double.infinity,
                runSpacing: 20,
                children: List.generate(
                    profiles.length,
                    (index) => Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Container(
                              height: 10,
                              width: 10,
                              decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: getFromID(
                                          profiles[index].service.target!.id)
                                      .color
                                      .withAlpha(
                                          255 - (serviceAlpha[index]! * 75))),
                            ),
                            SizedBox(
                              width: 20,
                            ),
                            Expanded(
                              child: Container(
                                child: Text(
                                  "${profiles[index].name}:",
                                  maxLines: 1,
                                  softWrap: false,
                                ),
                              ),
                            ),
                            SizedBox(
                              width: 20,
                            ),
                            Text(
                                "${NumberFormat.compact().format(profiles[index].categories.fold<int>(0, (previousValue, element) => previousValue + element.count))}",
                                style: const TextStyle(
                                    fontSize: 13, fontWeight: FontWeight.w500))
                          ],
                        )),
              ),
            ),
          ],
        ));
  }

  Widget _circleGraph() {
    var dpSum = profiles.fold<int>(
        0,
        (previousValue, element) =>
            previousValue +
            element.categories.fold(
                0, (previousValue, element) => previousValue + element.count));

    return DefaultWidgetBox(
      child: Stack(
        children: [
          Center(
              child: Container(
                  height: 100,
                  width: 100,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: const Color(0xFF323346),
                  ),
                  child: Center(
                      child: Text(
                    "DP",
                    style: TextStyle(
                        fontSize: 30,
                        color: themeProvider.themeData().primaryColor,
                        fontWeight: FontWeight.w700),
                  )))),
          Container(
            padding: EdgeInsets.all(10),
            child: PieChart(
              PieChartData(
                  sections: List.generate(
                profiles.length,
                (index) => PieChartSectionData(
                    value: profiles[index].categories.fold<int>(
                            0,
                            (previousValue, element) =>
                                previousValue + element.count) /
                        dpSum,
                    radius: 30,
                    title:
                        "${NumberFormat.compact().format(profiles[index].categories.fold<int>(0, (previousValue, element) => previousValue + element.count) / dpSum * 100)}%",
                    color: getFromID(profiles[index].service.target!.id)
                        .color
                        .withAlpha(255 - (serviceAlpha[index]! * 75))),
              )),
            ),
          ),
        ],
      ),
    );
  }

  Widget _diagram1() {
    return Expanded(
        child: DefaultWidget(
      title: "Weekly Activity",
      child: Expanded(
          child: Container(
              height: 200,
              child: Row(
                  children: List.generate(
                      weekdays.length,
                      (index) => Expanded(
                            child: Column(
                              children: [
                                Expanded(
                                  flex: (100 -
                                          (weekdays[index].item2 /
                                              (mostActive.item2 * 1.5) *
                                              100))
                                      .floor(),
                                  child: Container(
                                    color: Colors.transparent,
                                  ),
                                ),
                                Expanded(
                                  flex: (weekdays[index].item2 /
                                          (mostActive.item2 * 1.5) *
                                          100)
                                      .ceil(),
                                  child: Container(
                                    width: 20,
                                    color: themeProvider.themeMode().themeColor,
                                  ),
                                ),
                              ],
                            ),
                          ))))),
    ));
  }

  _mostActiveYear() {
    int year = _dashboardService.getMostActiveYear();
    return Container(
      height: 95,
      child: DefaultWidgetBox(
          child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text("Most Active Year",
              style: themeProvider.themeData().textTheme.headline4!),
          Text("${year != -1 ? year.toString() : "Unknown"}",
              style: themeProvider.themeData().textTheme.headline3!)
        ],
      )),
    );
  }

  Widget _sentimentTestWidget() {
    return DefaultWidget(
        title: "Sentiment Test",
        description: "Test the sentiment tool by input text",
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Text("Input text to test sentiment"),

            const SizedBox(height: 20),
            Container(
              height: 40,
              child: TextFormField(
                  style: TextStyle(fontSize: 12),
                  cursorWidth: 1,
                  keyboardType: TextInputType.number,
                  controller: testText,
                  decoration: InputDecoration(
                    contentPadding: EdgeInsets.only(left: 15),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(5.0),
                      borderSide: BorderSide.none,
                    ),
                    filled: true,
                    fillColor: (const Color(0xFF323346)),
                    hintText: "Enter a sentence ...",
                    hintStyle: TextStyle(letterSpacing: 0.3),
                  )),
            ),
            SizedBox(height: 20),
            Row(
              children: [
                Expanded(
                  child: DefaultButton(
                    text: "Analyze",
                    onPressed: () {
                      testScore = sentimentService.connotateText(testText.text);
                      setState(() {});
                    },
                  ),
                ),
              ],
            ),
            SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Sentiment Score: ",
                  style: const TextStyle(
                      color: Color.fromARGB(255, 149, 150, 159),
                      fontSize: 12,
                      fontWeight: FontWeight.w500),
                ),
                Text(
                  testScore.toStringAsFixed(3),
                  style: TextStyle(fontSize: 12),
                ),
              ],
            ),
          ],
        ));
  }
}
