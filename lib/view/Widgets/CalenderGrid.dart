import 'package:datas/viewmodel/Controller/CalenderController.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CalendarGrid extends StatelessWidget {
  final controller = Get.put(CalendarController());

  @override
  Widget build(BuildContext context) {
    return Obx(() {
     print("UI rebuilt with selected date: ${controller.selectedDate.value}");
int totalDays = controller.daysInMonth(controller.currentDate.value);
      int offset = controller.firstDayOffset(controller.currentDate.value);
      int gridItems = totalDays + offset;
      return Expanded(
        child: GridView.builder(
          gridDelegate:
              SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 7),
          itemCount: gridItems,
          itemBuilder: (context, index) {
            if (index < offset) return SizedBox(); 

            int day = index - offset + 1;
            bool isToday = controller.isToday(day);
            bool isSelected = 
                controller.selectedDate.value.day == day &&
                controller.selectedDate.value.month ==
                    controller.currentDate.value.month &&
                controller.selectedDate.value.year ==
                    controller.currentDate.value.year;

            return GestureDetector(onTap: () {
              controller.selectDate(day);
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  backgroundColor:
                      controller.isWeekend(day) ? Colors.orange : Colors.teal,
                  duration: Duration(seconds: 3),
                  content: Text(
                    "Date Selected: ${day}/${controller.currentDate.value.month}/${controller.currentDate.value.year}",
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              );
            }, child: Obx(() {
              return Container(
                margin: EdgeInsets.all(6),
                decoration: BoxDecoration(
                  color: 
                      isToday
                          ? Colors.teal
                          : isSelected
                      ? Colors.blue:Colors.transparent,
                  shape: BoxShape.circle,
                ),
                child: Center(
                  child: Text(
                    "$day",
                    style: TextStyle(
                      fontSize: 17,
                      fontWeight: FontWeight.bold,
                      color: controller.isWeekend(day)
                          ? Colors.orange
                          :isToday?Colors.white: isSelected?Colors.white:Colors.black,
                    ),
                  ),
                ),
              );
            }));
          },
        ),
      );
    });
  }
}
