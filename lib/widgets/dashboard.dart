import 'package:flutter/material.dart';

class Dashboard extends StatefulWidget {
  const Dashboard({Key? key}) : super(key: key);

  @override
  _DashboardState createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Padding(
        padding:
            const EdgeInsets.only(left: 20.0, bottom: 20, right: 20, top: 0),
        child: SingleChildScrollView(
            child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
                color: Color(0xFF1A1D1F),
                width: MediaQuery.of(context).size.width - 125,
                height: 200),
            SizedBox(height: 20),
            Container(
                color: Color(0xFF1A1D1F),
                width: MediaQuery.of(context).size.width - 125,
                height: 200),
            SizedBox(height: 20),
            Container(
                color: Color(0xFF1A1D1F),
                width: MediaQuery.of(context).size.width - 125,
                height: 200),
          ],
        )),
      ),
    );
  }
}

// SingleChildScrollView(
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               title(),
//               Container(color: Color(0xFF111111), width: 1000, height: 200),
//               Container(color: Color(0xFF1B1E1F), width: 1000, height: 200),
//               Container(color: Color(0xFFFFFFFF), width: 1000, height: 200)
//             ],
//           ),
//         ),
//       ),