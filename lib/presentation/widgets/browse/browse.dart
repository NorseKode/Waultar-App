import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:waultar/core/models/index.dart';
import 'package:waultar/core/models/content/post_model.dart';
import 'package:waultar/core/parsers/parse_helper.dart';
import 'package:waultar/domain/services/browse_service.dart';
import 'package:waultar/presentation/providers/theme_provider.dart';
import 'package:waultar/presentation/widgets/dashboard/default_widget.dart';

class Browse extends StatefulWidget {
  const Browse({Key? key}) : super(key: key);

  @override
  _BrowseState createState() => _BrowseState();
}

class _BrowseState extends State<Browse> {
  final _browseService = BrowseService();
  List<dynamic>? _models;
  late ThemeProvider themeProvider;

  @override
  Widget build(BuildContext context) {
    themeProvider = Provider.of<ThemeProvider>(context);
    buttons() {
      return SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Row(
          children: [
            ElevatedButton(
              onPressed: () {
                setState(() {
                  _models = _browseService.getProfiles();
                });
              },
              child: Text("Profile"),
            ),
            const SizedBox(
              width: 20,
            ),
            ElevatedButton(
              onPressed: () {
                setState(() {
                  // _models = _browseService.getPosts();
                  _models = List.generate(
                      20,
                      (index) => PostModel(
                          profile: ParseHelper.profile,
                          raw: "raw",
                          timestamp: DateTime.now(),
                          title: "Yeah"));
                });
              },
              child: Text("Posts"),
            ),
            const SizedBox(
              width: 20,
            ),
            ElevatedButton(
              onPressed: () {
                // setState(() {
                //   _models = _browseService.getGroups();
                // });
              },
              child: Text("Groups - Doesn't work yet"),
            ),
            const SizedBox(
              width: 20,
            ),
          ],
        ),
      );
    }

    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Browse",
            style: themeProvider.themeData().textTheme.headline3,
          ),
          SizedBox(height: 20),
          buttons(),
          SizedBox(
            height: 20,
          ),
          Expanded(
            child: SingleChildScrollView(
              child: _models != null
                  ? Container(
                      width: MediaQuery.of(context).size.width - 290,
                      child: Wrap(
                        spacing: 20,
                        runSpacing: 20,
                        children: List.generate(
                          _models!.length,
                          (index) => DefaultWidget(
                            title: "Title",
                            child: Text(
                              _models![index].toString(),
                            ),
                          ),
                        ),
                      ))
                  : Container(),
            ),
          )
          // idgets
        ],
      ),
    );
  }
}
