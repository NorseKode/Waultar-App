// ignore_for_file: avoid_print

import 'dart:collection';
import 'dart:developer';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:iconsax/iconsax.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:waultar/configs/globals/category_enums.dart';
import 'package:waultar/configs/globals/service_enums.dart';
import 'package:waultar/core/abstracts/abstract_services/i_explorer_service.dart';
import 'package:waultar/core/helpers/PathHelper.dart';
import 'package:waultar/data/entities/misc/profile_document.dart';
import 'package:waultar/data/entities/misc/service_document.dart';
import 'package:waultar/data/entities/nodes/category_node.dart';
import 'package:waultar/data/entities/nodes/datapoint_node.dart';
import 'package:waultar/data/entities/nodes/name_node.dart';
import 'package:waultar/presentation/providers/theme_provider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:waultar/presentation/widgets/browse/datapoint_widget.dart';
import 'package:waultar/presentation/widgets/general/default_widgets/default_button.dart';
import 'package:waultar/presentation/widgets/general/default_widgets/default_widget_box.dart';

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

  late ProfileDocument service;
  late FolderItem folder;
  DataPoint? datapoint;

  final IExplorerService _explorerService = locator.get<IExplorerService>(
    instanceName: 'explorerService',
  );

  @override
  void initState() {
    super.initState();
    profiles = _explorerService.getAllProfiles();
    if (profiles.isNotEmpty) {
      service = profiles.first;
      folder = FolderItem(service);
    }
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
      profiles.isEmpty
          ? Text(
              "Upload data to use explorer",
              style: themeProvider.themeData().textTheme.headline4,
            )
          : setup()
    ]);
  }

  Widget setup() {
    return Expanded(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                services(),
                SizedBox(height: 20),
                Expanded(child: filemanager())
              ],
            ),
          ),
          SizedBox(width: 20),
          Container(width: 300, child: datapointOverview())
        ],
      ),
    );
  }

  Widget services() {
    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      Text(
        "Services",
        style: themeProvider.themeData().textTheme.headline4,
      ),
      const SizedBox(height: 15),
      SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Wrap(
            spacing: 20,
            children: List.generate(profiles.length,
                (index) => serviceItem(FolderItem(profiles[index])))),
      )
    ]);
  }

  Widget serviceItem(FolderItem item) {
    bool state = service.id == item.item.id;
    ServiceDocument itemService =
        (item.item as ProfileDocument).service.target!;
    ServiceEnum serviceEnum = getFromID(itemService.id);

    return GestureDetector(
      onTap: () {
        service = item.item;
        folder = FolderItem.service(service);
        setState(() {});
      },
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
                  color: serviceEnum.color,
                  borderRadius: state
                      ? const BorderRadius.only(
                          topLeft: Radius.circular(5),
                          bottomLeft: Radius.circular(5))
                      : BorderRadius.circular(5)),
              child: Padding(
                padding: const EdgeInsets.all(5.0),
                child: socialSvg(serviceEnum),
              ),
            ),
            SizedBox(width: 12),
            Text(
              item.name,
              style: const TextStyle(
                  fontWeight: FontWeight.w500, overflow: TextOverflow.ellipsis),
            ),
            SizedBox(width: 12)
          ],
        ),
      ),
    );
  }

  Widget filemanager() {
    var children = folder.getChildren();
    var parent = folder.getParent();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "File Manager",
          style: themeProvider.themeData().textTheme.headline4,
        ),
        const SizedBox(height: 15),
        parent.item == null
            ? Container()
            : Padding(
                padding: const EdgeInsets.only(bottom: 10.0),
                child: GestureDetector(
                  onTap: () {
                    folder = parent;
                    setState(() {});
                  },
                  child: Container(
                    height: 30,
                    color: Colors.transparent,
                    child: Row(mainAxisSize: MainAxisSize.min, children: [
                      Icon(Iconsax.arrow_left_2, size: 15),
                      SizedBox(width: 12),
                      Text(folder.name)
                    ]),
                  ),
                ),
              ),
        children.isEmpty
            ? Center(
                child: Text("Empty folder"),
              )
            : Expanded(
                child: SingleChildScrollView(
                  child: Wrap(
                      spacing: double.infinity,
                      runSpacing: 10,
                      children: List.generate(
                          children.length,
                          (index) =>
                              managerItem(FolderItem(children[index].item)))),
                ),
              ),
      ],
    );
  }

  Widget managerItem(FolderItem item) {
    bool isDatapoint = item.item.runtimeType == DataPoint;
    bool state =
        isDatapoint && datapoint != null && datapoint!.id == item.item.id;

    return GestureDetector(
      onTap: isDatapoint
          ? state
              ? () {}
              : () {
                  datapoint = item.item;
                  setState(() {});
                }
          : () {
              folder = item;
              setState(() {});
            },
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
                  color: item.color,
                  borderRadius: state
                      ? const BorderRadius.only(
                          topLeft: Radius.circular(5),
                          bottomLeft: Radius.circular(5))
                      : BorderRadius.circular(5)),
              child: Icon(
                item.icon,
                size: 20,
              ),
            ),
            SizedBox(width: 12),
            Expanded(
              child: Text(
                item.name,
                style: const TextStyle(
                    fontWeight: FontWeight.w500,
                    overflow: TextOverflow.ellipsis),
              ),
            ),
            SizedBox(width: 12),
            isDatapoint && (item.item as DataPoint).timestamp != null
                ? Text(DateFormat('MMM d. yyy, HH.MM  ')
                    .format((item.item as DataPoint).timestamp!))
                : Container()
          ],
        ),
      ),
    );
  }

  Widget datapointOverview() {
    if (datapoint == null) return Text("Choose a data point");

    return DatapointWidget(datapoint: datapoint!);
  }
}

