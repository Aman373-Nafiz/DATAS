import 'package:datas/core/resources/colors.dart';
import 'package:datas/viewmodel/Controller/DatabaseController.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class Profile extends StatelessWidget {
  const Profile({super.key});

  @override
  Widget build(BuildContext context) {
    var h = MediaQuery.sizeOf(context).height;
    var w = MediaQuery.sizeOf(context).width;

    
    final DatabaseController dc = Get.put(DatabaseController());

 


    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Profile",
          style: GoogleFonts.roboto(fontSize: 24, color: bgColor),
        ),
        backgroundColor: Main,
      ),
      body: Obx(() {
  
     
        
        return Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: h * 0.1,
              ),
              Center(
                child: CircleAvatar(
                  radius: 50,
                  backgroundColor: Main,
                  child: Center(
                    child: Text(
                      '${dc.userData['name']?.substring(0, 1).toUpperCase() ?? ''}',
                      style: GoogleFonts.roboto(
                        fontSize: 40,
                        fontWeight: FontWeight.bold,
                        color: bgColor,
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(height: 20),
              Text(
                 "Name : ${ dc.userData['username'] ?? 'Name not available'}",
                  style: GoogleFonts.roboto(fontSize: 22, fontWeight: FontWeight.bold),
                ),
             
              SizedBox(height: 20),
              Text(
                "Email: ${dc.userData['email'] ?? 'N/A'}",
                style: GoogleFonts.roboto(fontSize: 18),
              ),
              SizedBox(height: 10),
              Text(
                "Phone: ${dc.userData['phone'] ?? 'N/A'}",
                style: GoogleFonts.roboto(fontSize: 18),
              ),
              SizedBox(height: 10),
              Text(
                "Address: ${dc.userData['address'] ?? 'N/A'}",
                style: GoogleFonts.roboto(fontSize: 18),
              ),
            ],
          ),
        );
      }),
    );
  }
}
