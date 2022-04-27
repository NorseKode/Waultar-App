import 'dart:io';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:tuple/tuple.dart';
import 'package:waultar/core/abstracts/abstract_repositories/i_service_repository.dart';
import 'package:waultar/core/abstracts/abstract_services/i_dashboard_service.dart';
import 'package:waultar/core/abstracts/abstract_services/i_sentiment_service.dart';
import 'package:waultar/data/entities/misc/profile_document.dart';
import 'package:waultar/domain/services/dashboard_service.dart';
import 'package:waultar/presentation/providers/theme_provider.dart';
import 'package:waultar/presentation/widgets/general/default_widgets/default_button.dart';

import 'package:waultar/presentation/widgets/machine_models/sentiment_widget.dart';
import 'package:waultar/presentation/widgets/general/default_widgets/default_widget.dart';
import 'package:waultar/presentation/widgets/general/default_widgets/default_widget_box.dart';
import 'package:waultar/presentation/widgets/dashboard/service_widget.dart';

import 'package:waultar/presentation/widgets/machine_models/image_classify_widget.dart';

import 'package:waultar/startup.dart';

class Dashboard extends StatefulWidget {
  const Dashboard({Key? key}) : super(key: key);

  @override
  _DashboardState createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  final _dashboardService = locator.get<IDashboardService>(
    instanceName: 'dashboardService',
  );
  final sentimentService =
      locator.get<ISentimentService>(instanceName: 'sentimentService');
  late AppLocalizations localizer;
  late ThemeProvider themeProvider;
  late List<ProfileDocument> profiles;
  late List<Tuple2<String, double>> weekdays =
      _dashboardService.getActiveWeekday();
  late var mostActive;
  var testText = TextEditingController();
  double testScore = -1;

