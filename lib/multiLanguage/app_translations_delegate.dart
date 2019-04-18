import 'package:flutter/material.dart';
import 'dart:async';
import 'package:testt/multiLanguage/app_translations.dart';
import 'application.dart';

///
/// This class to check locale is supported or not.
///
///
class AppTranslationsDelegate extends LocalizationsDelegate<AppTranslations> {
  final Locale newLocale;

  const AppTranslationsDelegate({this.newLocale});

  @override
  bool isSupported(Locale locale) {
    return Application.supportedLanguageCodes.contains(locale.languageCode);
  }

  @override
  Future<AppTranslations> load(Locale locale) {
    return AppTranslations.load(newLocale ?? locale);
  }

  @override
  bool shouldReload(LocalizationsDelegate<AppTranslations> old) {
    return true;
  }

}
