import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:testt/multiLanguage/signup_screen.dart';
import 'dart:async';
import 'application.dart';

import 'package:testt/multiLanguage/app_translations_delegate.dart';

Future<Null> main() async {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  AppTranslationsDelegate _newLocalDelegate;

  @override
  void initState() {
    super.initState();
    _newLocalDelegate = AppTranslationsDelegate(newLocale: null);
    application.onLocaleChanged = onLocaleChange;
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: SignUpUI(),
      localizationsDelegates: [
        _newLocalDelegate,
        //provides localised strings
        GlobalMaterialLocalizations.delegate,
        //provides RTL support
        GlobalWidgetsLocalizations.delegate,
      ],
      supportedLocales: [const Locale('vi', ''), const Locale('en', '')],
    );
  }

  void onLocaleChange(Locale locale) {
    setState(() {
      _newLocalDelegate = AppTranslationsDelegate(newLocale: locale);
    });
  }
}
