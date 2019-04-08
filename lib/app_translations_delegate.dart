import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:flutter/services.dart' show rootBundle;
import 'dart:ui';

class AppTranslationsDelegate extends LocalizationsDelegate<AppTranslation> {
  final Locale newLocale;

  const AppTranslationsDelegate({this.newLocale});

  @override
  bool isSupported(Locale locale) {
    return languagesFactory.supportedLanguageCodes
        .contains(locale.languageCode);
  }

  @override
  Future<AppTranslation> load(Locale locale) {
    return AppTranslation.load(newLocale ?? locale);
  }

  @override
  bool shouldReload(LocalizationsDelegate<AppTranslation> old) {
    return true;
  }
}

class AppTranslation {
  Locale locale;
  static Map<dynamic, dynamic> _localisedValues;

  AppTranslation(this.locale);

  static AppTranslation of(BuildContext context) {
    return Localizations.of<AppTranslation>(context, AppTranslation);
  }

  static Future<AppTranslation> load(Locale locale) async {
    AppTranslation appTranslation = AppTranslation(locale);
    String jsonContent = await rootBundle
        .loadString("assets/locale/localization_${locale.languageCode}.json");
    _localisedValues = json.decode(jsonContent);
    return appTranslation;
  }

  get currentLanguage => locale.languageCode;

  String text(String key) => _localisedValues[key] ?? "$key not found";
}

class LanguagesFactory {
  static final LanguagesFactory _languagesFactory =
      LanguagesFactory._internal();

  factory LanguagesFactory() {
    return _languagesFactory;
  }

  LanguagesFactory._internal();

  final List<String> supportedLanguages = ["English", "VietNam"];
  final List<String> supportedLanguageCodes = ["en", "vi"];

  Iterable<Locale> supportedLocales() =>
      supportedLanguageCodes.map<Locale>((language) => Locale(language, ""));
  LocaleChangeCallBack onLocaleChanged;
}

LanguagesFactory languagesFactory = LanguagesFactory();

typedef void LocaleChangeCallBack(Locale locale);
