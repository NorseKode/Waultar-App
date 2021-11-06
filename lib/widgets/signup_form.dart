import 'package:flutter/material.dart';
import 'package:waultar/etebase/authentication.dart';
import 'package:waultar/etebase/models/etebase_user.dart';
import 'package:waultar/exceptions/etebase_exceptions.dart';
import 'package:waultar/navigation/app_state.dart';
import 'package:waultar/navigation/screen.dart';
import 'package:waultar/widgets/snackbar_custom.dart';

class SignUpForm extends StatefulWidget {
  final AppState _appState;
  final ValueChanged<AppState> _updateAppState;
  final bool _isSignIn;
  
  SignUpForm(this._appState, this._updateAppState, this._isSignIn, {Key? key}) : super(key: key);

  @override
  State<SignUpForm> createState() => _SignUpForm(_appState, _updateAppState, this._isSignIn);
}

class _SignUpForm extends State<SignUpForm> {
  AppState _appState;
  ValueChanged<AppState> _updateAppState;
  final bool _isSignIn;
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  _SignUpForm(this._appState, this._updateAppState, this._isSignIn);

  void _saveForm() async {
    final bool isValid = _formKey.currentState!.validate();
    if (isValid) {
      var tempEtebaseUser = EtebaseUser(_usernameController.text.trim(), _emailController.text.trim());
      
      try {
        var temp = await signUp(tempEtebaseUser, _passwordController.text.trim());
        _appState.user = temp;
        _appState.viewScreen = ViewScreen.home;
        _updateAppState(_appState);
      } on EtebaseExceptions catch (e) {
        SnackBarCustom.useSnackbarOfContext(context, e.message);
        setState(() {
          _passwordController.clear();
        });
      }
    }
  }

  TextStyle textStyle =
      const TextStyle(height: 1, letterSpacing: 0.5, fontSize: 14);

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Expanded(
        child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                  padding: EdgeInsets.fromLTRB(0, 0, 0, 12.0),
                  child: Text(_isSignIn ? 'Sign In' : "Register",
                      textAlign: TextAlign.left,
                      style: TextStyle(
                          fontSize: 20, fontWeight: FontWeight.bold))),
              Text("Your Name", style: textStyle),
              Padding(
                padding: EdgeInsets.fromLTRB(0, 8.0, 0, 12.0),
                child: TextField(
                    style: textStyle,
                    controller: _usernameController,
                    decoration: const InputDecoration(
                        hintText: 'John Doe', border: OutlineInputBorder())),
              ),
              Text("Your Email", style: textStyle),
              Padding(
                padding: EdgeInsets.fromLTRB(0, 8.0, 0, 12.0),
                child: TextField(
                    style: textStyle,
                    controller: _emailController,
                    decoration: const InputDecoration(
                        hintText: 'john@email.com',
                        border: OutlineInputBorder())),
              ),
              Text("Password", style: textStyle),
              Padding(
                padding: EdgeInsets.fromLTRB(0, 8.0, 0, 12.0),
                child: TextField(
                    style: textStyle,
                    controller: _passwordController,
                    decoration: const InputDecoration(
                        hintText: 'at least 8 characters',
                        border: OutlineInputBorder())),
              ),
              Row(
                children: [
                  const Checkbox(value: false, onChanged: null),
                  Text("I agree to the ", style: textStyle),
                  const Text("Terms & Conditions",
                      style: TextStyle(
                          letterSpacing: 0.5,
                          fontSize: 14,
                          color: Colors.orange))
                ],
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(0, 12.0, 0, 12.0),
                child: Row(children: [
                  Expanded(
                      flex: 1,
                      child: Container(
                          padding: const EdgeInsets.only(top: 5.0, bottom: 5.0),
                          decoration: BoxDecoration(
                            color: Colors.orange,
                            borderRadius: BorderRadius.circular(5.0),
                          ),
                          child: TextButton(
                              onPressed: _saveForm,
                              child: const Text(
                                "Get Started",
                                style: TextStyle(
                                    height: 1.5,
                                    letterSpacing: 0.5,
                                    fontSize: 14,
                                    color: Colors.white),
                              ))))
                ]),
              )
            ]),
      ),
    );
  }
}


        // TextFormField(
        //   validator: (value) {
        //     if (value!.trim().length < 3) {
        //       return 'This field requires a minimum of 3 characters';
        //     }
        //     return null;
        //   },
        //   decoration: const InputDecoration(
        //       labelText: 'Your Name',
        //       hintText: 'Steve Jobs',
        //       border: OutlineInputBorder(),
        //       errorBorder: OutlineInputBorder(
        //           borderSide: BorderSide(
        //               color: Color.fromARGB(255, 239, 83, 80), width: 5))),
        // ),
        // TextFormField(
        //   validator: (value) {
        //     if (!value!.contains("@") || !value.contains(".")) {
        //       return 'This is not an email';
        //     }
        //     return null;
        //   },
        //   decoration: const InputDecoration(
        //       labelText: 'Your Email',
        //       hintText: 'steve_jobs@email.com',
        //       border: OutlineInputBorder(),
        //       errorBorder: OutlineInputBorder(
        //           borderSide: BorderSide(
        //               color: Color.fromARGB(255, 239, 83, 80), width: 5))),
        // ),
        // TextFormField(
        //   validator: (value) {
        //     if (value!.length < 8) {
        //       return 'Password should be at least 8 characters';
        //     }
        //     return null;
        //   },
        //   decoration: const InputDecoration(
        //       labelText: 'Password',
        //       hintText: 'at least 8 characters',
        //       border: OutlineInputBorder(),
        //       errorBorder: OutlineInputBorder(
        //           borderSide: BorderSide(
        //               color: Color.fromARGB(255, 239, 83, 80), width: 5))),
        // ),