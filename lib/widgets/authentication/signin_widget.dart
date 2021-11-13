import 'package:flutter/material.dart';
import 'package:waultar/etebase/authentication.dart';
import 'package:waultar/etebase/models/etebase_user.dart';
import 'package:waultar/globals/globals.dart';
import 'package:waultar/navigation/app_state.dart';
import 'package:waultar/navigation/screen.dart';
import 'package:waultar/widgets/sso.dart';

class SignInWidget extends StatefulWidget {
  final AppState _appState;
  final ValueChanged<AppState> _updateAppState;

  SignInWidget(this._appState, this._updateAppState, {Key? key})
      : super(key: key);

  @override
  State<SignInWidget> createState() =>
      _SignInWidget(_appState, _updateAppState);
}

class _SignInWidget extends State<SignInWidget> {
  AppState _appState;
  ValueChanged<AppState> _updateAppState;
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  _SignInWidget(this._appState, this._updateAppState);

  Widget test() {
    return TextButton(
        onPressed: () async {
          _appState.user = EtebaseUser('', '');
          _appState.viewScreen = ViewScreen.home;
          _updateAppState(_appState);
        },
        child: const Text(
          'Login',
          style: TextStyle(
              fontSize: 16, color: Colors.white, fontWeight: FontWeight.bold),
        ));
  }

  void _saveForm() async {
    final bool isValid = _formKey.currentState!.validate();
    print(isValid);

    if (isValid) {
      var tempEtebaseUser = EtebaseUser(
          _usernameController.text.trim(), _emailController.text.trim());

      // var temp = await signUp(tempEtebaseUser, _passwordController.text.trim());
      var temp = await signIn(
          tempEtebaseUser.username, _passwordController.text.trim());

      if (temp != null) {
        print(temp.username);
        print(temp.email);

        _appState.user = temp;
        _appState.viewScreen = ViewScreen.home;
        _updateAppState(_appState);
      } else {
        print('not good');
      }
    } else {
      print("not valid");
    }
  }

  Widget _title() {
    return const Center(
        child: Text(
      "Welcome back!",
      style: TextStyle(
          fontSize: 24, fontWeight: FontWeight.bold, color: Colors.white),
    ));
  }

  Widget _entryField(String title, TextEditingController controller,
      {bool isPassword = false}) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            title,
            style: const TextStyle(
                color: Color(0xffb9bbbe),
                fontWeight: FontWeight.bold,
                fontSize: 12),
          ),
          const SizedBox(
            height: 10,
          ),
          TextField(
              controller: controller,
              style: const TextStyle(fontSize: 14, color: Color(0xffb9bbbe)),
              obscureText: isPassword,
              decoration: const InputDecoration(
                  isDense: true,
                  contentPadding: EdgeInsets.all(18.0),
                  border: OutlineInputBorder(),
                  fillColor: Color(0xff2f3136),
                  filled: true))
        ],
      ),
    );
  }

  Widget _emailPasswordWidget() {
    return Column(
      children: <Widget>[
        _entryField("EMAIL", _emailController),
        _entryField("PASSWORD", _passwordController, isPassword: true),
      ],
    );
  }

  Widget _continueButton() {
    return InkWell(
      onTap: () => _saveForm(),
      child: Container(
          margin: const EdgeInsets.symmetric(vertical: 10),
          padding: const EdgeInsets.symmetric(vertical: 15),
          alignment: Alignment.center,
          decoration: const BoxDecoration(
              borderRadius: BorderRadius.all(
                Radius.circular(5),
              ),
              color: Colors.blue),
          child: const Text(
            'Login',
            style: TextStyle(
                fontSize: 16, color: Colors.white, fontWeight: FontWeight.bold),
          )),
    );
  }

  Widget _forgotPassword() {
    return Container(
        margin: const EdgeInsets.only(top: 10, bottom: 10),
        child: InkWell(
            onTap: () {},
            child: const Text("Forgot password?",
                style: TextStyle(color: Colors.blue))));
  }

  Widget _signUpLink() {
    return Container(
      margin: const EdgeInsets.only(top: 10),
      child: InkWell(
        onTap: () {
          _appState.viewScreen = ViewScreen.signup;
          _updateAppState(_appState);
        },
        child:
            const Text("Not a member?", style: TextStyle(color: Colors.blue)),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Form(
        key: _formKey,
        child: Container(
          margin: const EdgeInsets.fromLTRB(0, 10, 0, 10),
          width: 480,
          //height: 580,
          padding: const EdgeInsets.all(32.0),
          decoration: BoxDecoration(
            color: const Color.fromARGB(255, 54, 57, 63),
            borderRadius: const BorderRadius.all(Radius.circular(10)),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.3),
                spreadRadius: 5,
                blurRadius: 7,
                offset: const Offset(0, 3), // changes position of shadow
              ),
            ],
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _title(),
              const SizedBox(height: 15),
              _emailPasswordWidget(),
              _forgotPassword(),
              _continueButton(),
              //const SSO(),
              _signUpLink()
            ],
          ),
        ));
  }
}
