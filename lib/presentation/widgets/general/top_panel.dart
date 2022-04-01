import 'package:flutter/material.dart';
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
  var searchController = TextEditingController();

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
          _searchBarButton(),
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
            Text("${DateFormat('EE, MMM d. yyy').format(DateTime.now())}",
                style: TextStyle(fontSize: 12, fontWeight: FontWeight.w400))
          ],
        ));
  }

  Widget _searchBarButton() {
    return Expanded(
      flex: 4,
      child: Container(
        alignment: Alignment.centerLeft,
        padding: EdgeInsets.only(left: 15),
        decoration: BoxDecoration(
            color: Color(0xFF272837),
            borderRadius: BorderRadius.all(Radius.circular(10))),
        child: TextButton(
          onPressed: () {
            _showSearchDialog();
          },
          child: Text(
            searchController.text.isEmpty
                ? "search ..."
                : searchController.text,
            style: TextStyle(
                color:
                    searchController.text.isEmpty ? Colors.grey : Colors.white,
                fontSize: 12,
                fontWeight: FontWeight.w200),
          ),
        ),
      ),
    );
  }

  void _showSearchDialog() {
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
                          constraints: BoxConstraints(maxHeight: 500),
                          child: Scaffold(
                            backgroundColor: Colors.transparent,
                            body: Column(
                              children: [
                                Container(
                                  constraints: BoxConstraints(maxHeight: 40),
                                  alignment: Alignment.centerLeft,
                                  child: TextField(
                                    autofocus: true,
                                    decoration: const InputDecoration(
                                        border: OutlineInputBorder(
                                            borderSide: BorderSide.none,
                                            borderRadius: BorderRadius.all(
                                                Radius.circular(10))),
                                        fillColor: Color(0xFF272837),
                                        filled: true,
                                        hintText: "search ..."),
                                    style: TextStyle(
                                        color: searchController.text.isEmpty
                                            ? Colors.grey
                                            : Colors.white,
                                        fontSize: 12,
                                        fontWeight: FontWeight.w200),
                                  ),
                                ),
                                Expanded(
                                  child: Container(color: Colors.red),
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

  Widget _searchBar() {
    return Expanded(
        flex: 4,
        child: Container(
          constraints: BoxConstraints(maxHeight: 40),
          child: TextField(
            cursorWidth: 1.0,
            style: const TextStyle(
                color: Colors.white, fontSize: 12, fontWeight: FontWeight.w200),
            controller: searchController,
            decoration: const InputDecoration(
              contentPadding: EdgeInsets.only(left: 15),
              fillColor: Color(0xFF272837),
              filled: true,
              border: OutlineInputBorder(
                  borderSide: BorderSide.none,
                  borderRadius: BorderRadius.all(Radius.circular(10))),
              hintText: 'search ...',
            ),
          ),
        ));
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
}
