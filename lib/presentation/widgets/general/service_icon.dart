import 'package:flutter/material.dart';
import 'package:waultar/core/models/misc/service_model.dart';

class ServiceIcon extends StatefulWidget {
  final ServiceModel service;
  final double? size;
  const ServiceIcon({Key? key, required this.service, this.size})
      : super(key: key);

  @override
  _ServiceIconState createState() => _ServiceIconState();
}

class _ServiceIconState extends State<ServiceIcon> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: widget.size,
      height: widget.size,
      decoration: BoxDecoration(
          color: widget.service.color, borderRadius: BorderRadius.circular(10)),
      // child: Container(
      //   width: widget.size != null ? widget.size! * 0.5 : null,
      //   height: widget.size != null ? widget.size! * 0.5 : null,
      //   child: Icon(
      //     widget.service.icon,
      //   ),
      // ),
    );
  }
}
