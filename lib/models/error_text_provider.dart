import 'package:flutter/material.dart';

// That's class of state managment between MyHomePage and CustomTextField

class ErrorTextProvider extends ChangeNotifier {
  var _errorText = "";

  String get getErrorText {
    return _errorText;
  }

  void saveErrorText(String text) {
    _errorText = text;
    notifyListeners();
  }
}
