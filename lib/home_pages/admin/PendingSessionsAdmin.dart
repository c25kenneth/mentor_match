import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:mentor_match/LoadingScreen.dart';
import 'package:mentor_match/components/TopBar.dart';
import 'package:mentor_match/components/TutorSessionPendingCardAdmin.dart';

class PendingSessionsAdmin extends StatefulWidget {
  final String groupID; 
  const PendingSessionsAdmin({super.key, required this.groupID});

  @override
  State<PendingSessionsAdmin> createState() => _PendingSessionsAdminState();
}

class _PendingSessionsAdminState extends State<PendingSessionsAdmin> {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: FirebaseFirestore.instance.collection("groups").doc(widget.groupID).collection("tutor_requests").where("pending", isEqualTo: "true").snapshots(), 
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
                  ListView.builder(
                      itemCount: snapshot.data!.docs.length,
                      shrinkWrap: true,
                      itemBuilder: (context, index) {
                        return TutorSessionPendingCardAdmin(
                          date: snapshot.data!.docs[index]["submitterAvailability"], 
                          subject: snapshot.data!.docs[index]["subject"], 
                          description: snapshot.data!.docs[index]["description"],
                          requestID: snapshot.data!.docs[index].id, 
                          groupID: snapshot.data!.docs[index]["groupID"],  
                          submitterID: snapshot.data!.docs[index]["submitterID"],
                          submitterEmail: snapshot.data!.docs[index]["submitterEmail"],
                          submitterName: snapshot.data!.docs[index]["submitterName"],
                        );
                      },
                    ),
                ],
              ),
            ),
          );
        } else {
          return LoadingScreen();
        }
      });
  }
}