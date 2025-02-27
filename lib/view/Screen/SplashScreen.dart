import 'dart:async';

import 'package:datas/core/resources/colors.dart';
import 'package:datas/view/Auth/Login.dart';
import 'package:datas/viewmodel/Controller/ThemeController.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:google_fonts/google_fonts.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Timer(
        Duration(seconds: 3),
        () => Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (context) => Login())));
  }

  Widget build(BuildContext context) {
    final tc = Get.put(ThemeController());
    return Scaffold(
        backgroundColor: (tc.theme.value) ? bgDark : Main,
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: Container(
                height: 300,
                width: 300,
                decoration:
                    BoxDecoration(shape: BoxShape.circle, color:(tc.theme.value)?gray: bgColor),
                child: Center(
                  child: Image.asset(
                    'assets/data_strategy_alt.png',
                    height: 150,
                    width: 150,
                    fit: BoxFit.contain,
                  ),
                ),
              ),
            ),
            SizedBox(height: 25,),
           Center(child:  Text('DATAS',style: GoogleFonts.roboto(color: Colors.white,fontSize: 32,letterSpacing: 1,fontWeight: FontWeight.w600),),)
          ],
        ));
  }
}
