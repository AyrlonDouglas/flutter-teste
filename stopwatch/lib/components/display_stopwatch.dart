import 'package:flutter/material.dart';

class DisplayStopwatch extends StatelessWidget {
  final String timer;

  const DisplayStopwatch({super.key, required this.timer});

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.amber,
      child: Center(
        child: Text(
          textAlign: TextAlign.center,
          timer,
          style: const TextStyle(
              fontSize: 32, fontWeight: FontWeight.bold, color: Colors.white),
        ),
      ),
    );
  }
}
