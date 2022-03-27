import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:waultar/core/models/timeline/time_models.dart';
import 'package:waultar/presentation/providers/theme_provider.dart';
import 'package:waultar/presentation/widgets/general/default_widgets/default_widget_box.dart';

class FilterWidget extends StatefulWidget {
  List<TimeModel> blocks;
  FilterWidget({required this.blocks, Key? key}) : super(key: key);

  @override
  State<FilterWidget> createState() => _FilterWidgetState();
}

class _FilterWidgetState extends State<FilterWidget> {
  late ThemeProvider themeProvider;
  Map<String, bool> elements = {
    'Grid': false,
    'Bar Chart': false,
    'Third option': false,
  };

  Map<String, bool> services = {
    'Facebook': false,
    'Instagram': false,
  };

  _checkboxList(Map<String, bool> values) {
    return Column(
      children: values.keys.map((String key) {
        return Padding(
          padding: const EdgeInsets.only(bottom: 5.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Transform.scale(
                    scale: 0.75,
                    child: SizedBox(
                      height: 15,
                      width: 15,
                      child: Checkbox(
                        splashRadius: 0,
                        checkColor: Colors.white,
                        fillColor: MaterialStateProperty.all(const Color(0xFF19A8F5)),
                        value: values[key],
                        onChanged: (bool? value) {
                          setState(() {
                            values[key] = value!;
                          });
                        },
                      ),
                    ),
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  Text(
                    key,
                    style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w500),
                  ),
                ],
              ),
              Text("${key.length * 7}",
                  style: themeProvider.themeData().textTheme.headline4),
            ],
          ),
        );
      }).toList(),
    );
  }

  @override
  Widget build(BuildContext context) {
    themeProvider = Provider.of<ThemeProvider>(context);

    return DefaultWidgetBox(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text("Filter", style: themeProvider.themeData().textTheme.headline1),
          const SizedBox(
            height: 15,
          ),
          Text("Elements",
              style: themeProvider.themeData().textTheme.headline4),
          const SizedBox(
            height: 10,
          ),
          _checkboxList(elements),
          const SizedBox(
            height: 15,
          ),
          Text("Services",
              style: themeProvider.themeData().textTheme.headline4),
          const SizedBox(
            height: 10,
          ),
          _checkboxList(services),
        ],
      ),
    );
  }
}
