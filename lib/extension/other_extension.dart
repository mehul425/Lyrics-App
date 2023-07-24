import 'dart:ui';

import 'package:juna_bhajan/data/model/change_data.dart';

extension ColorExtension on String {
  Color toColor() {
    var hexColor = replaceAll("#", "");
    if (hexColor.length == 6) {
      hexColor = "FF$hexColor";
    }
    return Color(int.parse("0x$hexColor"));
  }

  bool isHexColor() {
    return RegExp(r'^#?([0-9a-fA-F]{8})$').hasMatch(this);
  }
}

extension DateExtension on DateTime {
  DateTime getDateOnly() {
    return DateTime(year, month, day);
  }
}

extension DurationExtension on int {
  String toHhMmSs() {
    final duration = Duration(seconds: this);
    final hours = duration.inHours;
    if (hours == 0) {
      final minutes = duration.inMinutes;
      final seconds = this % 60;

      final minutesString = '$minutes'.padLeft(2, '0');
      final secondsString = '$seconds'.padLeft(2, '0');
      return '$minutesString:$secondsString';
    } else {
      final tempMinutes = Duration(seconds: this % 3600);
      final minutes = tempMinutes.inMinutes;
      final seconds = this % 3600 % 60;

      final hoursString = '$hours'.padLeft(2, '0');
      final minutesString = '$minutes'.padLeft(2, '0');
      final secondsString = '$seconds'.padLeft(2, '0');
      return '$hoursString:$minutesString:$secondsString';
    }
  }
}

extension StringListExtension<T> on List<String>? {
  List<String>? mergeStringList(List<String>? other) {
    if (this == null && other == null) {
      return null;
    } else if (this == null) {
      return other;
    } else if (other == null) {
      return this;
    } else {
      return (this! + other).toSet().toList();
    }
  }
}

extension ChangeListExtension on List<ChangeData> {
  ChangeData mergeChangeDataList(int from) {
    return skip(from)
        .reduce((value, element) => value.mergeChangeData(element));
  }
}

extension BoolExtension on bool? {
  bool? mergeBool(bool? other) {
    if (this == null && other == null) {
      return null;
    } else if (this == null) {
      return other;
    } else if (other == null) {
      return this;
    } else {
      return this! || other;
    }
  }
}
