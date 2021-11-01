import 'package:flutter/material.dart';
import 'package:waultar/etebase/authentication.dart';
import 'package:waultar/globals/scaffold_main.dart';
import 'package:waultar/navigation/app_state.dart';
import 'package:waultar/navigation/screen.dart';
import 'package:fluttericon/iconic_icons.dart';
import 'package:waultar/widgets/logo.dart';
import 'package:waultar/widgets/signup_form.dart';

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
        _appState.user = 'something';
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
    String pawIcon = 'lib/assets/graphics/Paw.svg';
    double width = MediaQuery.of(context).size.width;
    return Scaffold(
        backgroundColor: const Color.fromARGB(255, 24, 35, 39),
        body: Padding(
            padding: EdgeInsets.fromLTRB(80, 50, 80, 50),
            child: Row(
              children: [
                Expanded(
                    flex: 2,
                    child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisSize: MainAxisSize.max,
                        children: const [
                          Text("Welcome to Waultar",
                              textAlign: TextAlign.left,
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 32,
                                  fontWeight: FontWeight.bold)),
                          Text(
                              "A new private and personal data repository for individuals. From you Waultar dashboard, you can get an overview of all the personal data you have provided to different services you use (Facebook, eBay, VISA, etc.). \n\nVia Waultar, you can invoke your GDPR rights and be in full control of your personal data - Waultar will handle the logic and communication with the third-party services, such that you can safely redeem your GDPR rights without having to undergo complicated processes.",
                              style: TextStyle(
                                  height: 2,
                                  letterSpacing: 0.5,
                                  color: Color.fromARGB(255, 198, 201, 202),
                                  fontSize: 12)),
                          Divider(
                            thickness: 1,
                            color: Color.fromARGB(255, 198, 201, 202),
                          ),
                          ListTile(
                            title: Text('Zero Knowledgement Ecryption',
                                style: TextStyle(
                                  fontSize: 14,
                                  color: Color.fromARGB(255, 198, 201, 202),
                                )),
                            leading: Icon(
                              Icons.security,
                              color: Colors.orange,
                            ),
                          ),
                          ListTile(
                            title: Text('GDPR rights enforcer',
                                style: TextStyle(
                                  fontSize: 14,
                                  color: Color.fromARGB(255, 198, 201, 202),
                                )),
                            leading: Icon(
                              Icons.security,
                              color: Colors.orange,
                            ),
                          ),
                          ListTile(
                            title: Text('Data management',
                                style: TextStyle(
                                  fontSize: 14,
                                  color: Color.fromARGB(255, 198, 201, 202),
                                )),
                            leading: Icon(
                              Icons.security,
                              color: Colors.orange,
                            ),
                          ),
                        ])),
                Expanded(flex: 1, child: Container()),
                Expanded(
                    flex: 2,
                    child: Container(
                        decoration: const BoxDecoration(
                            color: Colors.white,
                            borderRadius:
                                BorderRadius.all(Radius.circular(10))),
                        child: Padding(
                            padding: const EdgeInsets.all(35.0),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [SignUpForm()],
                            ))))
              ],
            )));
  }
}

                        // Padding(
                        //     padding: const EdgeInsets.only(bottom: 30.0),
                        //     child: Row(children: [
                        //       CustomPaint(
                        //         size: Size(
                        //             40, (40 * 0.9016393442622951).toDouble()),
                        //         painter: PawPainter(Colors.blue),
                        //       ),
                        //       const SizedBox(width: 15),
                        //       const Text("Waultar",
                        //           style: TextStyle(
                        //               fontSize: 18,
                        //               fontWeight: FontWeight.bold))
                        //     ])),