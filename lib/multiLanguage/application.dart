import 'dart:ui';

///
/// The class has LocaleChangeCallback which will reflect localization changes
///

class Application {
  static final Application _application = Application._internal();

  factory Application() {
    return _application;
  }

  Application._internal();

  final List<String> supportedLanguages = ['English', 'VietNam'];
  final List<String> supportedLanguageCodes = ['en', 'vi'];

  //get list of supported locales
  Iterable<Locale> supportedLocales() =>
      supportedLanguageCodes.map<Locale>((language) => Locale(language, ''));

  //function to be invoked when changing the language
  LocaleChangeCallback onLocaleChanged;
}

Application application = Application();

typedef void LocaleChangeCallback(Locale locale);
