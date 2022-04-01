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
          _searchBar(),
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
