import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:provider/provider.dart';
import 'package:waultar/configs/globals/category_enums.dart';

import 'package:waultar/core/abstracts/abstract_services/i_sentiment_service.dart';
import 'package:waultar/data/entities/misc/profile_document.dart';
import 'package:waultar/data/entities/nodes/category_node.dart';
import 'package:waultar/presentation/providers/theme_provider.dart';
import 'package:waultar/presentation/widgets/general/default_widgets/default_widget.dart';
import 'package:waultar/presentation/widgets/general/util_widgets/default_button.dart';
import 'package:waultar/startup.dart';

class SentimentWidget extends StatefulWidget {
  const SentimentWidget({Key? key}) : super(key: key);

  @override
  State<SentimentWidget> createState() => _SentimentWidgetState();
}

class _SentimentWidgetState extends State<SentimentWidget> {
  final sentimentService =
      locator.get<ISentimentService>(instanceName: 'sentimentService');
  late ThemeProvider themeProvider;
  late List<ProfileDocument> profiles;

  List<DataCategory> chosenCategories = [];
  int timeEstimateSeconds = 0;
  bool translate = false;
  bool analyzing = false;
  String message = "Analyzing ...";

  @override
  Widget build(BuildContext context) {
    profiles = sentimentService.getAllProfiles();
    themeProvider = Provider.of<ThemeProvider>(context);

    return DefaultWidget(
        constraints: const BoxConstraints(maxWidth: 300),
        title: "Sentiment Analysis",
        child: analyzing
            ? Column(
                children: [Text(message), const CircularProgressIndicator()],
              )
            : Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    "Analyze the invoked sentiment in your data.",
                  ),
                  //const SizedBox(height: 10),
                  const Text(
                    "Choose what data to run analysis on :",
                  ),
                  const SizedBox(height: 10),
                  SingleChildScrollView(
                      child: Column(children: _profileList())),
                  const SizedBox(height: 10),
                  Divider(
                      height: 2,
                      thickness: 2,
                      color: themeProvider.themeMode().tonedColor),

                  const SizedBox(height: 10),
                  _analyzeBar(),
                ],
              ));
  }

  Widget _analyzeBar() {
    var timeEstimate = _timeEstimateOnCat();
    return Column(
      children: [
        Container(
            child: Row(children: [
          Checkbox(
              activeColor: themeProvider.themeMode().themeColor,
              value: translate,
              onChanged: (value) {
                translate = value ?? false;
                setState(() {});
              }),
          const Text("Translate text"),
          const SizedBox(width: 5),
          Tooltip(
              verticalOffset: 10,
              preferBelow: false,
              padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
              textStyle: themeProvider.themeData().textTheme.bodyText1,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: themeProvider.themeData().scaffoldBackgroundColor),
              message:
                  "Only english text can be analysed.\nTranslating will take extra time",
              child: Container(
                child: const Icon(
                  Iconsax.info_circle,
                  size: 14,
                ),
              )),
        ])),
        Divider(
            height: 22,
            thickness: 2,
            color: themeProvider.themeMode().tonedColor),
        Container(
            child: Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                const Text("Time estimate",
                    style: TextStyle(fontSize: 9, fontWeight: FontWeight.w400)),
                Text(timeEstimate, style: const TextStyle(fontSize: 12))
              ],
            ),
            const SizedBox(width: 10),
            DefaultButton(
                text: "          Analyze          ",
                onPressed: profiles.isEmpty
                    ? null
                    : () async {
                        analyzing = true;
                        await sentimentService.connotateOwnTextsFromCategory(
                            chosenCategories,
                            _sentimentAnalyzingProgress,
                            translate);
                        setState(() {});
                      })
          ],
        )),
      ],
    );
  }

  _sentimentAnalyzingProgress(String message, bool isDone) {
    analyzing = !isDone;
    if (isDone) {
      setState(() {});
    }
  }

  String formatTime(int seconds) {
    return '${(Duration(seconds: seconds))}'.substring(2, 7);
  }

  String _timeEstimateOnCat() {
    int timeEstimate = 0;
    for (var element in chosenCategories) {
      timeEstimate += (element.count * 0.0005).ceil();
    }
    return formatTime(timeEstimate);
  }

  List<Widget> _profileList() {
    return profiles.isEmpty
        ? [
            Text("No data to analyze",
                style: themeProvider.themeData().textTheme.headline4)
          ]
        : List.generate(
            profiles.length,
            (index) => Container(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        profiles[index].service.target!.serviceName,
                        style: const TextStyle(fontWeight: FontWeight.w500),
                      ),
                      const SizedBox(height: 5),
                      _categoryList(profiles[index]),
                    ],
                  ),
                ));
  }

  Widget _categoryList(ProfileDocument profile) {
    return Container(
      constraints: const BoxConstraints(maxHeight: 150),
      child: SingleChildScrollView(
        child: Column(
            children: List.generate(
                profile.categories.length,
                (index) => profile.categories[index].category ==
                            CategoryEnum.messaging ||
                        profile.categories[index].category ==
                            CategoryEnum.posts ||
                        profile.categories[index].category ==
                            CategoryEnum.comments
                    ? Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              Checkbox(
                                  activeColor:
                                      themeProvider.themeMode().themeColor,
                                  value: chosenCategories
                                      .where((element) =>
                                          element.id ==
                                          profile.categories[index].id)
                                      .toList()
                                      .isNotEmpty,
                                  onChanged: (value) {
                                    !value!
                                        ? chosenCategories.remove(
                                            chosenCategories
                                                .firstWhere((element) =>
                                                    element.id ==
                                                    profile
                                                        .categories[index].id))
                                        : chosenCategories
                                            .add(profile.categories[index]);

                                    setState(
                                      () {},
                                    );
                                  }),
                              Text(profile.categories[index].category.name,
                                  style: const TextStyle(
                                    fontSize: 12,
                                  )),
                            ],
                          ),
                          Text(profile.categories[index].count.toString())
                        ],
                      )
                    : Container())),
      ),
    );
  }
}
