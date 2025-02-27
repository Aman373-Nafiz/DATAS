import 'package:datas/core/resources/colors.dart';
import 'package:datas/viewmodel/Controller/ClockController.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:google_fonts/google_fonts.dart';

class DigitalClockScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    
    final clockController = Get.put(ClockController());

    return Scaffold(
        appBar: AppBar(backgroundColor: Main, title: Text(
          "DATAS",
          style: GoogleFonts.roboto(
              color: bgColor, fontSize: 22, fontWeight: FontWeight.w600),
        ),
        centerTitle: true,),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            //SizedBox(height: 35,),
            Center(child: Obx(() {
                return Text(
                  clockController.currentTime.value,
                  style: GoogleFonts.shareTechMono(
                    fontSize: 60,
                    fontWeight: FontWeight.w800,
                    color: Main,
                  ),
                );
              }),)
          ],
        ));
  }
}
