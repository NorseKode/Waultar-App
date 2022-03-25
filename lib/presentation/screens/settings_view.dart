import 'package:flutter/material.dart';
import 'package:waultar/configs/globals/app_logger.dart';
import 'package:waultar/configs/globals/globals.dart';
import 'package:waultar/configs/navigation/screen.dart';
import 'package:logging/logging.dart';
import 'package:waultar/core/abstracts/abstract_services/i_appsettings_service.dart';
import 'package:waultar/presentation/presentation_helper.dart';
import 'package:waultar/presentation/screens/shared/waultar_desktop_main.dart';
import 'package:waultar/presentation/widgets/general/menu_panel.dart';
import 'package:waultar/presentation/widgets/general/top_panel.dart';
import 'package:waultar/presentation/widgets/general/util_widgets/default_button.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:waultar/startup.dart';

class SettingsView extends StatefulWidget {
  const SettingsView({Key? key}) : super(key: key);

  @override
  _SettingsViewState createState() => _SettingsViewState();
}

class _SettingsViewState extends State<SettingsView> {
  late AppLocalizations localizer;
  final _activeScreen = ViewScreen.settings;
  final _appSettings = locator.get<IAppSettingsService>(instanceName: 'appSettingsService');
  final _appLogger = locator.get<AppLogger>(instanceName: 'logger');

  @override
  Widget build(BuildContext context) {
    localizer = AppLocalizations.of(context)!;

    return getWaultarDesktopMainBody(
      context,
      MenuPanel(active: _activeScreen),
      const TopPanel(),
      Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          DefaultButton(
            text: localizer.nukeDatabase,
            onPressed: () {
              PresentationHelper.nukeDatabase();
            },
          ),
          const Divider(),
          Row(
            children: [
              const Text("Enable performance mode"),
              Switch(
                value: ISPERFORMANCETRACKING,
                onChanged: (value) async {
                  await _appSettings.toggleIsPerformanceTracking(value);

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
        ],
      ),
    );
  }
}
