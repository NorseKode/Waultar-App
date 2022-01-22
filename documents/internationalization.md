# Internationalization in the app

## Setup

The setup is completed and was done with [https://docs.flutter.dev/development/accessibility-and-localization/internationalization](this guide)

## How to setup localization in a new view
Take a look at this example

```dart
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class GenericView extends StatefulWidget {
  const GenericView({Key? key}) : super(key: key);

  @override
  _GenericViewState createState() => _GenericViewState();
}

class _GenericViewState extends State<GenericView> {
  late AppLocalizations localizer;
  late ThemeProvider themeProvider;
  
  ...

  @override
  Widget build(BuildContext context) {
    localizer = AppLocalizations.of(context)!;    
    themeProvider = Provider.of<ThemeProvider>(context);
    
    return Container(
      child: Text(localizer.helloWorld)
      ...
    );
  }
}
```
