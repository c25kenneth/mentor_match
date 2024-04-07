import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:mentor_match/auth/CreateAccountStudent.dart';
import 'package:mentor_match/auth/Welcome.dart';
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
        if (snapshot.data!['groups'].length == 0) {
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
                      // await FirebaseAuth.instance.signOut(); 
                      // Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => Welcome()));
                    })
                  ],
                ),

              ),
          );
        } else {
          // final List userGroups = [];
          // snapshot.data!['groups'].forEach((item) async {
          //   userGroups.add(await FirebaseFirestore.instance.collection("groups").doc(item).get());
          // });
          // return StudentHomeLoaded(items: userGroups);
          Future<List<DocumentSnapshot>> getData() async {
            List<DocumentSnapshot> userGroups = [];
            QuerySnapshot querySnapshot = await FirebaseFirestore.instance.collection("groups").get();
            for (DocumentSnapshot item in querySnapshot.docs) {
              if (snapshot.data!['groups'].contains(item.id)) {
                userGroups.add(item);
              }
            }
            return userGroups;
          }
          return FutureBuilder(
            future: getData(),
            builder: (context, AsyncSnapshot<List<DocumentSnapshot>> snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                // Show loading screen while data is being fetched
                return Scaffold(
                  body: Center(
                    child: CircularProgressIndicator(),
                  ),
                );
              } else { 
                  // Data has been fetched, show desired screen
                  return StudentHomeLoaded();
              }
            },
          );
        }
      } else {
        return const Scaffold(
          body: const Center(
            child: const Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [const CircularProgressIndicator()],
            ),
          ),
        );
      }
    }));
  }
}