import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:waultar/core/abstracts/abstract_repositories/i_service_repository.dart';
import 'package:waultar/domain/services/parser_service.dart';
import 'package:waultar/presentation/providers/theme_provider.dart';
import 'package:waultar/presentation/widgets/dashboard/service_widget.dart';
import 'package:waultar/presentation/widgets/upload/upload_files.dart';
import 'package:waultar/presentation/widgets/upload/uploader.dart';
import 'package:waultar/startup.dart';
import 'package:iconsax/iconsax.dart';
import 'package:path/path.dart' as dart_path;

class Dashboard extends StatefulWidget {
  const Dashboard({Key? key}) : super(key: key);

  @override
  _DashboardState createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  late AppLocalizations localizer;
  late ThemeProvider themeProvider;
  List<File> uploadedFiles = [];
  final IServiceRepository _serviceRepo =
      locator.get<IServiceRepository>(instanceName: 'serviceRepo');

  @override
  Widget build(BuildContext context) {
    localizer = AppLocalizations.of(context)!;

    themeProvider = Provider.of<ThemeProvider>(context);
    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 20, 20, 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            localizer.dashboard,
            style: themeProvider.themeData().textTheme.headline3,
          ),
          const SizedBox(height: 20), //TODO: Implement CustomMultiChildLayout
          Expanded(
              child: Container(
            color: Colors.white,
            child: Column(
              children: [
                Row(
                  children: [
                    ServiceWidget(
                        color: Color(0xFF1877F2),
                        logo: Iconsax.activity,
                        service: "Facebook"),
                    ServiceWidget(
                        color: Color(0xFFD82F7F),
                        logo: Iconsax.activity2,
                        service: "Instagram"),
                    ServiceWidget(
                        color: Color(0xFFEA4335),
                        logo: Iconsax.activity3,
                        service: "Google")
                  ],
                )
              ],
            ),
          ))
        ],
      ),
    );
  }
}
