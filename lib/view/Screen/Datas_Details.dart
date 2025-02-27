import 'package:datas/core/resources/colors.dart';
import 'package:datas/viewmodel/Controller/ThemeController.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class Datas_Details extends StatelessWidget {
  final dynamic info;

  Datas_Details({super.key, required this.info});

  @override
  Widget build(BuildContext context) {
    final tc = Get.put(ThemeController());
    var h = Get.height;
    return Scaffold(
      appBar: AppBar(
          backgroundColor: (tc.theme.value) ?  gray:Main,
          title: Text(
            "DATAS",
            style: GoogleFonts.roboto(
                color: bgColor, fontSize: 22, fontWeight: FontWeight.w600),
          ),
          centerTitle: true,
        ),
      body:Center(child: Padding(padding: EdgeInsets.only(left:18),child: Column(
        //mainAxisAlignment: MainAxisAlignment.center,
         // crossAxisAlignment: CrossAxisAlignment.start, 
          children: [
            SizedBox(height: h*0.05,),
           Center(child:  Hero(
              tag: 'DATAS-${info.idNation}',
              child: CircleAvatar(
                radius: 50,
                child: Icon(
                  Icons.person,
                  size: 50,
                ),
              ),
            ),),
            const SizedBox(height: 20),
            Text(
              'Nation: ${info.nation}',
              style: GoogleFonts.ramaraja(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: (tc.theme.value) ? bgColor : Main,
              ),
              textAlign: TextAlign.center, // Center-align text
            ),
            const SizedBox(height: 10),
            Text(
              "ID Nation: ${info.idNation}",
              style: GoogleFonts.roboto(
                fontSize: 18,
                color: (tc.theme.value) ?  bgColor:Main,
              ),
              textAlign: TextAlign.center, 
            ),
            const SizedBox(height: 10),
            Text(
              "Population: ${info.population}",
              style: GoogleFonts.roboto(
                fontSize: 18,
                color: (tc.theme.value) ?  bgColor:Main,
              ),
              textAlign: TextAlign.center, 
            ),
            const SizedBox(height: 10,),
             Text(
              "Year: ${info.year}",
              style: GoogleFonts.roboto(
                fontSize: 18,
                color: (tc.theme.value) ?  bgColor:Main,
              ),
              textAlign: TextAlign.center, 
            ),
            const SizedBox(height: 10,),
             Text(
              "Nation: ${info.nation}",
              style: GoogleFonts.roboto(
                fontSize: 18,
                color: (tc.theme.value) ?  bgColor:Main,
              ),
              textAlign: TextAlign.center, 
            ),
             const SizedBox(height: 10,),
             Text(
              "slug nation: ${info.slugNation}",
              style: GoogleFonts.roboto(
                fontSize: 18,
                color: (tc.theme.value) ? bgColor : Main,
              ),
              textAlign: TextAlign.center, 
            ),
          ],
        ),),)
    );
  }
}
