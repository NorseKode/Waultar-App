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
        title: "Sentiment Analysis",
        description:
            "Analyze the invoked sentiment in your data.\nChoose what data to run analysis on :",
        child: analyzing
            ? Column(
                children: [Text(message), const CircularProgressIndicator()],
              )
            : Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 10),
                  SingleChildScrollView(
                      child: Column(children: _profileList())),
                  const SizedBox(height: 0),
                  _analyzeBar(),
                ],
              ));
  }

  Widget _analyzeBar() {
    var timeEstimate = _timeEstimateOnCat();
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              "Translate text",
              style: const TextStyle(
                  color: Color.fromARGB(255, 149, 150, 159),
                  fontFamily: "Poppins",
                  fontSize: 11,
                  fontWeight: FontWeight.w500),
            ),
            SizedBox(
                height: 20,
                width: 20,
                child: Transform.scale(
                    scale: 0.8,
                    child: Checkbox(
                        activeColor: themeProvider.themeMode().themeColor,
                        value: translate,
                        onChanged: (value) {
                          translate = value ?? false;
                          setState(() {});
                        })))
          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              "Estimated Time To Tag: ",
              style: const TextStyle(
                  color: Color.fromARGB(255, 149, 150, 159),
                  fontFamily: "Poppins",
                  fontSize: 11,
                  fontWeight: FontWeight.w500),
            ),
            Text(
              timeEstimate,
              style: TextStyle(fontSize: 11),
            ),
          ],
        ),
        const SizedBox(height: 20),
        Row(
          children: [
            DefaultButton(
                text: "Analyze",
                onPressed: profiles.isEmpty
                    ? null
                    : () async {
                        analyzing = true;
                        await sentimentService.connotateOwnTextsFromCategory(
                            chosenCategories,
                            _sentimentAnalyzingProgress,
                            translate);
                        setState(() {});
                      }),
          ],
        )
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
    var timeEstimate = 0;
    for (var element in chosenCategories) {
      timeEstimate += (element.count * 0.001).ceil();
      ;
    }

    return "${formatTime(timeEstimate)} sec";
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
                        "${profiles[index].service.target!.serviceName} - ${profiles[index].name}",
                        style: TextStyle(
                            fontWeight: FontWeight.w400, fontSize: 11),
                      ),
                      const SizedBox(height: 5),
                      _categoryList(profiles[index]),
                      const SizedBox(height: 20),
                    ],
                  ),
                ));
  }

  Widget _categoryList(ProfileDocument profile) {
    return Container(
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
                              Transform.scale(
                                  scale: 0.8,
                                  child: Checkbox(
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
                                                chosenCategories.firstWhere(
                                                    (element) =>
                                                        element.id ==
                                                        profile
                                                            .categories[index]
                                                            .id))
                                            : chosenCategories
                                                .add(profile.categories[index]);

                                        setState(
                                          () {},
                                        );
                                      })),
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
