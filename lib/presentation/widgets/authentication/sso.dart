import 'package:flutter/material.dart';

class SSO extends StatefulWidget {
  const SSO({Key? key}) : super(key: key);

  @override
  _SSOState createState() => _SSOState();
}

class _SSOState extends State<SSO> {
  Widget _ssoButton(String title, Color color) {
    return Expanded(
      flex: 1,
      child: Container(
          padding: const EdgeInsets.all(4),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(4)),
              border: Border.all(
                  width: 2, color: Color(0xff202122))), //Color(0xffb9bbbe)
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(Icons.circle, color: Color(0xff202122)),
              SizedBox(width: 10),
              Text(title,
                  style: TextStyle(
                      color: Color(0xff202122), fontWeight: FontWeight.bold))
            ],
          )),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        margin: const EdgeInsets.symmetric(vertical: 10),
        width: 480,
        child: Row(
          children: [
            _ssoButton("Github", Colors.black),
            const SizedBox(width: 10),
            _ssoButton("Google", Color(0xffDB4437)),
            const SizedBox(width: 10),
            _ssoButton("Facebook", Color(0xff4267B2))
          ],
        ));
  }
}
