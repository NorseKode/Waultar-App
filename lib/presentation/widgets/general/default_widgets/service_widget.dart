import 'dart:io';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:waultar/core/models/misc/service_model.dart';
import 'package:waultar/data/entities/misc/service_document.dart';
import 'package:waultar/presentation/providers/theme_provider.dart';

class ServiceWidget extends StatefulWidget {
  final ServiceDocument service;
  const ServiceWidget({Key? key, required this.service}) : super(key: key);

  @override
  _ServiceWidgetState createState() => _ServiceWidgetState();
}

class _ServiceWidgetState extends State<ServiceWidget> {
  late ThemeProvider themeProvider;

  @override
  Widget build(BuildContext context) {
    themeProvider = Provider.of<ThemeProvider>(context);
    return Container(
        width: 200,
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
                    color: Color(0xFF5D97FF),
                    borderRadius: BorderRadius.circular(5)),
                child: Container(
                  child: Container(),
                  width: 25,
                  height: 25,
                ),
              ),
              const SizedBox(height: 15),
              Text(
                widget.service.serviceName,
                style: const TextStyle(fontSize: 12),
              ),
              const SizedBox(height: 15),
              Row(children: [
                Expanded(
                    flex: 3,
                    child: Container(
                      height: 5,
                      decoration: BoxDecoration(
                        color: Color(0xFF5D97FF),
                        borderRadius: const BorderRadius.only(
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
                    "${widget.service.totalDatapoints} data points",
                    style: TextStyle(color: Color(0xFFABAAB8), fontSize: 12),
                  ),
                  Text("${_sizeOfService(widget.service)} GB",
                      style: TextStyle(fontSize: 12))
                ],
              ),
            ],
          ),
        ));
  }

  double _sizeOfService(ServiceDocument service) {
    return 0.0;
  }
}
