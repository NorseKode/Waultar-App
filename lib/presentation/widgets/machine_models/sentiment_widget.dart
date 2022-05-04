import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:iconsax/iconsax.dart';
import 'package:provider/provider.dart';
import 'package:waultar/configs/globals/category_enums.dart';
import 'package:waultar/configs/globals/service_enums.dart';

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
  final sentimentService = locator.get<ISentimentService>(instanceName: 'sentimentService');
  late ThemeProvider themeProvider;
  late List<ProfileDocument> profiles;

  List<DataCategory> chosenCategories = [];
  int timeEstimateSeconds = 0;
  bool translate = false;
  bool analyzing = false;
  String uiMessage = "Analyzing ...";
  List<CategoryEnum> validCategories = [
    CategoryEnum.comments,
    CategoryEnum.messaging,
    CategoryEnum.posts
  ];
  List<int> categories = [];
  late Map<int, int> countedCategories;
  late Map<int, bool> openProfiles;

  @override
  void initState() {
    profiles = sentimentService.getAllProfiles();
    openProfiles = {for (var item in profiles) item.id: false};
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    themeProvider = Provider.of<ThemeProvider>(context);

    for (var profile in profiles) {
      var profileCats =
          profile.categories.where((element) => validCategories.contains(element.category));
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
                children: [Text(uiMessage), const Center(child: CircularProgressIndicator())],
              )
            : Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 10),
                  SingleChildScrollView(child: Column(children: _profileList())),
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
            const Text(
              "Translate text",
              style: TextStyle(
                  color: Color.fromARGB(255, 149, 150, 159),
                  fontFamily: "Poppins",
                  fontSize: 12,
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
            const Text(
              "Estimated Time To Tag: ",
              style: TextStyle(
                  color: Color.fromARGB(255, 149, 150, 159),
                  fontSize: 12,
                  fontWeight: FontWeight.w500),
            ),
            Text(
              timeEstimate,
              style: const TextStyle(fontSize: 12),
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
                              chosenCategories, _sentimentAnalyzingProgress, translate);
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
    setState(() {
      analyzing = !isDone;

      if (isDone) {
        _calculateCount();
        uiMessage = "Analyzing ...";
      } else {
        uiMessage = message;
      }
    });
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
        ? [Text("No data to analyze", style: themeProvider.themeData().textTheme.headline4)]
        : List.generate(
            profiles.length,
            (index) => Container(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _profile(profiles[index]),
                      openProfiles[profiles[index].id]!
                          ? _categoryList(profiles[index])
                          : Container(),
                      const SizedBox(height: 20),
                    ],
                  ),
                ));
  }

  Widget _profile(ProfileDocument profile) {
    ServiceEnum serviceEnum = getFromID(profile.service.target!.id);
    return GestureDetector(
      onTap: () {
        openProfiles[profile.id] = !openProfiles[profile.id]!;

        setState(() {});
      },
      child: Container(
        color:
            openProfiles[profile.id]! ? Colors.transparent : Colors.transparent,
        child: Row(mainAxisSize: MainAxisSize.min, children: [
          Icon(
            openProfiles[profile.id]!
                ? Iconsax.arrow_down_1
                : Iconsax.arrow_right_3,
            size: 20,
          ),
          const SizedBox(width: 15),
          Container(
            width: 25,
            height: 25,
            decoration: BoxDecoration(
                color:
                    serviceEnum.color, //widget.service.service.target!.color,
                borderRadius: BorderRadius.circular(5)),
            child: Padding(
              padding: const EdgeInsets.all(3.0),
              child: SvgPicture.asset(
                serviceEnum.image,
                color: Colors.white,
                matchTextDirection: true,
              ),
            ),
          ),
          const SizedBox(width: 15),
          Expanded(
            child: Text(
              profile.name,
              style: const TextStyle(fontSize: 13, fontWeight: FontWeight.w400),
            ),
          ),
        ]),
      ),
    );
  }

  Widget _categoryList(ProfileDocument profile) {
    return Column(
      children: [
        const SizedBox(height: 10),
        SingleChildScrollView(
          child: Column(
              children: List.generate(
                  profile.categories.length,
                  (index) => validCategories
                          .contains(profile.categories[index].category)
                      ? Padding(
                          padding: const EdgeInsets.only(top: 5),
                          child: GestureDetector(
                            onTap: countedCategories[
                                        profile.categories[index].id] ==
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
                                                    profile
                                                        .categories[index].id))
                                        : chosenCategories
                                            .add(profile.categories[index]);

                                    setState(
                                      () {},
                                    );
                                  },
                            child: Container(
                              padding: const EdgeInsets.symmetric(
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
                                  borderRadius: BorderRadius.circular(7)),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Row(
                                    children: [
                                      SizedBox(
                                        height: 20,
                                        width: 20,
                                        child: Icon(
                                          profile
                                              .categories[index].category.icon,
                                          size: 20,
                                          color: countedCategories[profile
                                                      .categories[index].id] ==
                                                  0
                                              ? const Color.fromARGB(
                                                  255, 149, 150, 159)
                                              : profile.categories[index]
                                                  .category.color,
                                        ),
                                      ),
                                      const SizedBox(width: 12),
                                      Text(
                                        profile.categories[index].category.name,
                                        style: const TextStyle(
                                            fontSize: 12,
                                            fontWeight: FontWeight.w400,
                                            overflow: TextOverflow.ellipsis),
                                      ),
                                    ],
                                  ),
                                  Text(
                                    countedCategories[
                                            profile.categories[index].id]
                                        .toString(),
                                    style: TextStyle(
                                      fontWeight: FontWeight.w400,
                                      fontSize: 12,
                                      color: countedCategories[profile
                                                  .categories[index].id] ==
                                              0
                                          ? const Color.fromARGB(255, 149, 150, 159)
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
      ],
    );
  }

  void _calculateCount() {
    sentimentService.calculateCategoryCount(categories);
  }
}
