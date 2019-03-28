import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_multilang/app_translations.dart';

class AppTranslationsDelegate extends LocalizationsDelegate<AppTranslations> {
  final Locale newLocale;

  const AppTranslationsDelegate({this.newLocale});

  @override
  bool isSupported(Locale locale) {
    return application.supp;
  }

  @override
  Future load(Locale locale) {
    // TODO: implement load
    return null;
  }

  @override
  bool shouldReload(LocalizationsDelegate old) {
    // TODO: implement shouldReload
    return null;
  }
}
