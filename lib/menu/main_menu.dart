import 'package:flutter/material.dart';
import 'package:testt/multiLanguage/app_translations_delegate.dart';
import 'package:testt/multiLanguage/application.dart';
import 'package:testt/multiLanguage/app_translations.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  String label = Application.supportedLanguages[0];
  AppTranslationsDelegate _newLocalDelegate;

  @override
  void initState() {
    super.initState();
//    _newLocalDelegate = AppTranslationsDelegate(newLocale: null);
    _newLocalDelegate = AppTranslationsDelegate(newLocale: Locale('en'));
//    Locale currentLocale = Localizations.localeOf(context);
    application.onLocaleChanged = onLocaleChanged;
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      localizationsDelegates: [
        _newLocalDelegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ],
      supportedLocales: [const Locale('vi', ''), const Locale('en', '')],
      home: Scaffold(
        appBar: AppBar(
          title: Text(label),
          actions: <Widget>[
            PopupMenuButton<String>(
              // overflow menu
              onSelected: _select,
              icon: new Icon(Icons.language, color: Colors.white),
              itemBuilder: (BuildContext context) {
                return Application.supportedLanguages
                    .map<PopupMenuItem<String>>((String choice) {
                  return PopupMenuItem<String>(
                    value: choice,
                    child: Text(choice),
                  );
                }).toList();
              },
            )
          ],
        ),
        body: _buildMainMenu(context),
      ),
    );
  }

  Widget _buildMainMenu(BuildContext context) {
    return Container(
      child: Column(
        children: <Widget>[
          Padding(
              child: MaterialButton(
            onPressed: null,
            textColor: Colors.red,
            child: Text(AppTranslations.of(context).text("key_next")),
          ))
        ],
      ),
    );
  }

  void onLocaleChanged(Locale locale) {
    setState(() {
      _newLocalDelegate = AppTranslationsDelegate(newLocale: locale);
      AppTranslations.load(locale);
    });
  }

  void _select(String value) {
    print(' select language $value');
    onLocaleChanged(Locale(application.languagesMap[value]));
    setState(() {
      if (value == "VietNam") {
        label = "Viet Nam";
      } else {
        label = value;
      }
    });
  }
}
