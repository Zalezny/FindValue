import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../utils/custom_formatter.dart';
import '../utils/utils.dart';

class CustomTextField extends StatefulWidget {
  TextEditingController controller;
  String errorText;
  CustomTextField(
      {super.key, required this.controller, required this.errorText});

  @override
  State<CustomTextField> createState() => _CustomTextFieldState();
}

class _CustomTextFieldState extends State<CustomTextField> {
  @override
  Widget build(BuildContext context) {
    return Platform.isIOS
        ? SafeArea(
            child: CupertinoTextFormFieldRow(
              controller: widget.controller,
              inputFormatters: _getFormattersList(widget.controller.text),
              placeholder: 'Enter numbers ex. 1, 2, 3',
              validator: (value) {
                if (value != null) {
                  if (','.allMatches(value).length < 3) {
                    if (!_isMinRangeList(value)) {
                      return "Must be min. 3 elements in list";
                    } else {
                      return "";
                    }
                  } else {
                    return "";
                  }
                }
                return null;
              },
              decoration: const BoxDecoration(),
            ),
          )
        : TextField(
            onChanged: (value) => _buildOnChanged(value),
            controller: widget.controller,
            inputFormatters: _getFormattersList(widget.controller.text),
            decoration: InputDecoration(
                errorText: widget.errorText.isEmpty ? null : widget.errorText,
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
          widget.errorText = "Must be min. 3 elements in list";
        } else {
          widget.errorText = "";
        }
      } else {
        widget.errorText = "";
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
