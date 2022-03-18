import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:waultar/core/models/timeline/time_models.dart';
import 'package:waultar/core/models/ui_model.dart';
import 'package:waultar/presentation/providers/theme_provider.dart';
import 'package:waultar/presentation/widgets/general/default_widgets/default_widget_box.dart';

class DataPointWidget extends StatefulWidget {
  List<UIModel> dpList;
  DataPointWidget({required this.dpList, Key? key}) : super(key: key);

  @override
  State<DataPointWidget> createState() => _DataPointWidgetState();
}

class _DataPointWidgetState extends State<DataPointWidget> {
  late ThemeProvider themeProvider;
  bool visible = false;

  @override
  Widget build(BuildContext context) {
    themeProvider = Provider.of<ThemeProvider>(context);
    return DefaultWidgetBox(
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      Row(
        children: [
          SizedBox(
            width: 50,
            child: Text(
              "Type",
              style: themeProvider.themeData().textTheme.headline4,
            ),
          ),
          SizedBox(width: 20),
          Expanded(
            flex: 2,
            child: Text(
              "Title",
              style: themeProvider.themeData().textTheme.headline4,
            ),
          ),
          SizedBox(width: 40),
          Expanded(
            child: Text(
              "Service",
              style: themeProvider.themeData().textTheme.headline4,
            ),
          ),
          SizedBox(width: 20),
          Expanded(
            child: Text(
              "Timestamp",
              style: themeProvider.themeData().textTheme.headline4,
            ),
          ),
        ],
      ),
      SizedBox(height: 15),
      Expanded(
        child: ListView.separated(
          itemCount: widget.dpList.length,
          itemBuilder: (BuildContext context, int index) {
            return Row(
              children: [
                SizedBox(
                  width: 50,
                  child: Text("Post",
                      style:
                          TextStyle(fontSize: 12, fontWeight: FontWeight.w400)),
                ),
                SizedBox(width: 20),
                Expanded(
                  flex: 2,
                  child: Text(
                    widget.dpList[index].getMostInformativeField(),
                    style: TextStyle(fontSize: 12, fontWeight: FontWeight.w400),
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                SizedBox(width: 40),
                Expanded(
                  child: Text("Facebook",
                      style:
                          TextStyle(fontSize: 12, fontWeight: FontWeight.w400)),
                ),
                SizedBox(width: 20),
                Expanded(
                  child: Text(
                      DateFormat('dd. MMMM y Hm')
                          .format(widget.dpList[index].getTimestamp()),
                      style:
                          TextStyle(fontSize: 12, fontWeight: FontWeight.w400)),
                ),
              ],
            );
          },
          separatorBuilder: (BuildContext context, int index) {
            return SizedBox(height: 10);
          },
        ),
      )
    ]));
  }
}
