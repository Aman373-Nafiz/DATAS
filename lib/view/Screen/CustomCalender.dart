import 'package:datas/core/resources/colors.dart';
import 'package:datas/view/Widgets/CalenderGrid.dart';
import 'package:datas/view/Widgets/MonthYear.dart';
import 'package:datas/view/Widgets/WeekDaysHeader.dart';
import 'package:datas/viewmodel/Controller/CalenderController.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class CustomCalendar extends StatelessWidget {
  @override
  final calendarController = Get.put(CalendarController()); 
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Main,
          title: Text(
            "DATAS",
            style: GoogleFonts.roboto(
                color: bgColor, fontSize: 22, fontWeight: FontWeight.w600),
          ),
          centerTitle: true,
        ),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 20),
            Obx(
              () => Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  IconButton(
                    icon: Icon(
                      Icons.arrow_left,
                      color: Colors.black,
                      size: 28,
                    ),
                    onPressed: calendarController.goToPreviousMonth,
                  ),
                  GestureDetector(
                  onTap: () async {
                    final selectedDate = await showDialog<Map<String, int>>(
                      context: context,
                      builder: (context) => MonthYearDialog(
                        initialYear: calendarController.currentDate.value.year,
                        initialMonth: calendarController.currentDate.value.month,
                      ),
                    );

                    if (selectedDate != null) {
                      calendarController.currentDate.value = DateTime(
                        selectedDate['year']!,
                        selectedDate['month']!,
                      );
                    }
                  },
                  child: Center(
                    child: Text(
                      "${calendarController.getMonthName(calendarController.currentDate.value.month)} ${calendarController.currentDate.value.year}",
                      style: TextStyle(
                        fontSize: 21,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                    ),
                  ),
                ),
                  IconButton(
                    icon: Icon(
                      Icons.arrow_right,
                      color: Colors.black,
                      size: 28,
                    ),
                    onPressed: calendarController.goToNextMonth,
                  ),
                ],
              ),
            ),
            SizedBox(height: 20),
            WeekDaysHeader(),
            CalendarGrid(),
          ],
        ),
      ),
    );
  }
}
