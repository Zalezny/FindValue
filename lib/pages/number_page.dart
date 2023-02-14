import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../strings.dart';

class NumberPage extends StatelessWidget {
  final int number;
  const NumberPage({super.key, required this.number});

  Widget? _buildAppBar() {
    const appbarText = Text(Strings.chosenNumber);
    return Platform.isIOS
        ? const CupertinoNavigationBar(
            middle: appbarText,
          )
        : AppBar(
            title: appbarText,
          );
  }

  Widget _buildBody() {
    return Container(
      alignment: Alignment.topCenter,
      child: Text(
        number.toString(),
        style: const TextStyle(
          fontSize: 80,
          fontWeight: FontWeight.bold,
          fontStyle: FontStyle.normal,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Platform.isIOS
        ? SafeArea(
            child: CupertinoPageScaffold(
              navigationBar: _buildAppBar() as CupertinoNavigationBar,
              child: SafeArea(child: _buildBody()),
            ),
          )
        : Scaffold(
            appBar: _buildAppBar() as AppBar,
            body: _buildBody(),
          );
  }
}
