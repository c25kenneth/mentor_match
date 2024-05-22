import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mentor_match/LoadingScreen.dart';
import 'package:mentor_match/components/GroupCard.dart';

class HomeAllGroups extends StatefulWidget {
  const HomeAllGroups({super.key});

  @override
  State<HomeAllGroups> createState() => _HomeAllGroupsState();
}

class _HomeAllGroupsState extends State<HomeAllGroups> {
  late Stream _stream;
  @override
  void initState() {
    // Only create the stream once
    super.initState();
    _stream = FirebaseFirestore.instance.collection("users").doc(FirebaseAuth.instance.currentUser!.uid).collection("groups").snapshots();
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: _stream,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return ListView.builder(
                        itemCount: snapshot.data!.docs.length,
                        itemBuilder: (context, index) {
                          return GroupCard(title: snapshot.data!.docs[index]["group_name"], subtitle: snapshot.data!.docs[index]["group_description"], groupID: snapshot.data!.docs[index]["group_id"],);
                      });
        } else {
          return LoadingScreen(); 
        }
      }
    );
  }
}