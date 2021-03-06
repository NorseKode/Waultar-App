import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:provider/provider.dart';
import 'package:waultar/configs/navigation/app_state.dart';
import 'package:waultar/configs/navigation/router/app_route_path.dart';
import 'package:waultar/configs/navigation/screen.dart';
import 'package:waultar/presentation/providers/theme_provider.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class MenuPanel extends StatefulWidget {
  final ViewScreen active;
  const MenuPanel({required this.active, Key? key}) : super(key: key);

  @override
  _MenuPanelState createState() => _MenuPanelState();
}

class _MenuPanelState extends State<MenuPanel> {
  late AppLocalizations localizer;
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
                const Text(
                  "Waultar App",
                  style: TextStyle(
                      fontSize: 12, fontWeight: FontWeight.w400),
                ),
                const SizedBox(height: 3),
                Row(
                  children: [
                    Text(
                      localizer.lastUpload + ":",
                      style: TextStyle(
                          color: themeProvider.themeMode().tonedTextColor,
                          fontSize: 10,
                          fontWeight: FontWeight.w200),
                    ),
                    const SizedBox(width: 5),
                    // ignore: avoid_unnecessary_containers
                    Container(
                      child: const Padding(
                        padding: EdgeInsets.fromLTRB(2, 2, 8, 2),
                        child: Text("Feb 2. 2022",
                            style: TextStyle(
                                color: Color(0xFF4FB376),
                                fontSize: 10,
                                fontWeight: FontWeight.w600)),
                      ),
                    )
                  ],
                )
              ])
        ],
      ),
    );
  }

  Widget menuButton(
    IconData icon,
    String title,
    ViewScreen screen,
    Function(ViewScreen screen) onPressed,
  ) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: TextButton(
        style: ButtonStyle(
          overlayColor: MaterialStateProperty.all(
              (themeProvider.themeMode().secondaryColor)),
          shape: MaterialStateProperty.all(RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10.0))),
          backgroundColor: MaterialStateProperty.all(widget.active == screen
              ? (themeProvider.themeMode().secondaryColor)
              : Colors.black.withOpacity(0.0)),
        ),
        onPressed: () async {
          onPressed(screen);
          setState(() {});
        },
        child: Padding(
          padding: const EdgeInsets.fromLTRB(6, 12, 6, 12),
          child: Row(
            children: [
              Icon(
                icon,
                color: widget.active != screen
                    ? themeProvider.themeMode().tonedTextColor
                    : Colors.white, //const Color(0xFFABAAB8),
                size: 12,
              ),
              const SizedBox(width: 12),
              Text(
                title,
                style: TextStyle(
                    color: widget.active != screen
                        ? themeProvider.themeMode().tonedTextColor
                        : Colors.white,
                    fontFamily: "Poppins",
                    fontSize: 12,
                    fontWeight: FontWeight.w400),
              ) //const Color(0xFFABAAB8)))
            ],
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
        color: themeProvider.themeData().primaryColor,
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  logo(),
                  Divider(
                      height: 40,
                      thickness: 2,
                      color: themeProvider.themeMode().tonedColor),
                  menuButton(
                      Iconsax.health, localizer.dashboard, ViewScreen.dashboard,
                      (_) {
                    context
                        .read<AppState>()
                        .updateNavigatorState(AppRoutePath.home());
                  }),
                  menuButton(Iconsax.element_3, localizer.collections,
                      ViewScreen.browse, (_) {
                    context
                        .read<AppState>()
                        .updateNavigatorState(AppRoutePath.browse());
                  }),
                  menuButton(
                      Iconsax.image, localizer.gallery, ViewScreen.gallery,
                      (_) {
                    context
                        .read<AppState>()
                        .updateNavigatorState(AppRoutePath.gallery());
                  }),
                  menuButton(
                      Iconsax.ruler, localizer.timeline, ViewScreen.timeline,
                      (_) {
                    context
                        .read<AppState>()
                        .updateNavigatorState(AppRoutePath.timeline());
                  }),
                  menuButton(Iconsax.search_normal_1, localizer.search,
                      ViewScreen.search, (_) {
                    context
                        .read<AppState>()
                        .updateNavigatorState(AppRoutePath.search());
                  }),
                  Divider(
                      height: 40,
                      thickness: 2,
                      color: themeProvider.themeMode().tonedColor),
                  menuButton(
                      themeProvider.isLightTheme ? Iconsax.sun : Iconsax.moon,
                      localizer.changeTheme,
                      ViewScreen.unknown, (_) async {
                    await themeProvider.toggleThemeData();
                  }),
                  Divider(
                      height: 40,
                      thickness: 2,
                      color: themeProvider.themeMode().tonedColor),
                ],
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  //profile(),
                  menuButton(
                      Iconsax.setting, localizer.settings, ViewScreen.unknown,
                      (_) {
                    context
                        .read<AppState>()
                        .updateNavigatorState(AppRoutePath.settings());
                  }),
                  menuButton(Iconsax.logout, localizer.logout,
                      ViewScreen.signin, (_) {})
                ],
              ),
            ],
          ),
        ));
  }
}
