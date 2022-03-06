import 'package:flutter/material.dart';
import 'package:waultar/configs/navigation/screen.dart';
import 'package:waultar/presentation/presentation_helper.dart';
import 'package:waultar/presentation/screens/shared/waultar_desktop_main.dart';
import 'package:waultar/presentation/widgets/general/menu_panel.dart';
import 'package:waultar/presentation/widgets/general/top_panel.dart';
import 'package:waultar/presentation/widgets/general/util_widgets/default_button.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class SettingsView extends StatefulWidget {
  const SettingsView({Key? key}) : super(key: key);

  @override
  _SettingsViewState createState() => _SettingsViewState();
}

class _SettingsViewState extends State<SettingsView> {
  late AppLocalizations localizer;
  final _activeScreen = ViewScreen.settings;

  @override
  Widget build(BuildContext context) {
    localizer = AppLocalizations.of(context)!;

    return getWaultarDesktopMainBody(
      context,
      MenuPanel(active: _activeScreen),
      const TopPanel(),
      Column(
        children: [
          SizedBox(
            child: DefaultButton(
              text: localizer.nukeDatabase,
              onPressed: () { PresentationHelper.nukeDatabase(); },
            ),
          ),
        ],
      ),
    );
  }
}
