import 'package:flutter/material.dart';
import 'package:waultar/etebase/authentication.dart';
import 'package:waultar/etebase/models/etebase_user.dart';
import 'package:waultar/globals/scaffold_main.dart';
import 'package:waultar/navigation/app_state.dart';
import 'package:waultar/navigation/screen.dart';
import 'package:fluttericon/iconic_icons.dart';
import 'package:waultar/widgets/logo.dart';
import 'package:waultar/widgets/signup_form.dart';
import 'package:waultar/widgets/signup_widget.dart';

class SignInView extends StatefulWidget {
  final AppState _appState;
  final ValueChanged<AppState> _updateAppState;

  SignInView(this._appState, this._updateAppState);

  @override
  _SignInViewState createState() =>
      _SignInViewState(_appState, _updateAppState);
}

class _SignInViewState extends State<SignInView> {
  final AppState _appState;
  final ValueChanged<AppState> _updateAppState;

  _SignInViewState(this._appState, this._updateAppState);

  ElevatedButton _signUpButton() {
    return ElevatedButton(
      onPressed: () {
        _appState.viewScreen = ViewScreen.signup;
        _updateAppState(_appState);
      },
      child: const Text('Sign Up'),
    );
  }

  ElevatedButton _signInButtion() {
    return ElevatedButton(
      onPressed: () async {
        _appState.user = EtebaseUser('', '');
        _appState.viewScreen = ViewScreen.home;
        _updateAppState(_appState);
      },
      child: const Text('Sign In - go to home'),
    );
  }

  String description =
      "Waultar is an application that acts as a private and personal data repository for individuals. From the application, you can get an overview of all the personal data you have provided to different services you use (Facebook, eBay, VISA, etc.). \n \n Via our service, you can invoke your GDPR rights and be in full control of your personal data - Waultar will handle the logic and communication with the third-party services, such that you can safely redeem your GDPR rights without having to undergo complicated processes.";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
          height: MediaQuery.of(context).size.height,
          color: Colors.blue,
          child: Stack(children: [
            const Positioned(
                top: 0,
                left: 0,
                child: Padding(
                  padding: EdgeInsets.all(20.0),
                  child: Text("WAULTAR",
                      style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 24)),
                )),
            Center(
                child: SingleChildScrollView(
                    child: Center(
              child: Stack(clipBehavior: Clip.none, children: [
                Positioned(
                  top: 100,
                  left: 500,
                  child: Image.asset(
                    'lib/assets/graphics/Paws_blue.png',
                    scale: 1.5,
                  ),
                ),
                SignUpWidget(_appState, _updateAppState)
              ]),
            ))),
          ])),
    );
  }
}





// Padding(
//             padding: EdgeInsets.fromLTRB(80, 50, 80, 50),
//             child: Row(
//               children: [
//                 Expanded(
//                     flex: 2,
//                     child: Column(
//                         mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                         crossAxisAlignment: CrossAxisAlignment.start,
//                         mainAxisSize: MainAxisSize.max,
//                         children: const [
//                           Text("Welcome to Waultar",
//                               textAlign: TextAlign.left,
//                               style: TextStyle(
//                                   color: Colors.white,
//                                   fontSize: 32,
//                                   fontWeight: FontWeight.bold)),
//                           Text(
//                               "A new private and personal data repository for individuals. From you Waultar dashboard, you can get an overview of all the personal data you have provided to different services you use (Facebook, eBay, VISA, etc.). \n\nVia Waultar, you can invoke your GDPR rights and be in full control of your personal data - Waultar will handle the logic and communication with the third-party services, such that you can safely redeem your GDPR rights without having to undergo complicated processes.",
//                               style: TextStyle(
//                                   height: 2,
//                                   letterSpacing: 0.5,
//                                   color: Color.fromARGB(255, 198, 201, 202),
//                                   fontSize: 12)),
//                           Divider(
//                             thickness: 1,
//                             color: Color.fromARGB(255, 198, 201, 202),
//                           ),
//                           ListTile(
//                             title: Text('Zero Knowledgement Ecryption',
//                                 style: TextStyle(
//                                   fontSize: 14,
//                                   color: Color.fromARGB(255, 198, 201, 202),
//                                 )),
//                             leading: Icon(
//                               Icons.security,
//                               color: Colors.orange,
//                             ),
//                           ),
//                           ListTile(
//                             title: Text('GDPR rights enforcer',
//                                 style: TextStyle(
//                                   fontSize: 14,
//                                   color: Color.fromARGB(255, 198, 201, 202),
//                                 )),
//                             leading: Icon(
//                               Icons.security,
//                               color: Colors.orange,
//                             ),
//                           ),
//                           ListTile(
//                             title: Text('Data management',
//                                 style: TextStyle(
//                                   fontSize: 14,
//                                   color: Color.fromARGB(255, 198, 201, 202),
//                                 )),
//                             leading: Icon(
//                               Icons.security,
//                               color: Colors.orange,
//                             ),
//                           ),
//                         ])),
//                 Expanded(flex: 1, child: Container()),
//                 Expanded(
//                     flex: 2,
//                     child: Container(
//                         decoration: const BoxDecoration(
//                             color: Colors.white,
//                             borderRadius:
//                                 BorderRadius.all(Radius.circular(10))),
//                         child: Padding(
//                             padding: const EdgeInsets.all(35.0),
//                             child: Column(
//                               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                               crossAxisAlignment: CrossAxisAlignment.start,
//                               children: [SignUpForm(_appState, _updateAppState)],
//                             ))))
//               ],
//             ))