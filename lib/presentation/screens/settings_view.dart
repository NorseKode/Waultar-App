import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:waultar/configs/globals/app_logger.dart';
import 'package:waultar/configs/globals/globals.dart';
import 'package:waultar/configs/navigation/screen.dart';
import 'package:logging/logging.dart';
import 'package:waultar/core/abstracts/abstract_services/i_appsettings_service.dart';
import 'package:waultar/core/abstracts/abstract_services/i_do_not_user_service.dart';
import 'package:waultar/core/helpers/do_not_use_helper.dart';
import 'package:waultar/data/repositories/media_repo.dart';
import 'package:waultar/domain/services/do_no_use_service.dart';
import 'package:waultar/presentation/presentation_helper.dart';
import 'package:waultar/presentation/providers/theme_provider.dart';
import 'package:waultar/presentation/screens/shared/waultar_desktop_main.dart';
import 'package:waultar/presentation/widgets/general/menu_panel.dart';
import 'package:waultar/presentation/widgets/general/top_panel.dart';
import 'package:waultar/presentation/widgets/general/default_widgets/default_button.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:waultar/presentation/widgets/snackbar_custom.dart';
import 'package:waultar/startup.dart';

class SettingsView extends StatefulWidget {
  const SettingsView({Key? key}) : super(key: key);

  @override
  _SettingsViewState createState() => _SettingsViewState();
}

class _SettingsViewState extends State<SettingsView> {
  late AppLocalizations localizer;
  late ThemeProvider themeProvider;
  final _activeScreen = ViewScreen.settings;
  final _appSettings = locator.get<IAppSettingsService>(instanceName: 'appSettingsService');
  final _appLogger = locator.get<BaseLogger>(instanceName: 'logger');

  @override
  Widget build(BuildContext context) {
    localizer = AppLocalizations.of(context)!;
    themeProvider = Provider.of<ThemeProvider>(context);

    return getWaultarDesktopMainBody(
      context,
      MenuPanel(
        active: _activeScreen,
      ),
      const TopPanel(),
      Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Settings",
            style: themeProvider.themeData().textTheme.headline3,
          ),
          SizedBox(height: 20),
          const Text("Developer Tools"),
          const Divider(),
          Padding(
            padding: const EdgeInsets.fromLTRB(0, 0, 0, 20),
            child: DefaultButton(
              text: "Clear Database",
              onPressed: () {
                PresentationHelper.nukeDatabase();
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(0, 0, 0, 20),
            child: Row(
              children: [
                const Text("Enable performance mode"),
                Switch(
                  value: ISPERFORMANCETRACKING,
                  onChanged: (value) async {
                    await _appSettings.toggleIsPerformanceTracking(value);
                    // _appLogger.changeLogLevel(Level.INFO);
                    if (!value) {
                      _appLogger.changeLogLevel(LOGLEVEL);
                    } else {
                      _appLogger.changeLogLevel(Level.SEVERE);
                    }

                    setState(() {});
                  },
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(0, 0, 0, 20),
            child: DefaultButton(
              text: "Delete Image Tags",
              onPressed: () {
                locator.get<MediaRepository>(instanceName: 'mediaRepo').deleteAllImageTags();
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(0, 0, 0, 20),
            child: DefaultButton(
              text: 'Dump Database As Json',
              onPressed: () {
                SnackBarCustom.useSnackbarOfContext(
                    context, "Started writing dump, it may take some time");
                PresentationHelper.dumpDbAsJson();
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(0, 0, 0, 20),
            child: DefaultButton(
              text: "Delete all sentiment scores",
              onPressed: () => PresentationHelper.deleteAllSentimentScores(),
            ),
          ),
          const Divider(),
          const Padding(
            padding: const EdgeInsets.fromLTRB(0, 0, 0, 20),
            child: DefaultButton(
              text: "Create memory overflow on main thread",
              // onPressed: () => DoNotUseHelper.createMemoryOverflow(),
            ),
          ),
          const Padding(
            padding: const EdgeInsets.fromLTRB(0, 0, 0, 20),
            child: DefaultButton(
              text: "Create memory overflow on separate thread",
              // onPressed: () => DoNotUseService().createMemoryOverflow(),
            ),
          ),
        ],
      ),
    );
  }
}
