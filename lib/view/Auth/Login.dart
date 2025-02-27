import 'package:datas/core/resources/colors.dart';
import 'package:datas/view/Auth/Registration.dart';
import 'package:datas/viewmodel/Controller/AuthController.dart';
import 'package:datas/viewmodel/Controller/ThemeController.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../viewmodel/Controller/DatabaseController.dart';

class Login extends StatelessWidget {
  Login({super.key});

  @override
  final EmailController = TextEditingController();
  final passController = TextEditingController();

  Widget build(BuildContext context) {
    var h = Get.height;
    var w = Get.width;
    final AuthController authController = Get.put(AuthController());
    final DatabaseController dc = Get.put(DatabaseController());
    final tc = Get.put(ThemeController());
    return Obx((){return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor:  (tc.theme.value)?Colors.black:bgColor,
      body: SingleChildScrollView(child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: Container(
                  height: 200, child: Image.asset('assets/Login.jpg')),
            ),
            SizedBox(height: 30),
            Text(
              "Login",
              style: TextStyle(
                  fontSize: 28, fontWeight: FontWeight.bold, color: (tc.theme.value)?bgColor:Main),
            ),
            SizedBox(height: 5),
            Text(
              "Please sign in to continue.",
              style: TextStyle(fontSize: 18, color:  (tc.theme.value)?bgColor:Colors.black),
            ),
            SizedBox(height: 30),
            TextField(
              controller: EmailController,
              decoration: InputDecoration(
                labelText: "Email",
                prefixIcon: Icon(
                  Icons.email,
                  color: Main,
                ),
                border:
                    OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
              ),
            ),
            SizedBox(height: 20),
            Obx((){return TextField(
              enableInteractiveSelection: false,
              obscureText: authController.toogle.value,
              controller: passController,
              decoration: InputDecoration(
                labelText: "Password",
                prefixIcon: Icon(
                  Icons.lock,
                  color: Main,
                ),
                suffixIcon: 
                  IconButton(
                    onPressed: () {
                      authController.togglePasswordVisibility();
                    },
                    icon: (authController.toogle.value)
                        ? Icon(
                            Icons.visibility_off,
                            color: Main,
                          )
                        : Icon(
                            Icons.visibility,
                            color: Main,
                          ),
                  ),
                
                border:
                    OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
              ),
            );}),
            SizedBox(height: 10),
            /*Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Checkbox(value: false, onChanged: (value) {}),
                    Text("Remember me"),
                  ],
                ),
                TextButton(
                  onPressed: () {},
                  child: Text(
                    "Forgot Password?",
                    style: TextStyle(color: Main),
                  ),
                ),
              ],
            ),*/
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                authController.login(EmailController.text, passController.text);
                dc.fetchUserData(EmailController.text);
                EmailController.clear();
                passController.clear();
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: gray,
                minimumSize: Size(double.infinity, 50),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10)),
              ),
              child:
                  Text("Sign In", style: TextStyle(fontSize: 16, color: Main)),
            ),
            SizedBox(height: 10),
            Center(
              child: TextButton(
                onPressed: () {
                  Get.to(Registration());
                },
                child: Text(
                  "Don't have an account? Sign Up",
                  style: TextStyle(color:  (tc.theme.value)?bgColor:Main),
                ),
              ),
            ),
          ],
        ),
      ),)
    );});
  }
}
