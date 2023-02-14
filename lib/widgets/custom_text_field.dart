import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

import '../strings.dart';
import '../utils/custom_formatter.dart';
import '../models/error_text_provider.dart';
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
            child: Column(
              children: [
                CupertinoTextFormFieldRow(
                  controller: _textFieldController,
                  prefix: const Text(Strings.tab),
                  onChanged: (value) {
                    widget.textFieldCallback(value);
                    _buildOnChanged(value);
                  },
                  inputFormatters:
                      _getFormattersList(_textFieldController.text),
                  placeholder: Strings.placeholderTextField,
                ),
                Container(
                  alignment: Alignment.centerLeft,
                  margin: const EdgeInsets.only(left: 20),
                  child: Text(
                    errorText,
                    style: const TextStyle(color: Colors.red, fontSize: 12),
                  ),
                )
              ],
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
                hintText: Strings.placeholderTextField),
          );
  }

  void _buildOnChanged(String value) {
    setState(() {
      if (','.allMatches(value).length < 3) {
        if (!_isMinRangeListFormatter(value)) {
          _saveErrorText(Strings.errorMinThree);
        } else {
          _saveErrorText(Strings.emptyString);
        }
      } else {
        _saveErrorText(Strings.emptyString);
      }
    });
  }

  List<TextInputFormatter> _getFormattersList(String replacementString) {
    return [
      FilteringTextInputFormatter.allow(RegExp(r'^[0-9\s,-]+$'),
          replacementString: replacementString),
      CustomFormatter()
    ];
  }

  bool _isMinRangeListFormatter(String value) {
    String cleanWhitespaceString = value.replaceAll(" ", "");
    List<String> list = cleanWhitespaceString.split(',');
    list.removeWhere((element) => element.isEmpty || !Utils.isNumeric(element));

    if (list.length > 2) {
      return true;
    }
    return false;
  }
}