class FolderItem {
  IconData icon;
  Color color;
  String name;
  dynamic item;

  FolderItem.service(ProfileDocument dataItem)
      : icon = Iconsax.pen_add,
        color = Colors.transparent,
        name = "${dataItem.name}",
        item = dataItem;

  FolderItem.category(DataCategory dataItem)
      : icon = dataItem.category.icon,
        color = dataItem.category.color,
        name = dataItem.category.categoryName,
        item = dataItem;

  FolderItem.name(DataPointName dataItem)
      : icon = Iconsax.folder, //dataItem.dataCategory.target!.category.icon,
        color = Colors.amber, //dataItem.dataCategory.target!.category.color,
        name = dataItem.name,
        item = dataItem;

  FolderItem.point(DataPoint dataItem)
      : icon = Iconsax.paperclip,
        //dataItem.category.target!.category.icon,
        color = Colors.transparent,
        //dataItem.category.target!.category.color,
        name = dataItem.stringName,
        item = dataItem;

  FolderItem.empty()
      : icon = Iconsax.empty_wallet,
        color = Colors.transparent,
        name = "Empty Item";

  factory FolderItem(dynamic dataItem) {
    switch (dataItem.runtimeType) {
      case ProfileDocument:
        return FolderItem.service(dataItem);
      case DataCategory:
        return FolderItem.category(dataItem);
      case DataPointName:
        return FolderItem.name(dataItem);
      case DataPoint:
        return FolderItem.point(dataItem);
      default:
        return FolderItem.empty();
    }
  }

  List<FolderItem> getChildren() {
    switch (item.runtimeType) {
      case ProfileDocument:
        return List.generate(item.categories.length,
            (index) => FolderItem(item.categories[index]));
      case DataCategory:
        return List.generate(item.dataPointNames.length,
            (index) => FolderItem(item.dataPointNames[index]));
      case DataPointName:
        var pointChildren = List.generate(
            item.children.length, (index) => FolderItem(item.children[index]));
        var pointNames = List.generate(item.dataPoints.length,
            (index) => FolderItem(item.dataPoints[index]));
        return pointChildren.followedBy(pointNames).toList();
      default:
        return [];
    }
  }

  FolderItem getParent() {
    switch (item.runtimeType) {
      case DataCategory:
        return FolderItem.service(item.profile.target!);
      case DataPointName:
        return item.parent.hasValue
            ? FolderItem.name(item.parent.target!)
            : FolderItem.category(item.dataCategory.target!);
      default:
        return FolderItem.empty();
    }
  }
}

SvgPicture socialSvg(ServiceEnum service) {
  return SvgPicture.asset(
    service.image,
    color: Colors.white,
    matchTextDirection: true,
  );
}
