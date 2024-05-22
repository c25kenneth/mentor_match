import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:mentor_match/LoadingScreen.dart';
import 'package:mentor_match/components/NavBarBottom.dart';
import 'package:mentor_match/home_pages/student/AllTutoringSessions.dart';
import 'package:mentor_match/home_pages/student/HomeAllGroups.dart';


class StudentHomeLoaded extends StatefulWidget {
  const StudentHomeLoaded({super.key});

  @override
  State<StudentHomeLoaded> createState() => _StudentHomeLoadedState();
}

class _StudentHomeLoadedState extends State<StudentHomeLoaded> {
  final GlobalKey<ScaffoldState> _key = GlobalKey();
 
  String currUserId = FirebaseAuth.instance.currentUser!.uid; 
  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: FirebaseFirestore.instance.collection("users").doc(currUserId).snapshots(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return Scaffold(
            key: _key,
            appBar: AppBar(
              title: Text("Your Sessions"),
                leading: IconButton(
                  icon: Icon(Icons.menu),
                  onPressed: () {
                    _key.currentState!.openDrawer();
                  },
                ),
              ),
            drawer: DrawerFb1(groupID: snapshot.data!["groupID"], name: snapshot.data!["name"], grade: snapshot.data!["grade"],),
            body: AllTutoringSessions(),
          );
        } else {
          return LoadingScreen(); 
        }
      }
    );
  }
}