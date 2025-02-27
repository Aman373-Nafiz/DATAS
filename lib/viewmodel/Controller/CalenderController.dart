import 'package:get/get.dart';
import 'package:flutter/material.dart';
class CalendarController extends GetxController {
  final currentDate = DateTime.now().obs;
  final selectedDate = DateTime.now().obs;

  void goToPreviousMonth() {
    currentDate.value = DateTime(currentDate.value.year, currentDate.value.month - 1);
  }

  void goToNextMonth() {
    currentDate.value = DateTime(currentDate.value.year, currentDate.value.month + 1);
  }

  void selectDate(int day) {
    //selectedDate.value = DateTime(currentDate.value.year, currentDate.value.month, day);
     if (selectedDate.value.day != day ||
      selectedDate.value.month != currentDate.value.month ||
      selectedDate.value.year != currentDate.value.year) {
    selectedDate.value = DateTime(currentDate.value.year, currentDate.value.month, day);
     print("Selected date updated to: ${selectedDate.value}");
  }
  }

  bool isToday(int day) {
    DateTime today = DateTime.now();
    return today.day == day &&
        today.month == currentDate.value.month &&
        today.year == currentDate.value.year;
  }

  bool isWeekend(int day) {
    int weekday = DateTime(currentDate.value.year, currentDate.value.month, day).weekday;
    return weekday == 6; 
  }

  int daysInMonth(DateTime date) {
    final nextMonth = (date.month < 12)
        ? DateTime(date.year, date.month + 1, 1)
        : DateTime(date.year + 1, 1, 1);
    return nextMonth.subtract(Duration(days: 1)).day;
  }

  int firstDayOffset(DateTime date) {
    final firstDay = DateTime(date.year, date.month, 1).weekday;
    return firstDay == 7 ? 0 : firstDay;
  }
bool isSelectedDate(DateTime date) {
    return date.year == selectedDate.value.year &&
        date.month == selectedDate.value.month &&
        date.day == selectedDate.value.day;}
  String getMonthName(int month) {
    const monthNames = [
      "January", "February", "March", "April", "May", "June", 
      "July", "August", "September", "October", "November", "December"
    ];
    return monthNames[month - 1];
  }
    final weekdays = ["Mon", "Tue", "Wed", "Thu", "Fri", "Sat", "Sun"];
}
