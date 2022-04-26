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
        constraints: BoxConstraints(minWidth: 200, maxWidth: 200),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: themeProvider.themeData().primaryColor),
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
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
              const SizedBox(height: 15),
              Text(
                "${widget.service.service.target!.serviceName} - ${widget.service.name}",
                softWrap: true,
                style: const TextStyle(fontSize: 12),
              ),
              const SizedBox(height: 15),
              Row(children: [
                Expanded(
                    flex: 3,
                    child: Container(
                      height: 5,
                      decoration: BoxDecoration(
                        color: serviceEnum.color,
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(10),
                          bottomLeft: Radius.circular(10),
                        ),
                      ),
                    )),
                Expanded(
                  flex: 1,
                  child: Container(
                      height: 5,
                      decoration: const BoxDecoration(
                        color: Color(0xFF4D4F68),
                        borderRadius: BorderRadius.only(
                          topRight: Radius.circular(10),
                          bottomRight: Radius.circular(10),
                        ),
                      )),
                )
              ]),
              const SizedBox(height: 15),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                // ignore: prefer_const_literals_to_create_immutables
                children: [
                  Text(
                    "${NumberFormat.compact().format(145342)} points", //"${widget.service.dataPoints.length} points",

                    style: const TextStyle(
                        color: Color.fromARGB(255, 149, 150, 159),
                        fontFamily: "Poppins",
                        fontSize: 12,
                        fontWeight: FontWeight.w400),
                  ),
                  const Text("4.3 GB", style: TextStyle(fontSize: 12))
                ],
              ),
            ],
          ),
        ));
  }
}
