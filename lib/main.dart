import 'package:findvalue/pages/number_page.dart';
import 'package:findvalue/utils/check_list.dart';
import 'package:findvalue/utils/custom_formatter.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
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
  final textFieldController = TextEditingController();
  String errorTextValue = '';

  bool isNumeric(String? s) {
    if (s == null) {
      return false;
    }
    var value = int.tryParse(s);
    return value == null ? false : true;
  }

  void onFindButtonPressed() {
    //Clean Whitespaces, when for example someone give 4, 4 605, 5 it will be: 4,4605,5
    String cleanWhitespaceString = textFieldController.text.replaceAll(" ", "");
    List<String> stringList = cleanWhitespaceString.split(',');
    stringList.removeWhere((element) => element.isEmpty || !isNumeric(element));
    List<int> numbersList = stringList.map(int.parse).toList();

    if (numbersList.length >= 3) {
      final chosenNumber = findNotCorrectAmount(numbersList);
      if (chosenNumber == null) {
        setState(() {
          errorTextValue = "Incorrect numbers";
        });

        return;
      } else {
        setState(() {
          errorTextValue = "";
        });
      }
      if (errorTextValue == "") {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (ctx) => NumberPage(number: chosenNumber),
          ),
        );
      }
    }
  }

  bool isMinRangeList(String value) {
    String cleanWhitespaceString = value.replaceAll(" ", "");
    List<String> list = cleanWhitespaceString.split(',');
    list.removeWhere((element) => element.isEmpty);

    if (list.length > 2) {
      return true;
    }
    return false;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(widget.title),
        ),
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              TextField(
                onChanged: (value) {
                  setState(() {
                    if (','.allMatches(value).length < 3) {
                      if (!isMinRangeList(value)) {
                        errorTextValue = "Must be min. 3 elements in list";
                      } else {
                        errorTextValue = "";
                      }
                    } else {
                      errorTextValue = "";
                    }
                  });
                },
                controller: textFieldController,
                inputFormatters: [
                  FilteringTextInputFormatter.allow(RegExp(r'^[0-9\s,-]+$'),
                      replacementString: textFieldController.text),
                  CustomFormatter()
                ],
                decoration: InputDecoration(
                    errorText: errorTextValue.isEmpty ? null : errorTextValue,
                    border: const OutlineInputBorder(),
                    hintText: 'Enter numbers ex. 1, 2, 3'),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 20),
                child: OutlinedButton(
                    onPressed: onFindButtonPressed, child: const Text('Find')),
              )
            ],
          ),
        ));
  }

  @override
  void dispose() {
    textFieldController.dispose();
    super.dispose();
  }
}
