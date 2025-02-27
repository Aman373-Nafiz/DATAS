import 'dart:math';
import 'package:datas/core/resources/colors.dart';
import 'package:datas/viewmodel/Controller/ClockController.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'dart:async';

import 'package:google_fonts/google_fonts.dart';

class AnalogClockScreen extends StatelessWidget {
  AnalogClockScreen({super.key});
  final controller = Get.put(ClockController());

  @override
  Widget build(BuildContext context) {
    controller.onInit();
    return Scaffold(
      backgroundColor: Colors.black,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Obx(() {
            return Center(child: Text(
              controller.currentTime.value,
              style: GoogleFonts.shareTechMono(
                fontSize: 60,
                fontWeight: FontWeight.w800,
                color: Main,
              ),
            ),);
          }),
          SizedBox(height: 22,),
          Center(
              child: Container(
                  height: 400,
                  width: 400,
                  child: Obx(() {
                    return CustomPaint(
                      painter:
                          AnalogClockPainter(now: controller.CurrentTime.value),
                    );
                  })))
        ],
      ),
    );
  }
}

class AnalogClockPainter extends CustomPainter {
  var now;

  AnalogClockPainter({required this.now});

  void paint(Canvas canvas, Size size) {
    Offset offset = Offset(size.width / 2, size.height / 2);
    var rad = min(size.width / 2, size.height / 2);

    Paint MainFrame = Paint()..color = Colors.white;

    Paint border = Paint()
      ..style = PaintingStyle.stroke
      ..color = Main
      ..strokeWidth = 8;

    Paint point = Paint()..color = Main..strokeWidth = 9;

    Paint HourHand = Paint()
      ..color = Colors.black
      ..style = PaintingStyle.stroke
      ..strokeWidth = 8;

    Paint MinHand = Paint()
      ..color = Main
      ..style = PaintingStyle.stroke
      ..strokeWidth = 6;

    Paint SecHand = Paint()
      ..color = Colors.red
      ..style = PaintingStyle.stroke
      ..strokeWidth = 5;

    // Clock body structure
    canvas.drawCircle(offset, rad, MainFrame);
    canvas.drawCircle(offset, rad, border);
    canvas.drawCircle(offset, 10.0, point);
// H,s,m
    final hour = now.hour % 12;
    final minute = now.minute;
    final second = now.second;

    // Angle for Hour,min,secs
    final hourAngle = (hour + minute / 60) * pi / 6 - pi / 2;
    final minAngle = minute * pi / 30 - pi / 2;
    final secAngle = second * pi / 30 - pi / 2;

    // Hand lenth/size for hour,min and secs
    final hourHandLength = rad * 0.45;
    final minuteHandLength = rad * 0.65;
    final secondHandLength = rad * 0.75;

    // Coordinated fro Houur,Min,Secs
    final hourX = offset.dx + cos(hourAngle) * hourHandLength;
    final hourY = offset.dy + sin(hourAngle) * hourHandLength;
    final minX = offset.dx + cos(minAngle) * minuteHandLength;
    final minY = offset.dy + sin(minAngle) * minuteHandLength;
    final secX = offset.dx + cos(secAngle) * secondHandLength;
    final secY = offset.dy + sin(secAngle) * secondHandLength;

    // Visualize the hands of 3 time line
    canvas.drawLine(offset, Offset(hourX, hourY), HourHand);
    canvas.drawLine(offset, Offset(minX, minY), MinHand);
    canvas.drawLine(offset, Offset(secX, secY), SecHand);

    // Draw numbers
    for (int i = 1; i <= 12; i++) {
      final angle = (i - 3) * pi / 6; // -pi to pi
      final RadiusD = rad * 0.85; // distance between points
      final numberPosition = Offset(
        offset.dx + cos(angle) * RadiusD,
        offset.dy + sin(angle) * RadiusD,
      );

      final textPainter = TextPainter(
        text: TextSpan(
          text: i.toString(),
          style: TextStyle(
            color: Colorr[m[i]!],
            fontSize: 24,
            fontWeight: FontWeight.bold,
          ),
        ),
        textDirection: TextDirection.ltr,
        textAlign: TextAlign.center,
      );

      textPainter.layout();
      final textOffset = Offset(
        numberPosition.dx - textPainter.width / 2,
        numberPosition.dy - textPainter.height / 2,
      );

      textPainter.paint(canvas, textOffset);
    }
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => true;
}
