import 'package:flutter/material.dart';
import 'package:waultar/core/abstracts/abstract_services/i_ml_service.dart';
import 'package:waultar/core/abstracts/abstract_services/i_sentiment_service.dart';
import 'package:waultar/core/inodes/profile_document.dart';
import 'package:waultar/core/inodes/profile_repo.dart';
import 'package:waultar/core/inodes/tree_nodes.dart';
import 'package:waultar/presentation/widgets/general/default_widgets/default_widget.dart';
import 'package:waultar/presentation/widgets/general/util_widgets/default_button.dart';
import 'package:waultar/startup.dart';

class SentimentWidget extends StatefulWidget {
  const SentimentWidget({Key? key}) : super(key: key);

  @override
  State<SentimentWidget> createState() => _SentimentWidgetState();
}

class _SentimentWidgetState extends State<SentimentWidget> {
  List<DataCategory> chosenCategories = [];
  int connotated = 0;

  @override
  Widget build(BuildContext context) {
    final sentimentService =
        locator.get<ISentimentService>(instanceName: 'sentimentService');
    List<ProfileDocument> profiles = sentimentService.getAllProfiles();

    print("${chosenCategories.toString()} : $connotated");
    // print(profiles.first.categories.first.category.name);
    return DefaultWidget(
        title: "Sentiment Analysis",
        child: Column(
          children: [
            DefaultButton(onPressed: () {
              print("pressed");
              connotated =
                  sentimentService.connotateTextsFromCategory(chosenCategories);
              print("rebuild");
              setState(() => {});
            }),
            Text("textConnotated: $connotated"),
            Column(children: _profileList(profiles)),
          ],
        ));
  }

  List<Widget> _profileList(List<ProfileDocument> profiles) {
    return List.generate(
        profiles.length,
        (index) => Container(
              child: Column(
                children: [
                  Text(profiles[index].service.target!.serviceName),
                  _categoryList(profiles[index]),
                ],
              ),
            ));
  }

  Widget _categoryList(ProfileDocument profile) {
    return Column(
        children: List.generate(
            profile.categories.length,
            (index) => Row(
                  children: [
                    Checkbox(
                        value: chosenCategories
                            .where((element) =>
                                element.id == profile.categories[index].id)
                            .toList()
                            .isNotEmpty,
                        onChanged: (value) {
                          !value!
                              ? chosenCategories.remove(
                                  chosenCategories.firstWhere((element) =>
                                      element.id ==
                                      profile.categories[index].id))
                              : chosenCategories.add(profile.categories[index]);
                          setState(
                            () {},
                          );
                        }),
                    Text(profile.categories[index].category.name)
                  ],
                )));
  }
}
