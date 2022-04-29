import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:waultar/configs/globals/service_enums.dart';
import 'package:waultar/data/entities/misc/profile_document.dart';
import 'package:waultar/data/entities/misc/service_document.dart';
import 'package:waultar/presentation/providers/theme_provider.dart';

class ServiceWidget extends StatefulWidget {
  final ProfileDocument service;
  const ServiceWidget({Key? key, required this.service}) : super(key: key);

  @override
  _ServiceWidgetState createState() => _ServiceWidgetState();
}

class _ServiceWidgetState extends State<ServiceWidget> {
  late ThemeProvider themeProvider;

  @override
  Widget build(BuildContext context) {
    themeProvider = Provider.of<ThemeProvider>(context);
    ServiceEnum serviceEnum = getFromID(widget.service.service.target!.id);
    return Container(
        // constraints: BoxConstraints(minWidth: 200, maxWidth: 200),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: themeProvider.themeData().primaryColor),
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: 40,
                height: 40,
                decoration: BoxDecoration(
                    color: serviceEnum
                        .color, //widget.service.service.target!.color,
                    borderRadius: BorderRadius.circular(5)),
                child: Padding(
                  padding: const EdgeInsets.all(5.0),
                  child: SvgPicture.asset(
                    serviceEnum.image,
                    color: Colors.white,
                    matchTextDirection: true,
                  ),
                ),
              ),
              const SizedBox(width: 15),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "${widget.service.name}",
                    style: const TextStyle(
                        fontSize: 14, fontWeight: FontWeight.w400),
                  ),
                  const SizedBox(height: 2),
                  Text(
                    "${widget.service.service.target!.serviceName}",
                    style: themeProvider.themeData().textTheme.headline4,
                  ),
                ],
              ),
              SizedBox(width: 30),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "${NumberFormat.compact().format(widget.service.categories.fold<int>(0, (previousValue, element) => previousValue + element.count))}",
                    style: const TextStyle(
                        fontSize: 14, fontWeight: FontWeight.w400),
                  ),
                  const SizedBox(height: 2),
                  Text(
                    "DP",
                    style: themeProvider.themeData().textTheme.headline4,
                  ),
                ],
              ),
              SizedBox(width: 30),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "${DateFormat('EE, MMM d. yyy').format(widget.service.categories.first.dataPointNames.first.dataPoints.first.createdAt)}",
                    style: const TextStyle(
                        fontSize: 14, fontWeight: FontWeight.w400),
                  ),
                  const SizedBox(height: 2),
                  Text(
                    "Uploaded",
                    style: themeProvider.themeData().textTheme.headline4,
                  ),
                ],
              ),
            ],
          ),
        ));
  }
}
