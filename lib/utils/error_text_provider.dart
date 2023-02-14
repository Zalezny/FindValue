import 'package:flutter/material.dart';

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
