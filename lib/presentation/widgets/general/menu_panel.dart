import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:provider/provider.dart';
import 'package:waultar/presentation/providers/theme_provider.dart';
import 'package:waultar/presentation/widgets/general/menu_screens.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class MenuPanel extends StatefulWidget {
  const MenuPanel({Key? key}) : super(key: key);

  @override
  _MenuPanelState createState() => _MenuPanelState();
}

class _MenuPanelState extends State<MenuPanel> {
  late AppLocalizations localizer;
  var active = MenuScreens.dashboard;
  late ThemeProvider themeProvider;
  double menuWidth = 250;

  Widget logo() {
    var logo = SvgPicture.asset('lib/assets/graphics/logo2022.svg',
        semanticsLabel: 'waultar logo', height: 40);

    return SizedBox(
      height: 40,
      child: Row(
        children: [
          logo,
          const SizedBox(
            width: 10,
          ),
          Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Waultar Board",
                  style: TextStyle(fontSize: 12, fontWeight: FontWeight.w400),
                ),
                SizedBox(height: 3),
                Container(
                    child: Row(
                  children: [
                    Text(
                      "Last upload:",
                      style: TextStyle(
                          color: Color(0xFFABAAB8),
                          fontSize: 10,
                          fontWeight: FontWeight.w200),
                    ),
                    SizedBox(width: 5),
                    Container(
                      decoration: BoxDecoration(
                          color: Color(0xFF4FB376),
                          borderRadius: BorderRadius.circular(100)),
                      child: Padding(
                        padding: const EdgeInsets.fromLTRB(8, 2, 8, 2),
                        child: Text("Feb 2. 2022",
                            style: TextStyle(
                                fontSize: 9, fontWeight: FontWeight.w200)),
                      ),
                    )
                  ],
                ))
              ])
        ],
      ),
    );
  }

  Widget menuButton(
    IconData icon,
    String title,
    MenuScreens screen,
  ) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Container(
        child: TextButton(
          style: ButtonStyle(
            shape: MaterialStateProperty.all(RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.0))),
            backgroundColor: MaterialStateProperty.all(active == screen
                ? Color(0xFF2F2F4A)
                : Colors.black.withOpacity(0.0)),
          ),
          onPressed: () async {
            active = screen;
            screen == MenuScreens.theme
                ? await themeProvider.toggleThemeData()
                : null;
            setState(() {});
          },
          child: Padding(
            padding: const EdgeInsets.fromLTRB(6, 12, 6, 12),
            child: Row(
              children: [
                Icon(
                  icon,
                  color: active == screen ? Colors.white : Color(0xFFABAAB8),
                  size: 12,
                ),
                const SizedBox(width: 12),
                Text(title,
                    style: TextStyle(
                        fontWeight: FontWeight.w400,
                        fontSize: 12,
                        color: active == screen
                            ? Colors.white
                            : Color(0xFFABAAB8)))
              ],
            ),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    localizer = AppLocalizations.of(context)!;
    themeProvider = Provider.of<ThemeProvider>(context);

    return Container(
        width: menuWidth,
        height: MediaQuery.of(context).size.height,
        decoration: BoxDecoration(
            color: Color(0xFF272837),
            borderRadius: BorderRadius.only(topRight: Radius.circular(10))),
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  logo(),
                  Divider(height: 40, thickness: 2, color: Color(0xFF363747)),
                  menuButton(Iconsax.music_dashboard, localizer.dashboard,
                      MenuScreens.dashboard),
                  menuButton(Iconsax.command, localizer.collections,
                      MenuScreens.comments),
                  menuButton(
                      themeProvider.isLightTheme ? Iconsax.sun : Iconsax.moon,
                      localizer.changeTheme,
                      MenuScreens.theme),
                  Divider(height: 40, thickness: 2, color: Color(0xFF363747)),
                ],
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  //profile(),
                  menuButton(Iconsax.setting, localizer.settings,
                      MenuScreens.settings),
                  menuButton(
                      Iconsax.logout, localizer.logout, MenuScreens.logout)
                ],
              ),
            ],
          ),
        ));
  }
}
