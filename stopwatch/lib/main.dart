import 'dart:core';
import 'package:flutter/material.dart';
import 'package:stopwatch/pages/my_stopwatch.dart';

main() {
  return runApp(const MyHome());
}

class MyHome extends StatelessWidget {
  const MyHome({super.key});

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);

    final appBar = AppBar(
      title: const Text('Stopwatch'),
      centerTitle: true,
    );

    final availableHeight = mediaQuery.size.height -
        appBar.preferredSize.height -
        mediaQuery.padding.top;

    return MaterialApp(
      home: SafeArea(
        child: Scaffold(
            appBar: appBar,
            body: Center(
              child: SizedBox(
                width: mediaQuery.size.width * 0.8,
                height: availableHeight,
                child: const MyStopwatch(),
              ),
            )),
      ),
    );
  }
}

class Actions extends StatelessWidget {
  const Actions({super.key});

  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}
