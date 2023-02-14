import 'package:flutter/services.dart';

//That's formatter doesn't allow add whitespace or ',' at the beginning
//of the TextField

class CustomFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
      TextEditingValue oldValue, TextEditingValue newValue) {
    if (newValue.text.isNotEmpty) {
      if (newValue.text == " " || newValue.text[0] == ",") {
        return const TextEditingValue(text: "");
      }
    }
    return newValue;
  }
}
