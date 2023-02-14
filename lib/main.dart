import 'package:findvalue/check_list.dart';
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
      home: const MyHomePage(title: 'Home Page'),
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

    print(findNotCorrectAmount(numbersList));
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
        body: Column(
          children: [
            TextField(
              controller: textFieldController,
              decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: 'Enter a numbers [ex. 1, 2, 3]'),
            ),
            OutlinedButton(
                onPressed: onFindButtonPressed, child: const Text('Find'))
          ],
        ));
  }
}
