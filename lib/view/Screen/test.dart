import 'package:datas/core/resources/colors.dart';
import 'package:datas/viewmodel/Controller/DatabaseController.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

class Test extends StatelessWidget {
  const Test({super.key});

  @override
  Widget build(BuildContext context) {
    final EmailController = TextEditingController();
    final DatabaseController dc = Get.put(DatabaseController());
    return Scaffold(
      body: Column(
        children: [
          Center(
            child: TextField(
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
          ),
          SizedBox(height: 12,),
         ElevatedButton(
              onPressed: () {
               dc.CheckMail(EmailController.text);
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
        ],
      ),
    );
  }
}
