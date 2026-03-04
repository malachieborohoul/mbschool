import 'package:flutter/material.dart';

class LanguageProvider extends ChangeNotifier {
  int _language = 0;
  int get language => _language;

  void setLanguage(int language) {
    _language = language;
    notifyListeners();
  }
}
