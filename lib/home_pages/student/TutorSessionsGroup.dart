import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:mentor_match/components/TopBar.dart';

class TutorSessionsGroup extends StatefulWidget {
  final String groupID; 
  const TutorSessionsGroup({super.key, required this.groupID});

  @override
  State<TutorSessionsGroup> createState() => _TutorSessionsGroupState();
}

class _TutorSessionsGroupState extends State<TutorSessionsGroup> {

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: null,
      builder: (context, snapshot) {
        return Scaffold(
          body: Center(
            child: Column(
              children: [
                SafeArea(
                        child: Align(
                          alignment: Alignment.topLeft,
                          child: Container(
                            padding: EdgeInsets.fromLTRB(9, 0, 0, 0),
                            margin: EdgeInsets.fromLTRB(15, 0, 0, 0), 
                            child: TopBarFb1(title: "Your Sessions",)
                          ),
                        ),
                ),
                
              ],
            ),
          ),
        );
      }
    );
  }
}