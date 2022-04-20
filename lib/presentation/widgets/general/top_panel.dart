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
        children: [
          _dayDisplay(),
          const SizedBox(width: 20),
          const SearchBarButton(),
          const SizedBox(width: 20),
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
            const Text("Today",
                style: TextStyle(
                    fontSize: 9,
                    color: Colors.grey,
                    fontWeight: FontWeight.w400)),
            Text(
              DateFormat('EE, MMM d. yyy').format(DateTime.now()),
              style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w400),
            )
          ],
        ));
  }

  Widget _profileBar() {
    return Expanded(
      flex: 2,
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
