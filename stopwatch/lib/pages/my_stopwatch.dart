import 'dart:async';

import 'package:flutter/material.dart';
import 'package:stopwatch/components/actions_stopwatch.dart';
import 'package:stopwatch/components/display_stopwatch.dart';
import 'package:stopwatch/models/schedule.dart';

class MyStopwatch extends StatefulWidget {
  const MyStopwatch({super.key});

  @override
  State<MyStopwatch> createState() => _MyStopwatchState();
}

class _MyStopwatchState extends State<MyStopwatch> {
  late Timer clockTick;

  Schedule schedule = Schedule(
    hour: 0,
    milliSeconds: 0,
    minutes: 0,
    seconds: 0,
  );
  bool pause = true;

  void play() {
    if (pause) {
      pause = false;
    } else {
      return;
    }

    clockTick = Timer.periodic(
      const Duration(milliseconds: 100),
      (timer) {
        if (pause) {
          timer.cancel();
        } else {
          setState(() {
            schedule.milliSeconds += 100;
            if (schedule.milliSeconds >= 1000) {
              schedule.milliSeconds = 0;
              schedule.seconds++;
            }

            if (schedule.seconds > 59) {
              schedule.seconds = 0;
              schedule.minutes++;
            }

            if (schedule.minutes > 59) {
              schedule.minutes = 0;
              schedule.hour++;
            }
          });
        }
      },
    );
  }

  void stop() => setState(() => pause = true);

  void restart() {
    stop();

    setState(() {
      schedule.resetToInitialParams();
    });
  }

  String formatTimerToDisplay() {
    int hourLength = schedule.hour.toString().length;
    int minutesLength = schedule.minutes.toString().length;
    int secondsLength = schedule.seconds.toString().length;
    int miliSecondesLength = schedule.milliSeconds.toString().length;

    String textToDisplay = '';

    if (schedule.hour > 0) {
      textToDisplay +=
          hourLength < 2 ? '0${schedule.hour}:' : '${schedule.hour}:';
    }
    if (schedule.minutes > 0) {
      textToDisplay +=
          minutesLength < 2 ? '0${schedule.minutes}:' : '${schedule.minutes}:';
    }

    textToDisplay +=
        secondsLength < 2 ? '0${schedule.seconds}:' : '${schedule.seconds}:';
    textToDisplay += miliSecondesLength == 3
        ? '${schedule.milliSeconds}'
        : miliSecondesLength == 2
            ? '0${schedule.milliSeconds}'
            : '00${schedule.milliSeconds}';

    return textToDisplay;
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        return SizedBox(
          height: constraints.maxHeight,
          width: double.infinity,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                width: constraints.maxWidth,
                height: 100,
                child: DisplayStopwatch(
                  timer: formatTimerToDisplay(),
                ),
              ),
              const SizedBox(height: 20),
              SizedBox(
                width: constraints.maxWidth,
                child: ActionsStopwatch(
                  onRestart: restart,
                  onStart: play,
                  onStop: stop,
                  isRunning: !pause,
                ),
              )
            ],
          ),
        );
      },
    );
  }
}
