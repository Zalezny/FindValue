import 'package:flutter/material.dart';

class NumberPage extends StatelessWidget {
  final int number;
  const NumberPage({super.key, required this.number});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Chosen Number'),
      ),
      body: Container(
        alignment: Alignment.topCenter,
        child: Text(
          number.toString(),
          style: const TextStyle(fontSize: 80, fontWeight: FontWeight.bold),
        ),
      ),
    );
  }
}
