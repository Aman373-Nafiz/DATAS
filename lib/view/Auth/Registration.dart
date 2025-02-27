import 'package:datas/core/resources/colors.dart';
import 'package:datas/view/Auth/Login.dart';
import 'package:datas/viewmodel/Controller/AuthController.dart';
import 'package:datas/viewmodel/Controller/DatabaseController.dart';
import 'package:datas/viewmodel/Controller/ThemeController.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl_phone_field/intl_phone_field.dart';

class Registration extends StatelessWidget {
  const Registration({super.key});

  @override
  Widget build(BuildContext context) {
    final emailController = TextEditingController();
    final passwordController = TextEditingController();
    final addressController = TextEditingController();
    final usernameController = TextEditingController();
    String phone = "";
    final authController = Get.put(AuthController());
    final databaseController = Get.put(DatabaseController());
    final themeController = Get.put(ThemeController());

    return Obx(() {
      return Scaffold(
        backgroundColor: (themeController.theme.value) ? Colors.black : bgColor,
        resizeToAvoidBottomInset: true,
        body: SingleChildScrollView(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: Get.height * 0.05),
              Center(
                child: Container(
                  height: Get.height * 0.25,
                  child: Image.asset(
                    'assets/Register.jpg',
                    fit: BoxFit.contain,
                  ),
                ),
              ),
              SizedBox(height: 15),
              Text(
                "Register",
                style: TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                  color: (themeController.theme.value) ? bgColor : Main,
                ),
              ),
              SizedBox(height: 5),
              Text(
                "Please register to login.",
                style: TextStyle(
                  fontSize: 18,
                  color: (themeController.theme.value) ? bgColor : Colors.black,
                ),
              ),
              SizedBox(height: 20),
              TextField(
                controller: usernameController,
                decoration: InputDecoration(
                  labelText: "Username",
                  prefixIcon: Icon(
                    Icons.person,
                    color: Main,
                  ),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
              ),
              SizedBox(height: 20),
              IntlPhoneField(
                decoration: InputDecoration(
                  labelText: 'Phone Number',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: BorderSide(),
                  ),
                ),
                initialCountryCode: 'BD',
                onChanged: (phoneNumber) {
                  phone = phoneNumber.completeNumber;
                },
              ),
              TextFormField(
                keyboardType: TextInputType.emailAddress,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "Email address is invalid";
                  }
                  if (!RegExp(r'^[^@]+@[^@]+\.[^@]+').hasMatch(value)) {
                    return "Enter a valid email";
                  }
                  return null;
                },
                controller: emailController,
                decoration: InputDecoration(
                  labelText: "Email",
                  prefixIcon: Icon(
                    Icons.email,
                    color: Main,
                  ),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
              ),
              SizedBox(height: 20),
              TextField(
                controller: addressController,
                decoration: InputDecoration(
                  labelText: "Address",
                  prefixIcon: Icon(
                    Icons.home,
                    color: Main,
                  ),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
              ),
              SizedBox(height: 20),
              TextField(
                obscureText: true,
                controller: passwordController,
                decoration: InputDecoration(
                  labelText: "Password",
                  prefixIcon: Icon(
                    Icons.lock,
                    color: Main,
                  ),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: () async {
                  if (phone.isEmpty) {
                    Get.snackbar('Error', 'Please enter a valid phone number!');
                    return;
                  }

                
                  authController.phone.value = phone;
                  await authController.register(
                    usernameController.text,
                    passwordController.text,
                    emailController.text,
                    phone,
                    addressController.text,
                  );

                  usernameController.clear();
                  passwordController.clear();
                  emailController.clear();
                  addressController.clear();
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: gray,
                  minimumSize: Size(double.infinity, 50),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                child: Text("Sign Up", style: TextStyle(fontSize: 16, color: Main)),
              ),
              SizedBox(height: 10),
              Center(
                child: TextButton(
                  onPressed: () {
                    Get.to(() => Login());
                  },
                  child: Text(
                    "Already have an account? Sign In",
                    style: TextStyle(
                      color: (themeController.theme.value) ? bgColor : Colors.black,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      );
    });
  }
}