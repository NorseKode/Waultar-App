import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:waultar/presentation/providers/theme_provider.dart';
import 'package:waultar/presentation/widgets/search/searchbar_button.dart';
import 'package:waultar/presentation/widgets/snackbar_custom.dart';
import 'package:waultar/presentation/widgets/upload/uploader.dart';

class TopPanel extends StatefulWidget {
  const TopPanel({Key? key}) : super(key: key);

  @override
  _TopPanelState createState() => _TopPanelState();
}

class _TopPanelState extends State<TopPanel> {
  late ThemeProvider themeProvider;
  var serachController = TextEditingController();
  var isLoading = false;

  @override
  Widget build(BuildContext context) {
    themeProvider = Provider.of<ThemeProvider>(context);
    return Container(
      constraints: const BoxConstraints(maxHeight: 40),
      color: themeProvider.themeData().scaffoldBackgroundColor,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Container(
            width: 150,
            child: _dayDisplay(),
          ),
          const SizedBox(width: 20),
          Row(
            children: [
              const SearchBarButton(),
              const SizedBox(width: 20),
              Container(width: 200, child: _profileBar()),
            ],
          )
        ],
      ),
    );
  }

  Widget _dayDisplay() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text("Today",
            style: TextStyle(
                fontSize: 9, color: Colors.grey, fontWeight: FontWeight.w400)),
        Text(
          DateFormat('EE, MMM d. yyy').format(DateTime.now()),
          style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w400),
        )
      ],
    );
  }

  Widget _profileBar() {
    return Container(
      child: Row(children: [
        Container(
            width: 30,
            height: 30,
            decoration: BoxDecoration(
                color: themeProvider.themeMode().themeColor,
                borderRadius: BorderRadius.circular(5))),
        const SizedBox(width: 10),
        Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: const [
            Text("John Doe",
                style: TextStyle(fontSize: 12, fontWeight: FontWeight.w400)),
            Text("john.doe@gmail.com", style: TextStyle(fontSize: 9)),
          ],
        )
      ]),
    );
  }
}
