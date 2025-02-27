import 'package:datas/view/Screen/HomePage.dart';
import 'package:datas/viewmodel/Controller/AuthController.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../core/resources/colors.dart';

class OtpVerification extends StatelessWidget {
  OtpVerification({super.key});

  @override
  Widget build(BuildContext context) {
    TextEditingController txt1 = TextEditingController();
    TextEditingController txt2 = TextEditingController();
    TextEditingController txt3 = TextEditingController();
    TextEditingController txt4 = TextEditingController();
    TextEditingController txt5 = TextEditingController();
    TextEditingController txt6 = TextEditingController();
     final authController = Get.put(AuthController());
    var h = Get.height;
    var w = Get.width;
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            height: h * 0.086,
          ),
          Text(
            "OTP VERIFICATION",
            style: GoogleFonts.roboto(
                color: Main, fontSize: 21, fontWeight: FontWeight.w600),
          ),
          Center(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                myInputBox(context, txt1),
                myInputBox(context, txt2),
                myInputBox(context, txt3),
                myInputBox(context, txt4),
                myInputBox(context, txt5),
                myInputBox(context, txt6),
              ],
            ),
          ),
            SizedBox(
                      height: h * 0.256,
                    ),
                         
                      ElevatedButton(
              onPressed: () async{
                var Mycode =
                            txt1.text + txt2.text + txt3.text + txt4.text+txt5.text+txt6.text;
                            print(Mycode);
                       var check = await authController.verifyOTP( Mycode);
                        if(check){
                         Get.to(HomePage());
                        }
                        else{
                          Get.snackbar("Failed", "Phone Auth");
                        }
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: gray,
                minimumSize: Size(double.infinity, 50),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10)),
              ),
              child:
                  Text("Sent", style: TextStyle(fontSize: 16, color: Main)),
            ),
        ],
      ),
    );
  }

  Widget myInputBox(BuildContext context, TextEditingController controller) {
    return Container(
      height: 70,
      width: 50,
      child: TextField(
        controller: controller,
        maxLength: 1,
        textAlign: TextAlign.center,
        keyboardType: TextInputType.number,
        style: const TextStyle(fontSize: 40),
        decoration: const InputDecoration(
          counterText: '',
        ),
        onChanged: (value) {
          if (value.length == 1) {
            FocusScope.of(context).nextFocus();
          }
        },
      ),
    );
  }
}
