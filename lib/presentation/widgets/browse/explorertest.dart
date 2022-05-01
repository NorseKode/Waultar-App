// ignore_for_file: avoid_print

import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:provider/provider.dart';
import 'package:waultar/configs/globals/category_enums.dart';
import 'package:waultar/core/abstracts/abstract_services/i_explorer_service.dart';
import 'package:waultar/data/entities/misc/profile_document.dart';
import 'package:waultar/data/entities/nodes/category_node.dart';
import 'package:waultar/data/entities/nodes/datapoint_node.dart';
import 'package:waultar/data/entities/nodes/name_node.dart';
import 'package:waultar/presentation/providers/theme_provider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import 'package:waultar/startup.dart';

class Explorer extends StatefulWidget {
  const Explorer({Key? key}) : super(key: key);

  @override
  _ExplorerState createState() => _ExplorerState();
}

class _ExplorerState extends State<Explorer> {
  late AppLocalizations localizer;
  late ThemeProvider themeProvider;
  late List<ProfileDocument> profiles;
  late List<DataCategory> categories;
  late List<DataPointName> datanames;
  late List<DataPoint> datapoints;

  late int chosenProfile;
  late int chosenCategory;
  late int chosenDataname;
  late int chosenDataPoint;

  final IExplorerService _explorerService = locator.get<IExplorerService>(
    instanceName: 'explorerService',
  );

  @override
  void initState() {
    super.initState();
    profiles = _explorerService.getAllProfiles();

    if (profiles.isNotEmpty) {
      var firstProfile = profiles.first;
      chosenProfile = firstProfile.id;

      if (firstProfile.categories.isNotEmpty) {
        categories = firstProfile.categories;
        var firstCategory = categories.first;
        chosenCategory = firstCategory.id;

        if (firstCategory.dataPointNames.isNotEmpty) {
          datanames = firstCategory.dataPointNames;
          var firstDataname = datanames.first;
          chosenDataname = firstDataname.id;

          if (firstDataname.dataPoints.isNotEmpty) {
            datapoints = firstDataname.dataPoints;
            var firstDatapoint = datapoints.first;
            chosenDataPoint = firstDatapoint.id;
            print("Explorer setup: Completed");
            return;
          }
        }
      }
    }
    print("Explorer setup: Error");
  }

  @override
  Widget build(BuildContext context) {
    localizer = AppLocalizations.of(context)!;
    themeProvider = Provider.of<ThemeProvider>(context);

    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      Row(
        children: [
          Text(
            "Explorer",
            style: themeProvider.themeData().textTheme.headline3,
          ),
        ],
      ),
      const SizedBox(height: 20),
      fileManager()
    ]);
  }

  Widget fileManager() {
    return Expanded(
      child: Column(
        children: [
          Expanded(
            child: Row(
              children: [
                profileList(),
                SizedBox(width: 20),
                Expanded(child: categoryList()),
                SizedBox(width: 20),
                Expanded(child: datanameList()),
                SizedBox(width: 20),
                dataView()
              ],
            ),
          ),
          SizedBox(height: 20),
          Container(
            height: 150,
            child: Row(children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("Data Point"),
                  Text(chosenDataPoint.toString())
                ],
              ),
            ]),
          )
        ],
      ),
    );
  }

  Widget profileList() {
    return Container(
      width: 150,
      // color: Colors.red,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text("Services"),
          Column(
            children: List.generate(
                profiles.length, (index) => profileTile(profiles[index])),
          )
        ],
      ),
    );
  }

  Widget profileTile(ProfileDocument profile) {
    return GestureDetector(
      onTap: () {},
      child: Container(
        height: 40,
        decoration: BoxDecoration(
            color: chosenProfile == profile.id
                ? themeProvider.themeData().primaryColor
                : Colors.transparent,
            borderRadius: BorderRadius.circular(5)),
        child: Row(
          children: [
            Container(
              height: 30,
              width: 30,
              decoration: BoxDecoration(
                  color: Colors.pink, borderRadius: BorderRadius.circular(5)),
              child: Icon(
                Iconsax.people,
                size: 20,
              ),
            ),
            SizedBox(width: 12),
            Text(
              profile.name,
              style: TextStyle(fontWeight: FontWeight.w500),
            )
          ],
        ),
      ),
    );
  }

  Widget categoryList() {
    return Container(
      width: 250,
      // color: Colors.blue,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text("Category"),
          Expanded(
              child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: List.generate(categories.length,
                  (index) => categoryTile(categories[index])),
            ),
          ))
        ],
      ),
    );
  }

  Widget categoryTile(DataCategory category) {
    return GestureDetector(
      onTap: () {},
      child: Container(
        height: 40,
        decoration: BoxDecoration(
            color: chosenCategory == category.id
                ? themeProvider.themeData().primaryColor
                : Colors.transparent,
            borderRadius: BorderRadius.circular(5)),
        child: Row(
          children: [
            Container(
              height: 30,
              width: 30,
              decoration: BoxDecoration(
                  color: category.category.color,
                  borderRadius: BorderRadius.circular(5)),
              child: Icon(
                category.category.icon,
                size: 20,
              ),
            ),
            SizedBox(width: 12),
            Text(
              category.category.name,
              style: TextStyle(fontWeight: FontWeight.w500),
            )
          ],
        ),
      ),
    );
  }

  Widget datanameList() {
    return Container(
      width: 250,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text("Subcategory"),
          Expanded(
              child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: List.generate(
                  datanames.length, (index) => datanameTile(datanames[index])),
            ),
          ))
        ],
      ),
    );
  }

  Widget datanameTile(DataPointName dataname) {
    return GestureDetector(
      onTap: () {},
      child: Container(
        height: 40,
        decoration: BoxDecoration(
            color: chosenDataname == dataname.id
                ? themeProvider.themeData().primaryColor
                : Colors.transparent,
            borderRadius: BorderRadius.circular(5)),
        child: Row(
          children: [
            Container(
              height: 30,
              width: 30,
              decoration: BoxDecoration(
                  color: CategoryEnum.messaging.color,
                  borderRadius: BorderRadius.circular(5)),
              child: Icon(
                CategoryEnum.messaging.icon,
                size: 20,
              ),
            ),
            SizedBox(width: 12),
            Text(
              dataname.name,
              style: TextStyle(fontWeight: FontWeight.w500),
            )
          ],
        ),
      ),
    );
  }

  Widget dataView() {
    return Container(
      width: 250,
      // color: Colors.orange,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text("Data points"),
          Expanded(
              child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: List.generate(datapoints.length,
                  (index) => datapointTile(datapoints[index])),
            ),
          ))
        ],
      ),
    );
  }

  Widget datapointTile(DataPoint datapoint) {
    return GestureDetector(
      onTap: () {},
      child: Container(
        height: 40,
        decoration: BoxDecoration(
            color: chosenDataPoint == datapoint.id
                ? themeProvider.themeData().primaryColor
                : Colors.transparent,
            borderRadius: BorderRadius.circular(5)),
        child: Padding(
          padding: const EdgeInsets.only(
            left: 15.0,
            right: 20,
          ),
          child: Row(
            children: [
              Text(
                datapoint.stringName,
                style: TextStyle(fontWeight: FontWeight.w500),
              )
            ],
          ),
        ),
      ),
    );
  }
}
