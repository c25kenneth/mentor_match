import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:mentor_match/components/NavBarBottom.dart';
import 'package:mentor_match/home_pages/student/HomeAllGroups.dart';


class StudentHomeLoaded extends StatefulWidget {
  const StudentHomeLoaded({super.key});

  @override
  State<StudentHomeLoaded> createState() => _StudentHomeLoadedState();
}

class _StudentHomeLoadedState extends State<StudentHomeLoaded> {
  final GlobalKey<ScaffoldState> _key = GlobalKey();
 
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _key,
      
      appBar: AppBar(
        title: Text("Your Groups"),
          leading: IconButton(
            icon: Icon(Icons.menu),
            onPressed: () {
              _key.currentState!.openDrawer();
            },
          ),
        ),
      drawer: DrawerFb1(),
      body: HomeAllGroups(),
      
    );
  }
}