  @override
  Widget build(BuildContext context) {
    localizer = AppLocalizations.of(context)!;
    themeProvider = Provider.of<ThemeProvider>(context);
    profiles = _dashboardService.getAllProfiles();
    weekdays = _dashboardService.getActiveWeekday();
    if (profiles.isNotEmpty) {
      mostActive = weekdays.reduce(
          (value, element) => value.item2 <= element.item2 ? element : value);
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          localizer.dashboard,
          style: themeProvider.themeData().textTheme.headline3,
        ),
        const SizedBox(height: 20),
        Expanded(
          child: profiles.isNotEmpty
              ? SingleChildScrollView(child: _dashboardWidgets())
              : Text(
                  "Upload data to use dashboard",
                  style: themeProvider.themeData().textTheme.headline4,
                ),
        )
      ],
    );
  }

  Widget _dashboardWidgets() {
    return Column(
      children: [
        Row(children: [Expanded(child: _services())]),
        const SizedBox(height: 20),
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
                child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Overview",
                  style: themeProvider.themeData().textTheme.headline4,
                ),
                const SizedBox(height: 15),
                IntrinsicHeight(
                    child: Row(
                  children: [
                    Expanded(child: _datapointGraph()),
                    SizedBox(width: 20),
                    SizedBox(height: 300, width: 300, child: _serviceGraph())
                  ],
                )),
                const SizedBox(height: 20),
                IntrinsicHeight(
                  child: Row(
                    children: [
                      Container(
                        color: Colors.orange,
                        height: 100,
                        width: 100,
                      ),
                      const SizedBox(width: 20),
                      Container(
                        color: Colors.orange,
                        width: 200,
                      ),
                      const SizedBox(width: 20),
                      Expanded(child: Container(color: Colors.purple))
                    ],
                  ),
                ),
                const SizedBox(height: 20),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                        child: Container(height: 200, color: Colors.orange)),
                    const SizedBox(width: 20),
                    Expanded(
                        child: Container(height: 400, color: Colors.purple))
                  ],
                )
              ],
            )),
            const SizedBox(width: 20),
            Container(
              // decoration: BoxDecoration(
              //   borderRadius: BorderRadius.circular(10),
              //   color: themeProvider.themeData().primaryColor,
              // ),
              width: 400,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Analysis",
                    style: themeProvider.themeData().textTheme.headline4,
                  ),
                  const SizedBox(height: 15),
                  ImageClassifyWidget(),
                  // Divider(
                  //   height: 15,
                  //   indent: 20,
                  //   endIndent: 20,
                  // ),
                  const SizedBox(height: 20),
                  _sentimentTestWidget(),
                  // Divider(
                  //   height: 15,
                  //   indent: 20,
                  //   endIndent: 20,
                  // ),
                  const SizedBox(height: 20),
                  SentimentWidget()
                ],
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _services() {
    List<Widget> serviceWidgets = List.generate(
        profiles.length, (e) => ServiceWidget(service: profiles[e]));

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Services",
          style: themeProvider.themeData().textTheme.headline4,
        ),
        const SizedBox(height: 15),
        Wrap(
          runSpacing: 20,
          spacing: 20,
          children: List.generate(
            serviceWidgets.length,
            (index) => serviceWidgets[index],
          ),
        ),
      ],
    );
  }

  Widget _serviceGraph() {
    return DefaultWidget(
        title: "Service Distribution",
        child: Expanded(
          child: Column(
            children: [
              SizedBox(height: 5),
              Expanded(
                child: Container(
                  constraints: BoxConstraints(minWidth: 300),
                  decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: Border.all(width: 20, color: Colors.yellow)),
                ),
              ),
            ],
          ),
        ));
  }

  Widget _datapointGraph() {
    return DefaultWidget(
      title: "Last week",
      child: Text("TODO"),
    );
  }

  // Widget _dashboardWidgets() {
  //   return Row(
  //     crossAxisAlignment: CrossAxisAlignment.start,
  //     children: [
  //       Expanded(
  //         flex: 2,
  //         child: Column(
  //           crossAxisAlignment: CrossAxisAlignment.start,
  //           children: [
  //             _services(),
  //             const SizedBox(height: 20),
  //             Text(
  //               "Highlights",
  //               style: themeProvider.themeData().textTheme.headline4,
  //             ),
  //             const SizedBox(height: 15),
  //             _highlightBar(),
  //             const SizedBox(height: 20),
  //             IntrinsicHeight(
  //               child: Row(
  //                 crossAxisAlignment: CrossAxisAlignment.stretch,
  //                 children: [
  //                   Expanded(child: _topMessageWidget()),
  //                   const SizedBox(width: 20),
  //                   Expanded(
  //                     child: Column(
  //                       children: [
  //                         _diagram1(),
  //                         const SizedBox(height: 20),
  //                         _diagram2()
  //                       ],
  //                     ),
  //                   )
  //                 ],
  //               ),
  //             )
  //           ],
  //         ),
  //       ),
  //       const SizedBox(width: 20),
  //       Container(
  //           constraints: BoxConstraints(maxWidth: 330), child: _analysis()),
  //     ],
  //   );
  // }

  // Widget _services() {
  //   List<Widget> serviceWidgets = List.generate(
  //       profiles.length, (e) => ServiceWidget(service: profiles[e]));

  //   return Column(
  //     crossAxisAlignment: CrossAxisAlignment.stretch,
  //     children: [
  //       Text(
  //         "Services",
  //         style: themeProvider.themeData().textTheme.headline4,
  //       ),
  //       const SizedBox(height: 15),
  //       Wrap(
  //         runSpacing: 20,
  //         spacing: 20,
  //         children: List.generate(
  //           serviceWidgets.length,
  //           (index) => serviceWidgets[index],
  //         ),
  //       ),
  //     ],
  //   );
  // }

  // Widget _analysis() {
  //   return Column(
  //     crossAxisAlignment: CrossAxisAlignment.start,
  //     children: [
  //       Text(
  //         "Data Analysis",
  //         style: themeProvider.themeData().textTheme.headline4,
  //       ),
  //       const SizedBox(height: 15),
  //       ImageClassifyWidget(),
  //       const SizedBox(height: 20),
  //       SentimentWidget(),
  //       const SizedBox(height: 20),
  //       _sentimentTestWidget(),
  //     ],
  //   );
  // }

  // Widget _highlightBar() {
  //   return Container(
  //     constraints: BoxConstraints(maxHeight: 70),
  //     child: Row(
  //       children: [
  //         // _highlightWidget(Iconsax.activity5, Colors.amber, "Most Active Year",
  //         //     "${_dashboardService.getMostActiveYear()}", Container()),
  //         // SizedBox(
  //         //   width: 20,
  //         // ),
  //         _highlightWidget(Iconsax.activity5, const Color(0xFF323346),
  //             "Most Active Weekday", "${mostActive.item1}", Container()),
  //         SizedBox(
  //           width: 20,
  //         ),
  //         Expanded(
  //           child: _highlightWidget(
  //               Iconsax.activity5,
  //               const Color(0xFF323346),
  //               "Last Post",
  //               "${DateFormat.yMMMd().format(DateTime.now())}",
  //               Container()),
  //         ),
  //       ],
  //     ),
  //   );
  // }

  // Widget _highlightWidget(
  //     IconData icon, Color color, String title, String result, Widget child) {
  //   return DefaultWidgetBox(
  //     padding: EdgeInsets.all(15),
  //     child: Row(
  //       children: [
  //         Container(
  //           width: 40,
  //           height: 40,
  //           decoration: BoxDecoration(
  //               color: color, //const Color(0xFF323346),
  //               borderRadius: BorderRadius.circular(5)),
  //           child: Icon(
  //             icon,
  //             color: color,
  //           ),
  //         ),
  //         SizedBox(width: 10),
  //         Column(
  //           crossAxisAlignment: CrossAxisAlignment.start,
  //           mainAxisAlignment: MainAxisAlignment.spaceBetween,
  //           children: [
  //             Text(
  //               title,
  //               style: const TextStyle(
  //                   color: Color(0xFFABAAB8),
  //                   fontSize: 10,
  //                   fontWeight: FontWeight.w400),
  //             ),
  //             Text(
  //               result,
  //               style: TextStyle(fontSize: 16, fontWeight: FontWeight.w400),
  //             )
  //           ],
  //         ),
  //         SizedBox(width: 10),
  //         child
  //       ],
  //     ),
  //   );
  // }

  // Widget _topMessageWidget() {
  //   int top = 10;
  //   var sortedMessages = _dashboardService.getSortedMessageCount(top);
  //   List<Widget> topMessageList = List.generate(
  //       sortedMessages.length,
  //       (index) => Padding(
  //             padding: EdgeInsets.only(top: 15),
  //             child: Container(
  //                 child: Row(
  //               children: [
  //                 Expanded(
  //                   flex: 3,
  //                   child: Row(
  //                     children: [
  //                       Container(
  //                         height: 20,
  //                         width: 20,
  //                         decoration: BoxDecoration(
  //                             shape: BoxShape.circle,
  //                             border: Border.all(color: Colors.white)),
  //                         child: Center(child: Text("${index + 1}")),
  //                       ),
  //                       SizedBox(
  //                         width: 10,
  //                       ),
  //                       Text(sortedMessages[index].item1,
  //                           overflow: TextOverflow.ellipsis,
  //                           softWrap: false,
  //                           style: themeProvider
  //                               .themeData()
  //                               .textTheme
  //                               .headline4!
  //                               .apply(
  //                                   color: Colors.white, fontSizeDelta: 0.5)),
  //                     ],
  //                   ),
  //                 ),
  //                 Expanded(
  //                   child: Text(
  //                     sortedMessages[index].item2.toString(),
  //                     textAlign: TextAlign.right,
  //                     style: themeProvider
  //                         .themeData()
  //                         .textTheme
  //                         .headline4!
  //                         .apply(color: Colors.white, fontSizeDelta: 0.5),
  //                   ),
  //                 )
  //               ],
  //             )),
  //           ));
  //   topMessageList.insert(
  //       0,
  //       Row(
  //         children: [
  //           Expanded(
  //               flex: 3,
  //               child: Text(
  //                 "Contact",
  //                 style: themeProvider.themeData().textTheme.headline4,
  //               )),
  //           Expanded(
  //               child: Text("Messages",
  //                   textAlign: TextAlign.right,
  //                   style: themeProvider.themeData().textTheme.headline4))
  //         ],
  //       ));

  //   return DefaultWidget(
  //       title: "Top Message Count",
  //       child: Expanded(
  //         child: Column(
  //           children: topMessageList,
  //         ),
  //       ));
  // }

  // Widget _diagram1() {
  //   return Expanded(
  //       child: DefaultWidget(
  //     title: "Weekly Activity",
  //     child: Expanded(
  //         child: Container(
  //             height: 100,
  //             child: Row(
  //                 children: List.generate(
  //                     weekdays.length,
  //                     (index) => Expanded(
  //                           child: Column(
  //                             children: [
  //                               Expanded(
  //                                 flex: (100 -
  //                                         (weekdays[index].item2 /
  //                                             (mostActive.item2 * 1.5) *
  //                                             100))
  //                                     .floor(),
  //                                 child: Container(
  //                                   color: Colors.transparent,
  //                                 ),
  //                               ),
  //                               Expanded(
  //                                 flex: (weekdays[index].item2 /
  //                                         (mostActive.item2 * 1.5) *
  //                                         100)
  //                                     .ceil(),
  //                                 child: Container(
  //                                   width: 10,
  //                                   color: themeProvider.themeMode().themeColor,
  //                                 ),
  //                               ),
  //                             ],
  //                           ),
  //                         ))))),
  //   ));
  // }

  // Widget _diagram2() {
  //   return Expanded(
  //     child: DefaultWidget(
  //         title: "Data overview",
  //         child: Expanded(
  //           child: Container(),
  //         )),
  //   );
  // }

  Widget _sentimentTestWidget() {
    return DefaultWidget(
        title: "Sentiment Test",
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("Input text to test sentiment"),
            SizedBox(height: 10),
            Container(
              height: 40,
              child: TextFormField(
                  style: TextStyle(fontSize: 12),
                  cursorWidth: 1,
                  keyboardType: TextInputType.number,
                  controller: testText,
                  decoration: InputDecoration(
                    contentPadding: EdgeInsets.only(left: 15),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(5.0),
                      borderSide: BorderSide.none,
                    ),
                    filled: true,
                    fillColor: (const Color(0xFF323346)),
                    hintText: "Enter a sentence ...",
                    hintStyle: TextStyle(letterSpacing: 0.3),
                  )),
            ),
            SizedBox(height: 10),
            Row(
              children: [
                Expanded(
                  child: DefaultButton(
                    text: "Analyze",
                    onPressed: () {
                      testScore = sentimentService.connotateText(testText.text);
                      setState(() {});
                    },
                  ),
                ),
              ],
            ),
            SizedBox(height: 20),
            Text("Sentiment Score: $testScore"),
          ],
        ));
  }
}
