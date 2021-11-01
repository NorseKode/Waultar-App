import 'package:flutter/material.dart';
import 'package:waultar/etebase/authentication.dart';
import 'package:waultar/etebase/models/etebase_user.dart';
import 'package:waultar/globals/globals.dart';
import 'package:waultar/navigation/app_state.dart';
import 'package:waultar/navigation/screen.dart';

class SignUpForm extends StatefulWidget {
  final AppState _appState;
  final ValueChanged<AppState> _updateAppState;
  
  SignUpForm(this._appState, this._updateAppState, {Key? key}) : super(key: key);

  @override
  State<SignUpForm> createState() => _SignUpForm(_appState, _updateAppState);
}

class _SignUpForm extends State<SignUpForm> {
  AppState _appState;
  ValueChanged<AppState> _updateAppState;
  final _formKey = GlobalKey<FormState>();
  late TextEditingController _usernameController;
  late TextEditingController _emailController;
  late TextEditingController _passwordController;

  _SignUpForm(this._appState, this._updateAppState);

  // @override
  // void initState() {
  //   super.initState();
  //   _usernameController = TextEditingController();
  // }

  void _saveForm() async {
    final bool isValid = _formKey.currentState!.validate();
    if (isValid) {
      var tempEtebaseUser = EtebaseUser(_usernameController.text.trim(), _emailController.text.trim());

      var temp = await signUp(tempEtebaseUser, _passwordController.text.trim());
      // var temp = await signIn(tempEtebaseUser.username, _passwordController.text.trim(), serverUrl);

      if (temp != null) {
        _appState.user = temp;
        _appState.viewScreen = ViewScreen.home;
        _updateAppState(_appState);
      } else {
        print('not good');
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        const Text("Your Name"),
        const Padding(
          padding: EdgeInsets.fromLTRB(0, 8.0, 0, 12.0),
          child: TextField(
              style: TextStyle(
                fontSize: 14.0,
              ),
              controller: _usernameController,
              decoration: InputDecoration(
                  hintText: 'John Doe', border: OutlineInputBorder())),
        ),
        const Text("Your Email"),
        const Padding(
          padding: EdgeInsets.fromLTRB(0, 8.0, 0, 12.0),
          child: TextField(
              style: TextStyle(
                fontSize: 14.0,
              ),
              decoration: InputDecoration(
                  hintText: 'john@email.com', border: OutlineInputBorder())),
        ),
        const Text("Password"),
        const Padding(
          padding: EdgeInsets.fromLTRB(0, 8.0, 0, 12.0),
          child: TextField(
              style: TextStyle(
                fontSize: 14.0,
              ),
              decoration: InputDecoration(
                  hintText: 'at least 8 characters',
                  border: OutlineInputBorder())),
        ),
        Row(
          children: [
            const Checkbox(value: false, onChanged: null),
            const Text("I agree to the "),
            Text("Terms & Conditions",
                style: TextStyle(color: Colors.blue[700]))
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
                      color: Colors.blueAccent[700],
                      borderRadius: BorderRadius.circular(5.0),
                    ),
                    child: TextButton(
                        onPressed: _saveForm,
                        child: const Text(
                          "Get Started",
                          style: TextStyle(color: Colors.white),
                        ))))
          ]),
        )
      ]),
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