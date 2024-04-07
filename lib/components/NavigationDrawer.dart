import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:mentor_match/components/NavigationBarItem.dart';
import 'package:mentor_match/home_pages/student/AllTutoringSessions.dart';
import 'package:mentor_match/home_pages/student/HomeAllGroups.dart';
import 'package:mentor_match/home_pages/student/JoinAnotherGroup.dart';
import 'package:mentor_match/home_pages/student/JoinGroup.dart';
import 'package:mentor_match/home_pages/student/PendingSessions.dart';
import 'package:mentor_match/home_pages/student/RequestTutor.dart';
import 'package:mentor_match/home_pages/student/StudentHomeBase.dart';
import 'package:mentor_match/home_pages/student/StudentProfile.dart';
import 'package:mentor_match/home_pages/student/student_home.dart';

class NavDrawer extends StatefulWidget {
  final String currentPage; 
  const NavDrawer({super.key, required this.currentPage});

  @override
  State<NavDrawer> createState() => _NavDrawerState();
}

class _NavDrawerState extends State<NavDrawer> {
  @override
  Widget build(BuildContext context) {
    return Drawer(
        child: Container(
      color: Colors.white,
      child: Column(children: [
        Container(
            height: MediaQuery.of(context).size.height * 0.1,
            width: MediaQuery.of(context).size.width * 0.85,
            child: SafeArea(
              bottom: false,
              child: Align(
                alignment: Alignment.bottomLeft,
                child: Padding(
                  padding: const EdgeInsets.only(left: 32),
                  child: SvgPicture.asset("assets/images/undraw_profile_re_4a55.svg"),
                ),
              ),
            )),
        Expanded(
          flex: 2,
          child: ListView(
            padding: EdgeInsets.only(top: 24, left: 16, right: 16),
            children: [
              DrawerTile(
                  icon: Icons.home,
                  onTap: () {
                    if (widget.currentPage != "Home") 
                      WidgetsBinding.instance.addPostFrameCallback((timeStamp) {  
                          Navigator.of(context).pop(); 
                          Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => StudentHomeLoaded()));
                      });
                  },
                  iconColor: Colors.black,
                  title: "Home",
                  isSelected: widget.currentPage == "Home" ? true : false),
              DrawerTile(
                  icon: Icons.pie_chart,
                  onTap: () {
                    if (widget.currentPage != "All Sessions") 
                      WidgetsBinding.instance.addPostFrameCallback((timeStamp) {  
                          Navigator.of(context).pop();

                          Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => AllTutoringSessions()));
                      });

                  },
                  iconColor: Colors.yellow,
                  title: "All Sessions",
                  isSelected: widget.currentPage == "All Sessions" ? true : false),
              DrawerTile(
                  icon: Icons.account_circle,
                  onTap: () {
                    // if (currentPage != "Account")
                    //   Navigator.pushReplacementNamed(context, '/account');
                  },
                  iconColor: Colors.black,
                  title: "Account",
                  isSelected: widget.currentPage == "Account" ? true : false),
              DrawerTile(
                  icon: Icons.settings_input_component,
                  onTap: () {
                    // if (currentPage != "Elements")
                    //   Navigator.pushReplacementNamed(context, '/elements');
                  },
                  iconColor: Colors.red,
                  title: "Elements",
                  isSelected: widget.currentPage == "Elements" ? true : false),
              DrawerTile(
                  icon: Icons.apps,
                  onTap: () {
                    // if (currentPage != "Articles")
                    //   Navigator.pushReplacementNamed(context, '/articles');
                  },
                  iconColor: Colors.blue,
                  title: "Articles",
                  isSelected: widget.currentPage == "Articles" ? true : false),
            ],
          ),
        ),
        Expanded(
          flex: 1,
          child: Container(
              padding: EdgeInsets.only(left: 8, right: 16),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Divider(height: 4, thickness: 0, color: Colors.grey),
                  Padding(
                    padding:
                        const EdgeInsets.only(top: 16.0, left: 16, bottom: 8),
                    child: Text("DOCUMENTATION",
                        style: TextStyle(
                          color: Color.fromRGBO(0, 0, 0, 0.5),
                          fontSize: 15,
                        )),
                  ),
                ],
              )),
        ),
      ]),
    ));
    // return Drawer(
    //     child: Container(
    //   color: Colors.white, 
    //   child: Column(children: [
    //     Container(
    //         height: MediaQuery.of(context).size.height * 0.1,
    //         width: MediaQuery.of(context).size.width * 0.85,
    //         child: SafeArea(
    //           bottom: false,
    //           child: Align(
    //             alignment: Alignment.bottomLeft,
    //             child: Padding(
    //               padding: const EdgeInsets.only(left: 32),
    //               child: SvgPicture.asset("assets/images/undraw_profile_re_4a55.svg"),
    //             ),
    //           ),
    //         )),
    //     Expanded(
    //       flex: 2,
    //       child: ListView(
    //         padding: EdgeInsets.only(top: 24, left: 16, right: 16),
    //         children: [
    //           DrawerTile(
    //               icon: Icons.home,
    //               onTap: () {
    //                 if (currentPage != "Home") {
    //                   WidgetsBinding.instance.addPostFrameCallback((timeStamp) {  
    //                      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => StudentHomeLoaded()));
    //                   });
    //                 }
    //               },
    //               iconColor: Color.fromRGBO(108, 99, 255, 1),
    //               title: "Home",
    //               isSelected: currentPage == "Home" ? true : false),
    //           DrawerTile(
    //               icon: Icons.view_agenda,
    //               onTap: () {
    //                 if (currentPage != "All Sessions") {
    //                   WidgetsBinding.instance.addPostFrameCallback((timeStamp) {  
    //                     Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => AllTutoringSessions()));
    //                   });
    //                 }
    //               },
    //               iconColor: Color.fromRGBO(108, 99, 255, 1),
    //               title: "All Sessions",
    //               isSelected: currentPage == "All Sessions" ? true : false),
    //           DrawerTile(
    //               icon: Icons.account_circle,
    //               onTap: () {
    //                 if (currentPage != "Join Group") {
    //                   WidgetsBinding.instance.addPostFrameCallback((timeStamp) {  
    //                     Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => JoinAnotherGroup(uid: FirebaseAuth.instance.currentUser!.uid,)));
    //                   });
    //                 }
    //               },
    //               iconColor: Color.fromRGBO(108, 99, 255, 1),
    //               title: "Join Group",
    //               isSelected: currentPage == "Join Group" ? true : false),
    //           DrawerTile(
    //               icon: Icons.settings_input_component,
    //               onTap: () {
    //                 if (currentPage != "Pending Sessions") {
    //                   WidgetsBinding.instance.addPostFrameCallback((timeStamp) {  
    //                     Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => PendingSessions()));
    //                   });
    //                 }
    //               },
    //               iconColor: Color.fromRGBO(108, 99, 255, 1),
    //               title: "Pending Sessions",
    //               isSelected: currentPage == "Pending Sessions" ? true : false),
    //           DrawerTile(
    //               icon: Icons.apps,
    //               onTap: () {
    //                 if (currentPage != "Request Session") {
    //                   WidgetsBinding.instance.addPostFrameCallback((timeStamp) {  
    //                     Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => RequestTutor()));
    //                   });
    //                 }
    //               },
    //               iconColor: Color.fromRGBO(108, 99, 255, 1),
    //               title: "Request Session",
    //               isSelected: currentPage == "Request Session" ? true : false),
    //         ],
    //       ),
    //     ),
    //     Expanded(
    //       flex: 1,
    //       child: Container(
    //           padding: EdgeInsets.only(left: 8, right: 16),
    //           child: Column(
    //             mainAxisAlignment: MainAxisAlignment.start,
    //             crossAxisAlignment: CrossAxisAlignment.start,
    //             children: [
    //               Divider(height: 4, thickness: 0, color: Colors.grey[400]),
    //               Padding(
    //                 padding:
    //                     const EdgeInsets.only(top: 16.0, left: 16, bottom: 8),
    //                 child: Text("ACTIONS",
    //                     style: TextStyle(
    //                       color: Color.fromRGBO(0, 0, 0, 0.5),
    //                       fontSize: 15,
    //                     )),
    //               ),
    //               DrawerTile(
    //                   icon: Icons.account_circle,
    //                   onTap: (){
    //                     if (currentPage != "Profile") {
    //                       WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
    //                         Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => StudentProfile()));
    //                       });
    //                     }
    //                   },
    //                   iconColor: Colors.grey[400]!,
    //                   title: "Profile",
    //                   isSelected:
    //                       currentPage == "Profile" ? true : false),
    //               DrawerTile(
    //                   icon: Icons.logout,
    //                   onTap: (){

    //                   },
    //                   iconColor: Colors.grey[400]!,
    //                   title: "Sign Out",
    //                   isSelected:
    //                       currentPage == "Sign Out" ? true : false),
    //             ],
    //           )),
    //     ),
    //   ]),
    // ));
  }
}