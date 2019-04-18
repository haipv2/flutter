import 'dart:ui';

///
/// The class has LocaleChangeCallback which will reflect localization changes
///

class Application {
//  final List<String> languagesList = application.supportedLanguages;
//  final List<String> languageCodesList =
//      application.supportedLanguageCodes;

  final Map<dynamic, dynamic> languagesMap = {
    supportedLanguages[0]: supportedLanguageCodes[0],
    supportedLanguages[1]: supportedLanguageCodes[1],
  };

  static final Application _application = Application._internal();

  factory Application() {
    return _application;
  }

  Application._internal();

  static final List<String> supportedLanguages = ['English', 'VietNam'];
  static final List<String> supportedLanguageCodes = ['en', 'vi'];

  //get list of supported locales
  Iterable<Locale> supportedLocales() =>
      supportedLanguageCodes.map<Locale>((language) => Locale(language, ''));

  //function to be invoked when changing the language
  LocaleChangeCallback onLocaleChanged;
}

Application application = Application();

typedef void LocaleChangeCallback(Locale locale);
