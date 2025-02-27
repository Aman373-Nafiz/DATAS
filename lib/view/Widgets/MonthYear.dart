import 'package:datas/viewmodel/Controller/CalenderController.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

class MonthYearDialog extends StatelessWidget {
  final int initialYear;
  final int initialMonth;

  MonthYearDialog({
    Key? key,
    required this.initialYear,
    required this.initialMonth,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final calendarController = Get.put(CalendarController());
    int selectedYear = initialYear;
    int selectedMonth = initialMonth;

    return AlertDialog(
      title: Text("Select Month and Year"),
      content: StatefulBuilder(
        builder: (context, setState) {
          return Column(
            mainAxisSize: MainAxisSize.min,
            children: [
             
              DropdownButton<int>(
                value: selectedYear,
                items: List.generate(
                  50,
                  (index) => DateTime.now().year - 25 + index,
                ).map((year) {
                  return DropdownMenuItem(
                    value: year,
                    child: Text("$year"),
                  );
                }).toList(),
                onChanged: (year) {
                  
                    selectedYear = year!;
                  
                },
              ),
              SizedBox(height: 10),

              
              DropdownButton<int>(
                value: selectedMonth,
                items: List.generate(12, (index) => index + 1).map((month) {
                  return DropdownMenuItem(
                    value: month,
                    child: Text(
                      calendarController.getMonthName(month),
                    ),
                  );
                }).toList(),
                onChanged: (month) {
                  
                    selectedMonth = month!;
                  
                },
              ),
            ],
          );
        },
      ),
      actions: [
        TextButton(
          onPressed: () {
            Navigator.of(context).pop(); 
          },
          child: Text("Cancel"),
        ),
        TextButton(
          onPressed: () {
            Navigator.of(context).pop({
              'year': selectedYear,
              'month': selectedMonth,
            }); 
          },
          child: Text("OK"),
        ),
      ],
    );
  }
}
