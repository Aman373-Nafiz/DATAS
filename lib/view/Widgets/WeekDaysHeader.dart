import 'package:datas/viewmodel/Controller/CalenderController.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
class WeekDaysHeader extends StatelessWidget {
  final calendarController = Get.find<CalendarController>();

  @override
  Widget build(BuildContext context) {
    return  Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: calendarController.weekdays.map((day) {
        final isWeekend =  day == "Sun";
        return Expanded(
          child: Center(
            child: Text(
              day,
              style: TextStyle(
                fontSize: 17,
                fontWeight: FontWeight.bold,
                color: isWeekend ? Colors.orange : Colors.teal,
              ),
            ),
          ),
        );
      }).toList(),
    );
  }
}
