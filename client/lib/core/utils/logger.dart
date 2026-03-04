import 'package:flutter/foundation.dart';

class Logger {
  static LogMode _logMode = LogMode.debug;

  static void init(LogMode mode) {
    Logger._logMode = mode;
  }

  static void log(dynamic data, {StackTrace? stackTrace}) {
    if (_logMode == LogMode.debug) {
      if (kDebugMode) {
        print("Error: $data$stackTrace");
      }
    }
  }
}

enum LogMode { debug, live }
