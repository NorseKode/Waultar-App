import 'package:flutter/material.dart';

class DatapointWidget extends StatefulWidget {
  const DatapointWidget({Key? key}) : super(key: key);

  @override
  State<DatapointWidget> createState() => _DatapointWidgetState();
}

class _DatapointWidgetState extends State<DatapointWidget> {
  @override
  Widget build(BuildContext context) {
    return Container(
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: const Color(0xFF272837)),
        child:
            Padding(padding: const EdgeInsets.all(20.0), child: Container()));
  }
}
