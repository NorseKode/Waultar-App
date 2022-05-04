import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:waultar/configs/globals/service_enums.dart';
import 'package:waultar/data/entities/misc/profile_document.dart';
import 'package:waultar/presentation/providers/theme_provider.dart';

class ServiceWidget extends StatefulWidget {
  final ProfileDocument service;
  const ServiceWidget({Key? key, required this.service}) : super(key: key);

  @override
  _ServiceWidgetState createState() => _ServiceWidgetState();
}

class _ServiceWidgetState extends State<ServiceWidget> {
  late ThemeProvider themeProvider;

  _servicename() {
    return Text(
      widget.service.service.target!.serviceName,
      style: themeProvider.themeData().textTheme.headline4!,
    );
  }

  _profilename() {
    return SizedBox(
      width: 135,
      child: Text(
        widget.service.name,
        maxLines: 1,
        softWrap: false,
        style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
      ),
    );
  }

  _size() {
    return Text(
      "${NumberFormat.compact().format(widget.service.categories.fold<int>(0, (previousValue, element) => previousValue + element.count))} DP",
      //"${widget.service.dataPoints.length} points",
      style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w400),
      // style: const TextStyle(
      //     color: Color.fromARGB(255, 149, 150, 159),
      //     fontFamily: "Poppins",
      //     fontWeight: FontWeight.w400),
    );
  }

  _date() {
    return Text(
        DateFormat('MMM d. yyy').format(widget.service.categories.first.dataPointNames.first.dataPoints.first.createdAt),
        style: themeProvider.themeData().textTheme.headline4);
  }

  @override
  Widget build(BuildContext context) {
    themeProvider = Provider.of<ThemeProvider>(context);
    ServiceEnum serviceEnum = getFromID(widget.service.service.target!.id);
    return Container(
        constraints: const BoxConstraints(minWidth: 200, maxWidth: 230),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: themeProvider.themeData().primaryColor),
        child: Padding(
          padding: const EdgeInsets.all(15),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Container(
                    width: 40,
                    height: 40,
                    decoration: BoxDecoration(
                        color: serviceEnum
                            .color, //widget.service.service.target!.color,
                        borderRadius: BorderRadius.circular(5)),
                    child: SizedBox(
                      child: Padding(
                        padding: const EdgeInsets.all(5.0),
                        child: SvgPicture.asset(
                          serviceEnum.image,
                          color: Colors.white,
                          matchTextDirection: true,
                        ),
                      ),
                      width: 25,
                      height: 25,
                    ),
                  ),
                  const SizedBox(width: 15),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _profilename(),
                      const SizedBox(height: 2),
                      _date(), //_servicename()
                    ],
                  ),
                ],
              ),

              //const SizedBox(height: 15),
              // Row(children: [
              //   Expanded(
              //       flex: 3,
              //       child: Container(
              //         height: 5,
              //         decoration: const BoxDecoration(
              //           color: Colors
              //               .white, //widget.service.service.target!.color,
              //           borderRadius: BorderRadius.only(
              //             topLeft: Radius.circular(10),
              //             bottomLeft: Radius.circular(10),
              //           ),
              //         ),
              //       )),
              //   Expanded(
              //     flex: 1,
              //     child: Container(
              //         height: 5,
              //         decoration: const BoxDecoration(
              //           color: Color(0xFF4D4F68),
              //           borderRadius: BorderRadius.only(
              //             topRight: Radius.circular(10),
              //             bottomRight: Radius.circular(10),
              //           ),
              //         )),
              //   )
              // ]),
              // const SizedBox(height: 15),
              // Row(
              //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
              //   // ignore: prefer_const_literals_to_create_immutables
              //   children: [
              //     //_size(),
              //     //_date(),
              //   ],
              // ),
            ],
          ),
        ));
    // return Container(
    //     // constraints: BoxConstraints(minWidth: 200, maxWidth: 200),
    //     decoration: BoxDecoration(
    //         borderRadius: BorderRadius.circular(10),
    //         color: themeProvider.themeData().primaryColor),
    //     child: Padding(
    //       padding: const EdgeInsets.all(20),
    //       child: Row(
    //         mainAxisSize: MainAxisSize.min,
    //         crossAxisAlignment: CrossAxisAlignment.start,
    //         children: [
    //           Container(
    //             width: 40,
    //             height: 40,
    //             decoration: BoxDecoration(
    //                 color: serviceEnum
    //                     .color, //widget.service.service.target!.color,
    //                 borderRadius: BorderRadius.circular(5)),
    //             child: Padding(
    //               padding: const EdgeInsets.all(5.0),
    //               child: SvgPicture.asset(
    //                 serviceEnum.image,
    //                 color: Colors.white,
    //                 matchTextDirection: true,
    //               ),
    //             ),
    //           ),
    //           const SizedBox(width: 15),
    //           Column(
    //             crossAxisAlignment: CrossAxisAlignment.start,
    //             children: [
    //               Text(
    //                 "${widget.service.name}",
    //                 style: const TextStyle(
    //                     fontSize: 14, fontWeight: FontWeight.w400),
    //               ),
    //               const SizedBox(height: 2),
    //               Text(
    //                 "${widget.service.service.target!.serviceName}",
    //                 style: themeProvider.themeData().textTheme.headline4,
    //               ),
    //             ],
    //           ),
    //           SizedBox(width: 30),
    //           Column(
    //             crossAxisAlignment: CrossAxisAlignment.start,
    //             children: [
    //               Text(
    //                 "${NumberFormat.compact().format(widget.service.categories.fold<int>(0, (previousValue, element) => previousValue + element.count))}",
    //                 style: const TextStyle(
    //                     fontSize: 14, fontWeight: FontWeight.w400),
    //               ),
    //               const SizedBox(height: 2),
    //               Text(
    //                 "DP",
    //                 style: themeProvider.themeData().textTheme.headline4,
    //               ),
    //             ],
    //           ),
    //           SizedBox(width: 30),
    //           Column(
    //             crossAxisAlignment: CrossAxisAlignment.start,
    //             children: [
    //               Text(
    //                 "${DateFormat('MMM d. yyy').format(widget.service.categories.first.dataPointNames.first.dataPoints.first.createdAt)}",
    //                 style: const TextStyle(
    //                     fontSize: 14, fontWeight: FontWeight.w400),
    //               ),
    //               const SizedBox(height: 2),
    //               Text(
    //                 "Uploaded",
    //                 style: themeProvider.themeData().textTheme.headline4,
    //               ),
    //             ],
    //           ),
    //         ],
    //       ),
    //     ));
  }
}
