import 'package:fimber/fimber.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';

class CrashReportingTree extends LogTree {
  //Only Log Warnings and Exceptions
  static const List<String> defaultLevels = ["E"];
  final List<String> logLevels;

  @override
  List<String> getLevels() => logLevels;

  CrashReportingTree({this.logLevels = defaultLevels});

  @override
  void log(
    String level,
    String message, {
    String? tag,
    dynamic ex,
    StackTrace? stacktrace,
  }) {
    final crashlytics = FirebaseCrashlytics.instance;
    crashlytics.setCustomKey("message", message);
    if (tag != null) {
      crashlytics.setCustomKey("tag", tag);
    }
    if (ex != null) {
      crashlytics.recordError(ex, stacktrace);
    }
  }
}
