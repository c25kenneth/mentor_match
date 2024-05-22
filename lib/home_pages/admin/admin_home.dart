import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:mentor_match/LoadingScreen.dart';
import 'package:mentor_match/auth/Welcome.dart';
import 'package:mentor_match/components/GroupCard.dart';
import 'package:mentor_match/components/GroupCardAdmin.dart';
import 'package:mentor_match/home_pages/admin/GroupHome.dart';

class AdminHome extends StatefulWidget {
  const AdminHome({super.key});

  @override
  State<AdminHome> createState() => _AdminHomeState();
}

class _AdminHomeState extends State<AdminHome> {
  String adminUID = FirebaseAuth.instance.currentUser!.uid; 
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: FirebaseFirestore.instance.collection("groups").where("admin_uid", isEqualTo: adminUID).snapshots(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return GroupHome(title: snapshot.data!.docs[0]["group_name"], groupID: snapshot.data!.docs[0]["group_id"]);
        } else {
          return LoadingScreen(); 
        }
      }
    );
  }
}