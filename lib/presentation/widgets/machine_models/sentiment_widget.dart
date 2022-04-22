import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:provider/provider.dart';
import 'package:waultar/configs/globals/category_enums.dart';

import 'package:waultar/core/abstracts/abstract_services/i_sentiment_service.dart';
import 'package:waultar/data/entities/misc/profile_document.dart';
import 'package:waultar/data/entities/nodes/category_node.dart';
import 'package:waultar/presentation/providers/theme_provider.dart';
import 'package:waultar/presentation/widgets/general/default_widgets/default_widget.dart';
import 'package:waultar/presentation/widgets/general/default_widgets/default_button.dart';
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
  List<CategoryEnum> validCategories = [
    CategoryEnum.comments,
    CategoryEnum.messaging,
    CategoryEnum.posts
  ];
  List<int> categories = [];
  late Map<int, int> countedCategories;

  @override
  Widget build(BuildContext context) {
    profiles = sentimentService.getAllProfiles();
    themeProvider = Provider.of<ThemeProvider>(context);

    for (var profile in profiles) {
      var profileCats = profile.categories
          .where((element) => validCategories.contains(element.category));
      for (var element in profileCats) {
        categories.add(element.id);
      }
    }

    for (var id in categories) {
      if (!sentimentService.categoryCount.containsKey(id)) {
        _calculateCount();
        break;
      }
    }

    countedCategories = sentimentService.categoryCount;

    return DefaultWidget(
        title: "Sentiment Analysis",
        description:
            "Analyze the invoked sentiment in your data.\nChoose what data to run analysis on :",
        child: analyzing
            ? Column(
                children: [
                  Text(message),
                  const Center(child: CircularProgressIndicator())
                ],
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
            Expanded(
              child: DefaultButton(
                  text: "Analyze",
                  onPressed: profiles.isEmpty
                      ? null
                      : () async {
                          analyzing = true;
                          await sentimentService.connotateOwnTextsFromCategory(
                              chosenCategories,
                              _sentimentAnalyzingProgress,
                              translate);
                          chosenCategories = [];
                          setState(() {});
                        }),
            ),
          ],
        )
      ],
    );
  }

  _sentimentAnalyzingProgress(String message, bool isDone) {
    analyzing = !isDone;
    if (isDone) {
      _calculateCount();
      setState(() {});
    }
  }

  String _timeEstimateOnCat() {
    var timeEstimate = 0;
    for (var element in chosenCategories) {
      timeEstimate += (element.count * 0.001).ceil();
    }

    return "${'${(Duration(seconds: timeEstimate))}'.substring(2, 7)} ${timeEstimate < 60 ? "sec" : "min"}";
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
                            fontWeight: FontWeight.w500,
                            fontSize: 11,
                            color: Color.fromARGB(255, 149, 150, 159)),
                      ),
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
                (index) => validCategories
                        .contains(profile.categories[index].category)
                    ? Padding(
                        padding: EdgeInsets.only(top: 5),
                        child: GestureDetector(
                          onTap:
                              countedCategories[profile.categories[index].id] ==
                                      0
                                  ? () {}
                                  : () {
                                      chosenCategories
                                              .where((element) =>
                                                  element.id ==
                                                  profile.categories[index].id)
                                              .toList()
                                              .isNotEmpty
                                          ? chosenCategories.remove(
                                              chosenCategories
                                                  .firstWhere((element) =>
                                                      element.id ==
                                                      profile.categories[index]
                                                          .id))
                                          : chosenCategories
                                              .add(profile.categories[index]);

                                      setState(
                                        () {},
                                      );
                                    },
                          child: Container(
                            padding: EdgeInsets.symmetric(
                                vertical: 8, horizontal: 10),
                            decoration: BoxDecoration(
                                color: chosenCategories
                                        .where((element) =>
                                            element.id ==
                                            profile.categories[index].id)
                                        .toList()
                                        .isNotEmpty
                                    ? const Color(0xFF323346)
                                    : Colors.transparent,
                                borderRadius: BorderRadius.circular(10)),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Row(
                                  children: [
                                    Icon(
                                        profile.categories[index].category.icon,
                                        color: countedCategories[profile
                                                    .categories[index].id] ==
                                                0
                                            ? Color.fromARGB(255, 149, 150, 159)
                                            : profile.categories[index].category
                                                .color,
                                        size: 16),
                                    SizedBox(width: 10),
                                    Text(
                                        profile.categories[index].category.name,
                                        style: TextStyle(
                                          color: countedCategories[profile
                                                      .categories[index].id] ==
                                                  0
                                              ? Color.fromARGB(
                                                  255, 149, 150, 159)
                                              : Colors.white,
                                          fontWeight: FontWeight.w400,
                                          fontSize: 12,
                                        )),
                                  ],
                                ),
                                Text(
                                  countedCategories[
                                          profile.categories[index].id]
                                      .toString(),
                                  style: TextStyle(
                                    color: countedCategories[
                                                profile.categories[index].id] ==
                                            0
                                        ? Color.fromARGB(255, 149, 150, 159)
                                        : Colors.white,
                                  ),
                                )
                              ],
                            ),
                          ),
                        ),
                      )
                    : Container())),
      ),
    );
  }

  void _calculateCount() {
    sentimentService.calculateCategoryCount(categories);
  }
}
