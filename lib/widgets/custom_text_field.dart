import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

import '../utils/custom_formatter.dart';
import '../utils/error_text_provider.dart';
import '../utils/utils.dart';

class CustomTextField extends StatefulWidget {
  final Function textFieldCallback;

  const CustomTextField({super.key, required this.textFieldCallback});

  @override
  State<CustomTextField> createState() => _CustomTextFieldState();
}

class _CustomTextFieldState extends State<CustomTextField> {
  final _textFieldController = TextEditingController();
  void _saveErrorText(String text) {
    Provider.of<ErrorTextProvider>(context, listen: false).saveErrorText(text);
  }

  @override
  void dispose() {
    _textFieldController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final String errorText =
        Provider.of<ErrorTextProvider>(context).getErrorText;
    return Platform.isIOS
        ? SafeArea(
            child: CupertinoTextFormFieldRow(
              controller: _textFieldController,
              prefix: const Text("Tab"),
              onChanged: (value) {
                widget.textFieldCallback(value);
              },
              inputFormatters: _getFormattersList(_textFieldController.text),
              placeholder: 'Enter numbers ex. 1, 2, 3',
              validator: (String? value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter a value';
                }
                return null;
              },
            ),
          )
        : TextField(
            onChanged: (value) {
              widget.textFieldCallback(value);
              _buildOnChanged(value);
            },
            controller: _textFieldController,
            inputFormatters: _getFormattersList(_textFieldController.text),
            decoration: InputDecoration(
                errorText: errorText.isEmpty ? null : errorText,
                border: const OutlineInputBorder(),
                hintText: 'Enter numbers ex. 1, 2, 3'),
          );
  }

  List<TextInputFormatter> _getFormattersList(String replacementString) {
    return [
      FilteringTextInputFormatter.allow(RegExp(r'^[0-9\s,-]+$'),
          replacementString: replacementString),
      CustomFormatter()
    ];
  }

  void _buildOnChanged(String value) {
    setState(() {
      if (','.allMatches(value).length < 3) {
        if (!_isMinRangeList(value)) {
          _saveErrorText("Must be min. 3 elements in list");
        } else {
          _saveErrorText("");
        }
      } else {
        _saveErrorText("");
      }
    });
  }

  bool _isMinRangeList(String value) {
    String cleanWhitespaceString = value.replaceAll(" ", "");
    List<String> list = cleanWhitespaceString.split(',');
    list.removeWhere((element) => element.isEmpty || !isNumeric(element));

    if (list.length > 2) {
      return true;
    }
    return false;
  }
}
