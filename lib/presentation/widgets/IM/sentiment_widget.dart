import 'package:flutter/material.dart';
import 'package:waultar/core/abstracts/abstract_services/i_ml_service.dart';
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

  @override
  Widget build(BuildContext context) {
    final mlService = locator.get<IMLService>(instanceName: 'mlService');
    List<ProfileDocument> profiles = [];...
    int connotated = 0;

    return DefaultWidget(
        title: "Sentiment Analysis",
        child: Column(
          children: [
            DefaultButton(
                onPressed: () => {
                      setState(() => {
                            connotated = mlService
                                .connotateTextsFromCategory(chosenCategories)
                          })
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
                  Text(profiles[index].service.toString()),
                  _categoryList(profiles[index]),
                ],
              ),
            ));
  }

  Widget _categoryList(ProfileDocument profile) {
    return Container(
      child: Column(
          children: List.generate(
              profile.categories.length,
              (index) => Row(
                    children: [
                      Checkbox(
                          value: chosenCategories
                              .contains(profile.categories[index]),
                          onChanged: (value) => {
                                setState(
                                  () {
                                    chosenCategories
                                            .contains(profile.categories[index])
                                        ? chosenCategories
                                            .remove(profile.categories[index])
                                        : chosenCategories
                                            .add(profile.categories[index]);
                                  },
                                )
                              }),
                      Text(profile.categories[index].category.name)
                    ],
                  ))),
    );
  }
}
