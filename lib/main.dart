import 'dart:io';

import 'package:findvalue/pages/number_page.dart';
import 'package:findvalue/utils/check_list.dart';
import 'package:findvalue/utils/custom_formatter.dart';
import 'package:findvalue/utils/error_text_provider.dart';
import 'package:findvalue/utils/utils.dart';
import 'package:findvalue/widgets/custom_text_field.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(ChangeNotifierProvider(
    create: (ctx) => ErrorTextProvider(),
    child: const MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    return Platform.isIOS
        ? const CupertinoApp(
            theme: CupertinoThemeData(brightness: Brightness.light),
            home: MyHomePage(title: 'Find Value'))
        : MaterialApp(
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
  String _text = "";
  void _saveErrorText(String text) {
    Provider.of<ErrorTextProvider>(context, listen: false).saveErrorText(text);
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
    final String errorText =
        Provider.of<ErrorTextProvider>(context, listen: false).getErrorText;
    //Clean Whitespaces, when for example someone give 4, 4 605, -, 5 it will be: 4,4605,5
    String cleanWhitespaceString = _text.replaceAll(" ", "");
    List<String> stringList = cleanWhitespaceString.split(',');
    stringList.removeWhere((element) => element.isEmpty || !isNumeric(element));
    List<int> numbersList = stringList.map(int.parse).toList();

    if (numbersList.length >= 3) {
      final chosenNumber = findNotCorrectAmount(numbersList);
      if (chosenNumber == null) {
        _saveErrorText("Incorrect numbers");
        return;
      } else {
        _saveErrorText("");
      }
      if (errorText == "") {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (ctx) => NumberPage(number: chosenNumber),
          ),
        );
      }
    }
  }

  void onTextFieldCallback(String text) {
    setState(() {
      _text = text;
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
            textFieldCallback: (value) => onTextFieldCallback(value),
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
