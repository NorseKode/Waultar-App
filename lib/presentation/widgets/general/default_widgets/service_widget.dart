import 'package:flutter/material.dart';
import 'package:waultar/core/models/misc/service_model.dart';

class ServiceWidget extends StatefulWidget {
  final ServiceModel service;
  const ServiceWidget({Key? key, required this.service}) : super(key: key);

  @override
  _ServiceWidgetState createState() => _ServiceWidgetState();
}

class _ServiceWidgetState extends State<ServiceWidget> {
  @override
  Widget build(BuildContext context) {
    return Container(
        width: 200,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: const Color(0xFF272837)),
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: 40,
                height: 40,
                decoration: BoxDecoration(
                    color: widget.service.color,
                    borderRadius: BorderRadius.circular(5)),
                child: Icon(widget.service.icon, size: 25),
              ),
              const SizedBox(height: 15),
              Text(
                widget.service.name,
                style: const TextStyle(fontSize: 12),
              ),
              const SizedBox(height: 15),
              Row(children: [
                Expanded(
                    flex: 3,
                    child: Container(
                      height: 5,
                      decoration: BoxDecoration(
                        color: widget.service.color,
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
                  const Text(
                    "251 Files",
                    style: TextStyle(color: Color(0xFFABAAB8), fontSize: 12),
                  ),
                  const Text("2.9 GB", style: TextStyle(fontSize: 12))
                ],
              ),
            ],
          ),
        ));
  }
}
