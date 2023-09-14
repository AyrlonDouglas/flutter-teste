import 'package:flutter/material.dart';
import 'dart:io';

class ActionsStopwatch extends StatelessWidget {
  final Function() onStart;
  final Function() onStop;
  final Function() onRestart;
  final bool isRunning;

  const ActionsStopwatch({
    super.key,
    required this.onStart,
    required this.onStop,
    required this.onRestart,
    required this.isRunning,
  });

  @override
  Widget build(BuildContext context) {
    bool isLandeScape =
        MediaQuery.of(context).orientation == Orientation.landscape;

    return LayoutBuilder(
      builder: (ctx, constraints) {
        List<Widget> actionsButtons = [
          ElevatedButton.icon(
            icon: Icon(isRunning ? Icons.pause : Icons.play_arrow),
            onPressed: isRunning ? onStop : onStart,
            style: ElevatedButton.styleFrom(
                fixedSize: Size(
                    isLandeScape
                        ? constraints.maxWidth * 0.48
                        : constraints.maxWidth,
                    50),
                backgroundColor:
                    isRunning ? Colors.red[400] : Colors.green[400]),
            label: Text(isRunning ? 'STOP' : 'PLAY'),
          ),
          const SizedBox(height: 20),
          ElevatedButton.icon(
            style: ElevatedButton.styleFrom(
                fixedSize: Size(
                    isLandeScape
                        ? constraints.maxWidth * 0.48
                        : constraints.maxWidth,
                    50),
                backgroundColor: Colors.blue[400]),
            onPressed: onRestart,
            icon: const Icon(Icons.restart_alt),
            label: const Text('RESET'),
          ),
        ];

        return isLandeScape
            ? Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: actionsButtons,
              )
            : Column(children: actionsButtons);
      },
    );
  }
}
