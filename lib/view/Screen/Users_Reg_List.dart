import 'package:datas/core/resources/colors.dart';
import 'package:datas/viewmodel/Controller/DatabaseController.dart';
import 'package:datas/viewmodel/Controller/ThemeController.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:google_fonts/google_fonts.dart';

class Users_List extends StatelessWidget {
  const Users_List({super.key});

  @override
  Widget build(BuildContext context) {
    final DatabaseController dc = Get.put(DatabaseController());
    final tc = Get.put(ThemeController());
    dc.FetchData();
    var users = dc.userslist;
    return Obx(() {
      return Scaffold(
          backgroundColor: (tc.theme.value) ? bgDark : Main,
          appBar: AppBar(
            backgroundColor: (tc.theme.value) ? gray : bgColor,
            title: Text(
              "DATAS",
              style: GoogleFonts.roboto(
                  color: Main, fontSize: 22, fontWeight: FontWeight.w600),
            ),
            centerTitle: true,
          ),
          body: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
  children: [
    Padding(padding: EdgeInsets.only(left:15,top:15),child: Text(
      "Registered Users List",
      style: GoogleFonts.roboto(
          color: bgColor, fontSize: 25, ),
    ),),
    SizedBox(height: 12),
    Expanded( 
      child: Obx(() {
        return ListView.builder(
          itemCount: dc.userslist.length,
          itemBuilder: (context, index) {
            final user = dc.userslist[index];
            return Padding(
              padding: const EdgeInsets.all(8),
              child: Container(
                decoration: BoxDecoration(color: bgColor,borderRadius: BorderRadius.circular(10),boxShadow: [BoxShadow(color: grayDark.withAlpha(1),blurRadius: 2,blurStyle: BlurStyle.solid,spreadRadius: 3,offset: Offset(2, 3))]),
                
                child: ListTile(
                  title: Text(
                    "Username: ${user['username']}",
                    style: GoogleFonts.roboto(
                        fontSize: 23, fontWeight: FontWeight.w700),
                  ),
                  subtitle: Text(
                    "Email: ${user['email']}\nPhone: ${user['phone']}\nAddress: ${user['address']}",
                    style: GoogleFonts.roboto(
                        fontSize: 16, color: Colors.black),
                  ),
                  isThreeLine: true,
                ),
              ),
            );
          },
        );
      }),
    ),
  ],
),);
    });
  }
}
