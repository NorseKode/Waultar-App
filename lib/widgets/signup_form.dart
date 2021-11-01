import 'package:flutter/material.dart';

class SignUpForm extends StatefulWidget {
  SignUpForm({Key? key}) : super(key: key);

  @override
  State<SignUpForm> createState() => _SignUpForm();
}

class _SignUpForm extends State<SignUpForm> {
  final _formKey = GlobalKey<FormState>();

  void _saveForm() {
    final bool isValid = _formKey.currentState!.validate();
    if (isValid) {
      print('Got a valid input');
      // And do something here
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
              const Padding(
                  padding: EdgeInsets.fromLTRB(0, 0, 0, 12.0),
                  child: Text("Register",
                      textAlign: TextAlign.left,
                      style: TextStyle(
                          fontSize: 20, fontWeight: FontWeight.bold))),
              Text("Your Name", style: textStyle),
              Padding(
                padding: EdgeInsets.fromLTRB(0, 8.0, 0, 12.0),
                child: TextField(
                    style: textStyle,
                    decoration: const InputDecoration(
                        hintText: 'John Doe', border: OutlineInputBorder())),
              ),
              Text("Your Email", style: textStyle),
              Padding(
                padding: EdgeInsets.fromLTRB(0, 8.0, 0, 12.0),
                child: TextField(
                    style: textStyle,
                    decoration: const InputDecoration(
                        hintText: 'john@email.com',
                        border: OutlineInputBorder())),
              ),
              Text("Password", style: textStyle),
              Padding(
                padding: EdgeInsets.fromLTRB(0, 8.0, 0, 12.0),
                child: TextField(
                    style: textStyle,
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