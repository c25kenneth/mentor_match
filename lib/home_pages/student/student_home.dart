import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:mentor_match/LoadingScreen.dart';
import 'package:mentor_match/components/GradientButton.dart';
import 'package:mentor_match/home_pages/student/JoinGroup.dart';
import 'package:mentor_match/home_pages/student/StudentHomeBase.dart';

class StudentHome extends StatefulWidget {
  final String uid; 
  const StudentHome({super.key, required this.uid});

  @override
  State<StudentHome> createState() => _StudentHomeState();
}

class _StudentHomeState extends State<StudentHome> {
  @override
  Widget build(BuildContext context) {

    
    double screenWidth = MediaQuery.of(context).size.width; 

    return StreamBuilder(stream: FirebaseFirestore.instance.collection("users").doc(widget.uid).snapshots(), builder: ((context, snapshot) {
      if (snapshot.hasData) {
        if (snapshot.data!["groupID"] == "") {
          return Scaffold(
            body: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text("You have no groups", style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),),
                    SizedBox(height: 25), 
                    SvgPicture.asset(
                          "assets/images/undraw_add_information_j2wg.svg",
                          width: (screenWidth) * 0.75,
                          height: (screenWidth) * 0.42,
                    ),
                    SizedBox(height: 30), 
                    GradientButtonFb1(text: "Join Group", onPressed: () async {
                      Navigator.of(context).push(MaterialPageRoute(builder: (context) => JoinGroup(uid: widget.uid,)));
                    })
                  ],
                ),

              ),
          );
        } else {
          return StudentHomeLoaded();
        }
      } else {
        return LoadingScreen();
      }
    }));
  }
}