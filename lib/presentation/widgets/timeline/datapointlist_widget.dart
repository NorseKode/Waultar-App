import 'package:flutter/material.dart';

class DatapointListWidget extends StatefulWidget {
  const DatapointListWidget({Key? key}) : super(key: key);

  @override
  State<DatapointListWidget> createState() => _DatapointListWidgetState();
}

class _DatapointListWidgetState extends State<DatapointListWidget> {
  Widget _listItem() {
    return Padding(
      padding: const EdgeInsets.only(bottom: 4.0),
      child: Container(
        color: Colors.white,
        height: 100,
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Row(
            children: [
              Expanded(child: Container(color: Colors.red)),
              Expanded(child: Container(color: Colors.yellow)),
              Expanded(child: Container(color: Colors.orange)),
              Expanded(child: Container(color: Colors.green)),
              Expanded(child: Container(color: Colors.blue)),
            ],
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: SingleChildScrollView(
          child: Column(children: List.generate(10, (index) => _listItem()))),
    );
  }
}
