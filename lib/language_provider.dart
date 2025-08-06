import 'package:flutter/material.dart';
import 'translations.dart';

class LanguageProvider extends ChangeNotifier {
  String _currentLanguage = 'es'; // Default to Spanish

  String get currentLanguage => _currentLanguage;

  void setLanguage(String languageCode) {
    if (Translations.getSupportedLanguages().contains(languageCode)) {
      _currentLanguage = languageCode;
      notifyListeners();
    }
  }

  String translate(String key) {
    return Translations.get(key, _currentLanguage);
  }

  bool get isEnglish => _currentLanguage == 'en';
  bool get isSpanish => _currentLanguage == 'es';
  bool get isChinese => _currentLanguage == 'zh';
}