import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:waultar/navigation/app_state.dart';
import 'package:waultar/widgets/authentication/signin_widget.dart';

class SignInView extends StatefulWidget {
  @override
  _SignInViewState createState() =>
      _SignInViewState();
}

class _SignInViewState extends State<SignInView> {
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
            Positioned(
              top: MediaQuery.of(context).size.height * 0.4,
              left: MediaQuery.of(context).size.width * 0.6,
              child: Image.asset(
                'lib/assets/graphics/Paws_blue.png',
                scale: 1.5,
              ),
            ),
            Center(
                child: SingleChildScrollView(
                    child: Center(
              child: SignInWidget(),
            ))),
          ])),
    );
  }
}
