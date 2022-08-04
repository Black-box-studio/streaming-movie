import 'package:flutter/material.dart';

class LanguageDevice {
  //List Of Supported Language
  static const kSupportedLocales = [
    Locale('en', 'US'),
    Locale('ar', 'SA'),
    Locale('fr', 'FR'),
    Locale('es', 'ES'),
  ];

  //List Of Supported Locales
  static const kIsSupported = ['en', 'ar', 'fr', 'es'];

  //List Selected Language
  static List<Language> listLanguage() {
    return <Language>[
      Language(id: 1, flag: '🇺🇸', name: 'English', languageCode: 'en'),
      Language(id: 2, flag: '🇦🇪', name: 'العربية', languageCode: 'ar'),
      Language(id: 3, flag: '🇫🇷', name: 'Français', languageCode: 'fr'),
      Language(id: 4, flag: '🇪🇸', name: 'Español', languageCode: 'es'),
    ];
  }

  //List Locale
  static Locale locale(String languageCode) {
    Locale _temp;
    switch (languageCode) {
      case 'en':
        _temp = Locale(languageCode, 'US');
        break;
      case 'ar':
        _temp = Locale(languageCode, 'SA');
        break;
      case 'fr':
        _temp = Locale(languageCode, 'FR');
        break;
      case 'es':
        _temp = Locale(languageCode, 'ES');
        break;

      ///Default en
      default:
        _temp = Locale('en', 'US');
    }
    return _temp;
  }
}

/// DO not change above code
class Language {
  final int id;
  final String name;
  final String flag;
  final String languageCode;

  Language({this.id, this.name, this.flag, this.languageCode});
}
