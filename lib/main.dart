import 'package:findvalue/pages/number_page.dart';
import 'package:findvalue/utils/check_list.dart';
import 'package:flutter/material.dart';

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

  void onFindButtonPressed() {
    List<String> stringList = textFieldController.text.split(",");
    List<int> numbersList = stringList.map(int.parse).toList();

    final chosenNumber = findNotCorrectAmount(numbersList);
    if (chosenNumber == null) {
    } else {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (ctx) => NumberPage(number: chosenNumber),
        ),
      );
    }
  }

  @override
  void dispose() {
    textFieldController.dispose();
    super.dispose();
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
                controller: textFieldController,
                decoration: const InputDecoration(
                    errorText: 'test',
                    border: OutlineInputBorder(),
                    hintText: 'Enter a numbers ex. 1, 2, 3'),
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
}
