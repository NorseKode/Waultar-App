import 'dart:io';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:image/image.dart' as img;
import 'package:path/path.dart' as path_dart;
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:waultar/core/abstracts/abstract_repositories/i_service_repository.dart';
import 'package:waultar/core/ai/image_classifier.dart';
import 'package:waultar/presentation/providers/theme_provider.dart';
import 'package:waultar/core/ai/classifier.dart';

import 'package:waultar/presentation/widgets/general/default_widgets/service_widget.dart';
import 'package:waultar/presentation/widgets/general/util_widgets/default_button.dart';

import 'package:waultar/startup.dart';

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
    final services = _serviceRepo.getAll();
    localizer = AppLocalizations.of(context)!;
    themeProvider = Provider.of<ThemeProvider>(context);

    List<Widget> serviceWidgets =
        List.generate(services.length, (e) => ServiceWidget(service: services[e]));

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          localizer.dashboard,
          style: themeProvider.themeData().textTheme.headline3,
        ),
        const SizedBox(height: 20),
        Expanded(
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SingleChildScrollView(
                    //service widgets

                    scrollDirection: Axis.horizontal,
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: List.generate(
                          serviceWidgets.length,
                          (index) => Padding(
                                padding: const EdgeInsets.only(right: 20),
                                child: serviceWidgets[index],
                              )),
                    )),
                const SizedBox(height: 20),
                Text(localizer.yourSocialDataOverview), //dashboard widgets
                const SizedBox(height: 20),
                DefaultButton(onPressed: () async {
                  var cls = ClassifierFloat();
                  await cls.loadModel();
                  await cls.loadLabels();
                  var image = img.decodeImage(File(
                    path_dart.normalize(
                      path_dart.join(path_dart.dirname(Platform.script.path), "lib", "assets",
                          "graphics", "family dinner.jpg"),
                    ).substring(1),
                  ).readAsBytesSync());

                  for (var pre in cls.predict(image!)) {
                    print(pre);
                  }
                }),
                // DefaultButton(text: "Press me! Please do", onPressed: () {}, color: Colors.blue),
                // DefaultButton(
                //   icon: Iconsax.add,
                //   onPressed: () {},
                //   size: 32,
                //   textColor: Colors.black,
                // ),
                // DefaultButton(text: "Add", icon: Iconsax.woman, onPressed: () {}, size: 15)
              ],
            ),
          ),
        )
      ],
    );
  }
}
