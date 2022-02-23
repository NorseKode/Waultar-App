import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:waultar/core/models/index.dart';
import 'package:waultar/core/models/content/post_model.dart';
import 'package:waultar/core/parsers/parse_helper.dart';
import 'package:waultar/domain/services/browse_service.dart';
import 'package:waultar/presentation/providers/theme_provider.dart';
import 'package:waultar/presentation/widgets/dashboard/default_widget.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class Browse extends StatefulWidget {
  const Browse({Key? key}) : super(key: key);

  @override
  _BrowseState createState() => _BrowseState();
}

class _BrowseState extends State<Browse> {
  late AppLocalizations localizer;
  final _browseService = BrowseService();
  List<dynamic>? _models;
  late ThemeProvider themeProvider;

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
            child: Text(localizer.profile),
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
            child: Text(localizer.posts),
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
            child: Text(localizer.groups),
          ),
          const SizedBox(
            width: 20,
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    localizer = AppLocalizations.of(context)!;
    themeProvider = Provider.of<ThemeProvider>(context);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Browse",
          style: themeProvider.themeData().textTheme.headline3,
        ),
        const SizedBox(
          height: 20,
        ),
        buttons(),
        const SizedBox(
          height: 20,
        ),
        Expanded(
          child: SingleChildScrollView(
            child: _models != null
                ? SizedBox(
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
    );
  }
}
