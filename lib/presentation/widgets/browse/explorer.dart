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
import 'package:waultar/presentation/widgets/general/default_widgets/default_button.dart';

import 'package:waultar/startup.dart';

class Explorer extends StatefulWidget {
  const Explorer({Key? key}) : super(key: key);

  @override
  _ExplorerState createState() => _ExplorerState();
}

class _ExplorerState extends State<Explorer> {
  late AppLocalizations localizer;
  late ThemeProvider themeProvider;
  List<ProfileDocument> profiles = [];
  List<DataCategory> categories = [];
  List<DataPointName> datanames = [];
  List<DataPointName> datanameChildren = [];
  List<DataPoint> datapoints = [];

  int chosenProfile = -1;
  int chosenCategory = -1;
  int chosenDataname = -1;
  DataPoint? openDataPoint;
  DataPointName? openDataname;

  final IExplorerService _explorerService = locator.get<IExplorerService>(
    instanceName: 'explorerService',
  );

  @override
  void initState() {
    super.initState();
    profiles = _explorerService.getAllProfiles();
  }

  @override
  Widget build(BuildContext context) {
    localizer = AppLocalizations.of(context)!;
    themeProvider = Provider.of<ThemeProvider>(context);
    _updateChosen();

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
      setup()
    ]);
  }

  _updateChosen() {
    var profile = profiles.where((element) => element.id == chosenProfile);
    if (profile.isNotEmpty) {
      categories = profile.first.categories;
    }
    var category = categories.where((element) => element.id == chosenCategory);
    if (category.isNotEmpty) {
      datanames = category.first.dataPointNames;
    }
    var dataname = datanames.where((element) => element.id == chosenDataname);
    if (dataname.isNotEmpty) {
      openDataname ??= dataname.first;
      datanameChildren =
          _explorerService.getAllDatanameChildren(openDataname!.id);
      datapoints = _explorerService.getAllDataPoints(openDataname!.id);
    }
    // else {
    //   var nameID = dataname.first.id;
    //   datanameChildren = _explorerService.getAllDatanameChildren(nameID);
    //   datapoints = _explorerService.getAllDataPoints(nameID);
    // }
  }

  Widget setup() {
    return Expanded(
      child: Row(
        children: [
          Expanded(
            child: Column(
              children: [
                Expanded(child: fileManager()),
                SizedBox(height: 20),
                Expanded(child: dataPointList())
              ],
            ),
          ),
          SizedBox(width: 20),
          Container(width: 300, child: datapointOverview())
        ],
      ),
    );
  }

  Widget fileManager() {
    return Container(
        child: Row(
      children: [
        serviceList(),
        SizedBox(width: 10),
        categoryList(),
        SizedBox(width: 10),
        datanameList()
      ],
    ));
  }

  Widget serviceList() {
    return Expanded(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text("Services",
              style: themeProvider.themeData().textTheme.headline4),
          SizedBox(height: 10),
          profiles == null || profiles.isEmpty
              ? Expanded(child: Center(child: Text("No items")))
              : Expanded(
                  child: SingleChildScrollView(
                    child: Column(
                        children: List.generate(
                            profiles.length,
                            (index) => listEntry(
                                    Iconsax
                                        .activity, //profiles[index].service.target!.image,
                                    profiles[index].id == chosenProfile
                                        ? true
                                        : false,
                                    profiles[index].name, () {
                                  chosenProfile = profiles[index].id;

                                  setState(() {});
                                }))),
                  ),
                )
        ],
      ),
    );
  }

  Widget categoryList() {
    return Expanded(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text("Categories",
              style: themeProvider.themeData().textTheme.headline4),
          SizedBox(height: 10),
          categories == null || categories.isEmpty
              ? Expanded(child: Center(child: Text("No items")))
              : Expanded(
                  child: SingleChildScrollView(
                    child: Column(
                        children: List.generate(
                            categories.length,
                            (index) => listEntry(
                                  categories[index].category.icon,
                                  categories[index].id == chosenCategory
                                      ? true
                                      : false,
                                  categories[index].category.categoryName,
                                  () {
                                    chosenCategory = categories[index].id;

                                    setState(() {});
                                  },
                                  color: categories[index].category.color,
                                ))),
                  ),
                )
        ],
      ),
    );
  }

  Widget datanameList() {
    return Expanded(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text("Subcategories",
              style: themeProvider.themeData().textTheme.headline4),
          SizedBox(height: 10),
          datanames == null || datanames.isEmpty
              ? Expanded(child: Center(child: Text("No items")))
              : Expanded(
                  child: SingleChildScrollView(
                    child: Column(
                        children: List.generate(
                            datanames.length,
                            (index) => listEntry(
                                    categories
                                        .firstWhere((element) =>
                                            element.id == chosenCategory)
                                        .category
                                        .icon,
                                    datanames[index].id == chosenDataname
                                        ? true
                                        : false,
                                    datanames[index].name, () {
                                  chosenDataname = datanames[index].id;
                                  openDataname = datanames[index];
                                  setState(() {});
                                },
                                    color: categories
                                        .firstWhere((element) =>
                                            element.id == chosenCategory)
                                        .category
                                        .color))),
                  ),
                )
        ],
      ),
    );
  }

  Widget listEntry(IconData icon, bool state, String value, Function() onTap,
      {Color? color}) {
    // return Row(
    //   children: [Icon(icon), SizedBox(width: 10), Text(value)],
    // );
    return Padding(
      padding: EdgeInsets.only(bottom: 10),
      child: GestureDetector(
        onTap: onTap,
        child: Container(
          height: 30,
          decoration: BoxDecoration(
              color: state
                  ? themeProvider.themeData().primaryColor
                  : Colors.transparent,
              borderRadius: BorderRadius.circular(5)),
          child: Row(
            children: [
              Container(
                height: 30,
                width: 30,
                decoration: BoxDecoration(
                    color: color ?? themeProvider.themeData().primaryColor,
                    borderRadius: state
                        ? BorderRadius.only(
                            topLeft: Radius.circular(5),
                            bottomLeft: Radius.circular(5))
                        : BorderRadius.circular(5)),
                child: Icon(
                  icon,
                  size: 20,
                ),
              ),
              SizedBox(width: 12),
              Text(
                value,
                style: TextStyle(fontWeight: FontWeight.w500),
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget dataPointList() {
    Column? children;
    if (datanameChildren != null && datanameChildren.isNotEmpty) {
      children = Column(
          children: List.generate(
              datanameChildren.length,
              (index) => listEntry(
                      Iconsax.folder, false, datanameChildren[index].name, () {
                    openDataname = datanameChildren[index];
                    setState(() {});
                  }, color: themeProvider.themeData().primaryColor)));
    }
    Column? points;
    if (datapoints != null && datapoints.isNotEmpty) {
      points = Column(
          children: List.generate(
              datapoints.length,
              (index) => listEntry(
                      Iconsax.bubble,
                      openDataPoint != null &&
                              datapoints[index].id == openDataPoint!.id
                          ? true
                          : false,
                      datapoints[index].stringName, () {
                    openDataPoint = datapoints[index];
                    setState(() {});
                  }, color: themeProvider.themeData().primaryColor)));
    }

    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text("Content", style: themeProvider.themeData().textTheme.headline4),
          SizedBox(height: 10),
          openDataname != null && openDataname!.parent.hasValue
              ? DefaultButton(
                  color: themeProvider.themeData().scaffoldBackgroundColor,
                  text: ".. " + openDataname!.parent.target!.name,
                  onPressed: () {
                    openDataname = openDataname!.parent.target!;
                    setState(() {});
                  },
                )
              : Container(),
          children == null && points == null
              ? Expanded(child: Center(child: Text("No items")))
              : Expanded(
                  child: SingleChildScrollView(
                    child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          children ?? Container(),
                          points ?? Container()
                        ]),
                  ),
                )
        ],
      ),
    );
  }

  Widget datapointOverview() {
    if (openDataPoint == null)
      return Center(
        child: Text("No item"),
      );
    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      // Text("Datapoint"),
      Expanded(
        child: SingleChildScrollView(
          child: Column(
            children: [Text(openDataPoint!.toMap().toString())],
          ),
        ),
      )
    ]);
  }
}
