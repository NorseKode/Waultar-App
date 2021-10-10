// ignore_for_file: prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:waultar/widgets/darkmode_switch.dart';

class SignUp extends StatefulWidget {
  const SignUp({Key? key}) : super(key: key);

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
          Row(mainAxisAlignment: MainAxisAlignment.center, children: [
            DarkModeSwitch(),
          ])
        ]),
      ),
    );
  }
}

// child: Column(
//   mainAxisAlignment: MainAxisAlignment.center,
//   children: <Widget>[
//     Row(),
//     const Text(
//       'Waultar',
//     ),
//     Row(
//       children: [
//         Column(
//           children: [
//             Text("Control your data your way"),
//             Row(),
//             Row(),
//             Row(),
//             Row(),
//           ],
//         ),
//         Container()
//       ],
//     )
//   ],
// ),
