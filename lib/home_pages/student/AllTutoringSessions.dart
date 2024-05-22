import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:mentor_match/LoadingScreen.dart';

class AllTutoringSessions extends StatefulWidget {
  const AllTutoringSessions({super.key});

  @override
  State<AllTutoringSessions> createState() => _AllTutoringSessionsState();
}

class _AllTutoringSessionsState extends State<AllTutoringSessions> {
  String currUserId = FirebaseAuth.instance.currentUser!.uid; 
  String userGroupID = ""; 

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width; 
    return StreamBuilder(
      stream: FirebaseFirestore.instance.collection("users").doc(currUserId).snapshots(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return StreamBuilder(
          // CHANGE THIS SO THAT IT WORKS FOR THE GROUP THE USER IS IN
          stream: FirebaseFirestore.instance.collection("groups").doc(snapshot.data!["groupID"]).collection("tutor_requests").where("pending", isEqualTo: "false").where("submitterID", isEqualTo: currUserId).snapshots(),
          builder: (context, snapshot2) {
            if (snapshot2.hasData) {
              return StreamBuilder(
                stream: FirebaseFirestore.instance.collection("groups").doc(snapshot.data!["groupID"]).collection("tutor_requests").where("pending", isEqualTo: "false").where("tutorID", isEqualTo: currUserId).snapshots(), 
                builder: (context, snapshot3) {
                  if (snapshot3.hasData) {
                    if (snapshot2.data!.docs.length == 0 && snapshot3.data!.docs.length == 0) {
                      return Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Container(
                              child: SvgPicture.asset("assets/images/undraw_not_found_re_bh2e.svg", ),
                              width: (screenWidth) * 0.75,
                              height: (screenWidth) * 0.42,
                            ),
                            Text("No sessions scheduled!", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),)
                          ],
                        ),
                      );
                    } else {
                      var documents1 = snapshot2.data!.docs;
                      var documents2 = snapshot3.data!.docs;
                      var allDocuments = [...documents1, ...documents2];

                      return ListView.builder(
                          shrinkWrap: true,
                          itemCount: allDocuments.length,
                          itemBuilder: (context, index) {
                            return Card(
                              child: Text(allDocuments[index].data()["description"]),
                            );
                            
                        });
                    }
                  } else {
                    return LoadingScreen();
                  }
                });
              
            } else {
              return LoadingScreen();
            }
          }
          );
        } else {
          return LoadingScreen();
        }
    } 
    

      );
  }
}