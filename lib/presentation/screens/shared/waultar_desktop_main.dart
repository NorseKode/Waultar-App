import 'package:flutter/material.dart';
import 'package:waultar/configs/globals/scaffold_main.dart';

getWaultarDesktopMainBody(BuildContext context, Widget menuPanel, Widget topPanel, Widget body) {
  return getScaffoldMain(
    context,
    Row(
      children: [
        menuPanel,
        Expanded(
          child: SizedBox(
            height: MediaQuery.of(context).size.height,
            child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  topPanel,
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.fromLTRB(20, 0, 20, 20),
                      child: body,
                    ),
                  )
                ]),
          ),
        )
      ],
    ),
  );
}
