import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:mentor_match/home_pages/admin/admin_home.dart';
import 'package:mentor_match/home_pages/student/student_home.dart';

class HomeBase extends StatefulWidget {
  final String uid; 
  const HomeBase({super.key, required this.uid});

  @override
  State<HomeBase> createState() => _HomeBaseState();
}

class _HomeBaseState extends State<HomeBase> {
  late Stream<DocumentSnapshot<Map<String, dynamic>>>? roleStream =
      FirebaseFirestore.instance
          .collection('users')
          .doc(widget.uid)
          .snapshots();
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<DocumentSnapshot>(
        stream: roleStream,
        builder: (BuildContext context,
              AsyncSnapshot<DocumentSnapshot> snapshot) {
                    if (snapshot.hasData) {  
                        if(snapshot.data!["role"] == "student") {
                          return StudentHome(uid: widget.uid,);
                        } else if (snapshot.data!["role"] == "admin") {
                          return AdminHome(); 
                        } 
                    } 
                    
                    return Scaffold(
                      body: const Center(
                      child: const Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [const CircularProgressIndicator()],
                      ),
                    ),
                    );      
        });
  }
}