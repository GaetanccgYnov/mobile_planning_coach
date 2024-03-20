import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class TimeFormatService {
  Future<TimeOfDay?> selectTime(BuildContext context, TimeOfDay initialTime) async {
    final TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: initialTime,
      builder: (BuildContext context, Widget? child) {
        return MediaQuery(
          data: MediaQuery.of(context).copyWith(alwaysUse24HourFormat: true),
          child: child!,
        );
      },
    );
    return picked;
  }

  String formatTimeOfDay24(TimeOfDay time) {
    final hours = time.hour.toString().padLeft(2, '0');
    final minutes = time.minute.toString().padLeft(2, '0');
    return '$hours:$minutes';
  }

  TimeOfDay timeOfDayFromString(String timeString) {
    final timeParts = timeString.split(':');
    return TimeOfDay(hour: int.parse(timeParts[0]), minute: int.parse(timeParts[1]));
  }
}