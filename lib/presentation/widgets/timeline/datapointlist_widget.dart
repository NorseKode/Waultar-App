import 'package:flutter/material.dart';
import 'package:waultar/core/models/ui_model.dart';

class DatapointListWidget extends StatefulWidget {
  List<UIModel> datapoints;
  DatapointListWidget({required this.datapoints, Key? key}) : super(key: key);

  @override
  State<DatapointListWidget> createState() => _DatapointListWidgetState();
}

class _DatapointListWidgetState extends State<DatapointListWidget> {
  Widget _listItem(UIModel item) {
    return Container(
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: const Color(0xFF272837)),
        child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Row(
              children: [
                SizedBox(
                    width: 10,
                    height: 10,
                    child: Container(
                      decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: item.getAssociatedColor()),
                    )),
                SizedBox(
                  width: 20,
                ),
                Expanded(
                    child:
                        Container(child: Text(item.getMostInformativeField()))),
                Container(child: Text(item.getTimestamp().toString())),
              ],
            )));
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: SingleChildScrollView(
          child: Column(
              children: List.generate(
                  widget.datapoints.length,
                  (index) => Padding(
                        padding: const EdgeInsets.only(bottom: 10.0),
                        child: _listItem(widget.datapoints[index]),
                      )))),
    );
  }
}
