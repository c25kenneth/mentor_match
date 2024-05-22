import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:mentor_match/LoadingScreen.dart';
import 'package:mentor_match/components/TutorSessionPendingCard.dart';


class PendingSessions extends StatefulWidget {
  final String groupID; 
  const PendingSessions({super.key, required this.groupID});

  @override
  State<PendingSessions> createState() => _PendingSessionsState();
}

class _PendingSessionsState extends State<PendingSessions> {
  TextEditingController _controller = TextEditingController(); 
  String currUserUID = FirebaseAuth.instance.currentUser!.uid;

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: FirebaseFirestore.instance.collection("groups").doc(widget.groupID).collection("tutor_requests").where("pending", isEqualTo: "true").where("submitterID", isEqualTo: currUserUID).snapshots(),
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
                      return TutorSessionPendingCard(
                        date: snapshot.data!.docs[index]["submitterAvailability"], 
                        subject: snapshot.data!.docs[index]["subject"], 
                        description: snapshot.data!.docs[index]["description"],
                        requestID: snapshot.data!.docs[index].id,
                        groupID: snapshot.data!.docs[index]["groupID"], 
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