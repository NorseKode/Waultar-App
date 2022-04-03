import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:waultar/presentation/providers/theme_provider.dart';

class TopPanel extends StatefulWidget {
  const TopPanel({Key? key}) : super(key: key);

  @override
  _TopPanelState createState() => _TopPanelState();
}

class _TopPanelState extends State<TopPanel> {
  late ThemeProvider themeProvider;
  var serachController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    themeProvider = Provider.of<ThemeProvider>(context);
    return Container(
      constraints: BoxConstraints(maxHeight: 40),
      color: themeProvider.themeData().scaffoldBackgroundColor,
      child: Row(
        children: [
          _dayDisplay(),
          SizedBox(width: 20),
          _serachBarButton(),
          SizedBox(width: 20),
          _profileBar(),
        ],
      ),
    );
  }

  Widget _dayDisplay() {
    return Expanded(
        flex: 1,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("Today",
                style: TextStyle(
                    fontSize: 9,
                    color: Colors.grey,
                    fontWeight: FontWeight.w400)),
            Text(
              "${DateFormat('EE, MMM d. yyy').format(DateTime.now())}",
              style: TextStyle(fontSize: 12, fontWeight: FontWeight.w400),
            )
          ],
        ));
  }

  Widget _serachBarButton() {
    return Expanded(
      flex: 4,
      child: Container(
        alignment: Alignment.centerLeft,
        decoration: BoxDecoration(
            color: themeProvider.themeData().primaryColor,
            borderRadius: const BorderRadius.all(Radius.circular(10))),
        child: TextField(
          controller: serachController,
          readOnly: true,
          onTap: () {
            _showserachDialog();
          },
          decoration: InputDecoration(
              contentPadding: EdgeInsets.only(left: 15),
              border: const OutlineInputBorder(
                  borderSide: BorderSide.none,
                  borderRadius: BorderRadius.all(Radius.circular(10))),
              fillColor: themeProvider.themeData().primaryColor,
              filled: true,
              hintText: "serach ..."),
          style: TextStyle(
            color: themeProvider.themeMode().tonedTextColor,
            fontSize: 12,
          ),
        ),
      ),
    );
  }

  Widget _profileBar() {
    return Expanded(
      flex: 2,
      child: Row(
        children: [
          Container(
              width: 30,
              height: 30,
              decoration: BoxDecoration(
                  color: themeProvider.themeMode().themeColor,
                  borderRadius: BorderRadius.circular(5))),
          SizedBox(width: 10),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text("John Doe",
                  style: TextStyle(fontSize: 12, fontWeight: FontWeight.w400)),
              Text("john.doe@gmail.com", style: TextStyle(fontSize: 9)),
            ],
          )
        ],
      ),
    );
  }

  void _showserachDialog() {
    showDialog(
        barrierDismissible: true,
        context: context,
        builder: (context) {
          return Row(children: [
            SizedBox(
              width: 250,
            ),
            Expanded(
              child: Container(
                padding: EdgeInsets.all(20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(children: [
                      Expanded(flex: 1, child: Container()),
                      SizedBox(width: 20),
                      Expanded(
                        flex: 4,
                        child: Container(
                          constraints: BoxConstraints(maxHeight: 500
                              //MediaQuery.of(context).size.height - 100
                              ),
                          child: Scaffold(
                            backgroundColor: Colors.transparent,
                            body: Column(
                              children: [
                                Container(
                                  constraints: BoxConstraints(maxHeight: 40),
                                  child: TextField(
                                    controller: serachController,
                                    autofocus: true,
                                    decoration: InputDecoration(
                                        contentPadding:
                                            EdgeInsets.only(left: 15),
                                        border: const OutlineInputBorder(
                                            borderSide: BorderSide.none,
                                            borderRadius: BorderRadius.only(
                                                topLeft: Radius.circular(10),
                                                topRight: Radius.circular(10))),
                                        fillColor: themeProvider
                                            .themeData()
                                            .primaryColor,
                                        filled: true,
                                        hintText: "serach ..."),
                                    style: TextStyle(
                                      fontWeight: FontWeight.w400,
                                      color: serachController.text.isEmpty
                                          ? themeProvider
                                              .themeMode()
                                              .tonedTextColor
                                          : Colors.white,
                                      fontSize: 12,
                                    ),
                                  ),
                                ),
                                Expanded(
                                  child: Container(
                                    decoration: BoxDecoration(
                                        color: themeProvider
                                            .themeData()
                                            .primaryColor,
                                        borderRadius: const BorderRadius.only(
                                            bottomLeft: Radius.circular(10),
                                            bottomRight: Radius.circular(10))),
                                    padding: const EdgeInsets.fromLTRB(
                                        15, 0, 15, 15),
                                    child: Column(
                                      mainAxisSize: MainAxisSize.min,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        _categorySerachList(),
                                        _serachResults(),
                                      ],
                                    ),
                                  ),
                                )
                              ],
                            ),
                          ),
                        ),
                      ),
                      SizedBox(width: 20),
                      Expanded(flex: 2, child: Container())
                    ]),
                  ],
                ),
              ),
            )
          ]);
        });
  }

  Widget _categorySerachList() {
    return Expanded(
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: List.generate(
              12,
              (index) => Padding(
                    padding: const EdgeInsets.only(right: 10.0),
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                          vertical: 4, horizontal: 10),
                      decoration: BoxDecoration(
                          color: Color(0xFF323346),
                          borderRadius: BorderRadius.circular(5)),
                      child: Row(
                        children: [
                          Icon(Iconsax.document,
                              size: 12,
                              color: themeProvider.themeMode().tonedTextColor),
                          const SizedBox(
                            width: 5,
                          ),
                          Text(
                            "hello",
                            style:
                                themeProvider.themeData().textTheme.headline4,
                          )
                        ],
                      ),
                    ),
                  )),
        ),
      ),
    );
  }

  Widget _serachResults() {
    return Container();
  }
}
