import 'package:datas/firebase_options.dart';
import 'package:datas/view/Auth/Login.dart';
import 'package:datas/view/Auth/Registration.dart';
import 'package:datas/view/Screen/AnalogCustomClock.dart';
import 'package:datas/view/Screen/CustomClock.dart';
import 'package:datas/view/Screen/SplashScreen.dart';
import 'package:datas/view/Screen/test.dart';
import 'package:datas/viewmodel/Controller/ThemeController.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

void main() async{
   WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    final tc = Get.put(ThemeController());
    return GetMaterialApp(
     
      debugShowCheckedModeBanner: false,
      home: SplashScreen(),
    );
  }
}
