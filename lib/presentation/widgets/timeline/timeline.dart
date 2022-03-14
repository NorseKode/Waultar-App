import 'package:flutter/material.dart';
import 'package:waultar/core/models/ui_model.dart';
import 'package:waultar/presentation/widgets/timeline/datapointlist_widget.dart';
import 'package:waultar/presentation/widgets/timeline/timeline_widget.dart';
import 'package:waultar/presentation/widgets/timeline/test.dart' as test;

class Timeline extends StatefulWidget {
  const Timeline({Key? key}) : super(key: key);

  @override
  State<Timeline> createState() => _TimelineState();
}

class _TimelineState extends State<Timeline> {
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          flex: 2,
          child: Column(
            children: [
              Expanded(
                  flex: 4,
                  child: TimelineWidget(
                    categoryListsSorted: test.list,
                  )),
              SizedBox(height: 20),
              Expanded(
                  flex: 2,
                  child: DatapointListWidget(
                      datapoints: test.list.values.first.first))
            ],
          ),
        ),
        SizedBox(width: 20),
        Expanded(
          flex: 1,
          child: Column(
            children: [
              Expanded(
                child: Container(
                  color: Colors.green,
                ),
              )
            ],
          ),
        )
      ],
    );
  }
}
