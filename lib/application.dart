import 'dart:ui';

class Application {
  static final Application _application = Application._internal();
  factory Application () {
    return _application;
  }
  Application._internal();

  final List<String> supportedLanguages = [
    "English",
    "Spannish",
    "Vietnam"
  ];

  final List<String> supportedLanguageCodes = [
    "en",
    "es",
    "vi"
  ];

  Iterable<Locale> supportedLocales() =>
      supportedLanguageCodes.map<Locale>((language) => Locale(language,""));

  LocaleChangeCallBack onLocaleChanged;

}

Application application = Application();

typedef void LocaleChangeCallBack(Locale locale);
