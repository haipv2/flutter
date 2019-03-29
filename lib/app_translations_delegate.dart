import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_multilang/app_translations.dart';
import 'application.dart';

class AppTranslationsDelegate extends LocalizationsDelegate<AppTranslations> {
  final Locale newLocale;

  const AppTranslationsDelegate({this.newLocale});

  @override
  bool isSupported(Locale locale) {
    return application.supportedLanguageCodes.contains(locale.languageCode);
  }

  @override
  Future<AppTranslations> load(Locale locale) {

    return AppTranslations.load(newLocale ?? locale);
  }

  @override
  bool shouldReload(LocalizationsDelegate old) {
    return true;
  }
}
