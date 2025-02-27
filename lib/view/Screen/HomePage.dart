import 'package:datas/core/resources/colors.dart';
import 'package:datas/view/Screen/AnalogCustomClock.dart';
import 'package:datas/view/Screen/CustomCalender.dart';
import 'package:datas/view/Screen/CustomClock.dart';
import 'package:datas/view/Screen/Datas_Details.dart';
import 'package:datas/view/Screen/Profile.dart';
import 'package:datas/view/Screen/Users_Reg_List.dart';
import 'package:datas/viewmodel/Controller/ApiService.dart';
import 'package:datas/viewmodel/Controller/ThemeController.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final ApiServiceController controller = Get.put(ApiServiceController());
    final tc = Get.put(ThemeController());
    controller.fetchData();
    return Obx(() {
      return Scaffold(
        backgroundColor: (tc.theme.value) ? bgDark : Main,
        drawer: Drawer(
          backgroundColor: bgColor,
          child: ListView(
            children: [
              DrawerHeader(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      (tc.theme.value) ? Colors.black : Main,
                      (tc.theme.value) ? Colors.grey.shade800 : Main
                    ],
                  ),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CircleAvatar(
                      radius: 40,
                      backgroundColor:
                          tc.theme.value ? mainDark : Colors.lightGreenAccent,
                      child: Text(
                        "A",
                        style: TextStyle(
                          fontSize: 35.0,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                    ),
                    const SizedBox(height: 10),
                    Text(
                      "Aman Nafiz",
                      style: GoogleFonts.roboto(
                        fontSize: 20,
                        fontWeight: FontWeight.w700,
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
              ),
              _buildDrawerItem(
                icon: Icons.calendar_today,
                text: "Calender",
                onTap: () {
                  Get.to(
                    CustomCalendar(),
                    transition: Transition.zoom,
                    duration: Duration(seconds: 2),
                  );
                },
              ),
              _buildDrawerItem(
                icon: Icons.access_time,
                text: "Clock",
                onTap: () {
                  Get.to(
                    DigitalClockScreen(),
                    transition: Transition.downToUp,
                    duration: Duration(seconds: 2),
                  );
                },
              ),
              _buildDrawerItem(
                icon: Icons.watch_later_outlined,
                text: "Analog Clock",
                onTap: () {
                  Get.to(
                    AnalogClockScreen(),
                    transition: Transition.topLevel,
                    duration: Duration(seconds: 2),
                  );
                },
              ),
              _buildDrawerItem(
                icon: Icons.list,
                text: "Users List",
                onTap: () {
                  Get.to(Users_List());
                },
              ),
              _buildDrawerItem(
                icon: Icons.person,
                text: "Profile",
                onTap: () {
                  Get.to(
                    Profile(),
                    transition: Transition.leftToRight,
                    duration: Duration(seconds: 1),
                  );
                },
              ),
              const Divider(),
              ListTile(
                leading: Icon(
                  tc.theme.value ? Icons.dark_mode : Icons.light_mode,
                  color: tc.theme.value ? Colors.white : Colors.black87,
                ),
                title: Text(
                  "Toggle Theme",
                  style: TextStyle(
                    color: tc.theme.value ? Colors.white : Colors.black87,
                    fontSize: 17,
                  ),
                ),
                trailing: Switch(
                  value: tc.theme.value,
                  onChanged: (value) {
                    tc.ChangeTheme();
                  },
                ),
              ),
            ],
          ),
        ),
        appBar: AppBar(
          backgroundColor: (tc.theme.value) ? gray : bgColor,
          title: Text(
            "DATAS",
            style: GoogleFonts.roboto(
                color: Main, fontSize: 22, fontWeight: FontWeight.w600),
          ),
          centerTitle: true,
        ),
        body: Obx(() {
          if (controller.isLoading.value == false) {
            return Center(
                child: CircularProgressIndicator(
              backgroundColor: Colors.purpleAccent,
            ));
          }
          return ListView.builder(
              itemCount: controller.datas.length,
              itemBuilder: (context, index) {
                var aa = controller.datas[index];
                return Padding(
                    padding: EdgeInsets.all(10),
                    child: InkWell(
                      hoverColor: Colors.purpleAccent,
                      onTap: () {
                        Get.to(
                            Datas_Details(
                              info: aa,
                            ),
                            duration: Duration(seconds: 666),
                            transition: Transition.fade);
                      },
                      child: Hero(
                        tag: 'DATAS-${aa.idNation}',
                        child: Card(
                          color: (tc.theme.value) ? grayDark : bgColor,
                          elevation: 4,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(15)),
                          child: ListTile(
                            leading: CircleAvatar(
                              child: Icon(
                                Icons.person,
                                size: 35,
                              ),
                              radius: 28,
                            ),
                            title: Text(
                              'Nation : ${aa.nation}',
                              style: GoogleFonts.ramaraja(
                                  color:
                                      (tc.theme.value) ? bgColor : Colors.black,
                                  fontSize: 21,
                                  fontWeight: FontWeight.w700),
                            ),
                            subtitle: Text(
                              "ID Nation: ${aa.idNation}\nID Year: ${aa.idNation}\nYear: ${aa.nation}\nPopulation: ${aa.population}\nSlug Nation: ${aa.slugNation}",
                              style: GoogleFonts.ramaraja(
                                  color: (tc.theme.value)
                                      ? bgColor
                                      : Colors.black87,
                                  fontSize: 17,
                                  fontWeight: FontWeight.w500),
                            ),
                          ),
                        ),
                      ),
                    ));
              });
        }),
      );
    });
  }

  Widget _buildDrawerItem({
    required IconData icon,
    required String text,
    required VoidCallback onTap,
  }) {
    return ListTile(
      leading: Icon(
        icon,
        color: Colors.black,
      ),
      title: Text(
        text,
        style: GoogleFonts.roboto(
          fontSize: 17,
          fontWeight: FontWeight.w500,
          color: Colors.black87,
        ),
      ),
      onTap: onTap,
    );
  }
}
