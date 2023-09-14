class Schedule {
  int hour;
  int minutes;
  int seconds;
  int milliSeconds;

  late int _initialHour;
  late int _initialMinutes;
  late int _initialSeconds;
  late int _initialMilliSeconds;

  Schedule({
    this.hour = 0,
    this.minutes = 0,
    this.seconds = 0,
    this.milliSeconds = 0,
  }) {
    _initialHour = hour;
    _initialMinutes = minutes;
    _initialSeconds = seconds;
    _initialMilliSeconds = milliSeconds;
  }

  void resetToInitialParams() {
    hour = _initialHour;
    minutes = _initialMinutes;
    seconds = _initialSeconds;
    milliSeconds = _initialMilliSeconds;
  }
}
