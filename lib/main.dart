import 'dart:io';

import 'package:findvalue/pages/number_page.dart';
import 'package:findvalue/utils/check_list.dart';
import 'package:findvalue/utils/custom_formatter.dart';
import 'package:findvalue/utils/utils.dart';
import 'package:findvalue/widgets/custom_text_field.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    return MaterialApp(
      title: 'Find Value',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'Find Value'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});
  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final _textFieldController = TextEditingController();
  String _errorTextValue = '';

  @override
  void dispose() {
    _textFieldController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Platform.isIOS
        ? SafeArea(
            child: CupertinoPageScaffold(
              navigationBar: _buildAppBar() as CupertinoNavigationBar,
              child: _buildBody(),
            ),
          )
        : Scaffold(
            appBar: _buildAppBar() as AppBar,
            body: _buildBody(),
          );
  }

  void _onFindButtonPressed() {
    //Clean Whitespaces, when for example someone give 4, 4 605, -, 5 it will be: 4,4605,5
    String cleanWhitespaceString =
        _textFieldController.text.replaceAll(" ", "");
    List<String> stringList = cleanWhitespaceString.split(',');
    stringList.removeWhere((element) => element.isEmpty || !isNumeric(element));
    List<int> numbersList = stringList.map(int.parse).toList();

    if (numbersList.length >= 3) {
      final chosenNumber = findNotCorrectAmount(numbersList);
      if (chosenNumber == null) {
        setState(() {
          _errorTextValue = "Incorrect numbers";
        });

        return;
      } else {
        setState(() {
          _errorTextValue = "";
        });
      }
      if (_errorTextValue == "") {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (ctx) => NumberPage(number: chosenNumber),
          ),
        );
      }
    }
  }

  void setErrorText(String text) {
    setState(() {
      _errorTextValue = text;
    });
  }

  Widget _buildAppBar() {
    return Platform.isIOS
        ? CupertinoNavigationBar(
            middle: Text(widget.title),
          )
        : AppBar(
            title: Text(widget.title),
          );
  }

  Widget _buildBody() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        children: [
          CustomTextField(
            controller: _textFieldController,
            errorText: _errorTextValue,
          ),
          Padding(
            padding: const EdgeInsets.only(top: 20),
            child: OutlinedButton(
                onPressed: _onFindButtonPressed, child: const Text('Find')),
          )
        ],
      ),
    );
  }
}
