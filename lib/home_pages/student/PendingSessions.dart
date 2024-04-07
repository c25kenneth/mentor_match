import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:mentor_match/LoadingScreen.dart';
import 'package:mentor_match/components/InputInfoField.dart';


class PendingSessions extends StatefulWidget {
  const PendingSessions({super.key});

  @override
  State<PendingSessions> createState() => _PendingSessionsState();
}

class _PendingSessionsState extends State<PendingSessions> {
  TextEditingController _controller = TextEditingController(); 
  
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<Object>(
      stream: FirebaseFirestore.instance.collection("users").doc(FirebaseAuth.instance.currentUser!.uid).collection("pending_requests").snapshots(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return Scaffold(
            body: SafeArea(child: Text("Pending Sessions")));
        } else {
          return LoadingScreen(); 
        }
      }
    );
  }
}