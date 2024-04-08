import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:mentor_match/LoadingScreen.dart';
import 'package:mentor_match/components/InputInfoField.dart';
import 'package:mentor_match/components/TopBar.dart';
import 'package:mentor_match/components/TopBar2.dart';
import 'package:mentor_match/components/TutorSessionCard.dart';


class PendingSessions extends StatefulWidget {
  const PendingSessions({super.key});

  @override
  State<PendingSessions> createState() => _PendingSessionsState();
}

class _PendingSessionsState extends State<PendingSessions> {
  TextEditingController _controller = TextEditingController(); 
  
  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: FirebaseFirestore.instance.collection("users").doc(FirebaseAuth.instance.currentUser!.uid).collection("pending_requests").snapshots(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return Scaffold(
            appBar: AppBar(
              title: Text("Pending Sessions", style: TextStyle(
                color: Colors.black, fontSize: 25, fontWeight: FontWeight.bold),),
              leading: IconButton(
              icon: const Icon(
                Icons.arrow_back,
                color: Color(0xff4338CA),
              ),
              onPressed: () {
                Navigator.of(context).pop(); 
              },
            ),
            ),
            body: SingleChildScrollView(
              child: Column(
                children: [
                  // SafeArea(
                  //   child: Align(
                  //     alignment: Alignment.topLeft,
                  //     child: Container(
                  //       padding: EdgeInsets.fromLTRB(9, 0, 0, 0),
                  //       margin: EdgeInsets.fromLTRB(15, 0, 0, 0), 
                  //       child: TopBarFb1(title: "All Sessions",)
                  //     ),
                  //   ),
                  // ),
                  ListView.builder(
                    itemCount: snapshot.data!.docs.length,
                    shrinkWrap: true,
                    itemBuilder: (context, index) {
                      return TutorSessionCard(
                        date: snapshot.data!.docs[index]["submitterAvailability"], 
                        subject: snapshot.data!.docs[index]["subject"], 
                        description: snapshot.data!.docs[index]["description"],
                        requestID: snapshot.data!.docs[index]["groupSessionReference"], 
                        groupID: snapshot.data!.docs[index]["groupID"], 
                        requestIdUser: snapshot.data!.docs[index].id, 
                        submitterID: snapshot.data!.docs[index]["submitterID"]);
                    },
                  ),
                ],
              ),
            ));
        } else {
          return LoadingScreen(); 
        }
      }
    );
  }
}