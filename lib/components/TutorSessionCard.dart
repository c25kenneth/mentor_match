import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class TutorSessionCard extends StatefulWidget {

  final List date; 
  final String subject;

  final String requestID; 
  final String groupID; 

  final String requestIdUser; 

  final String submitterID; 

  const TutorSessionCard({super.key, required this.date, required this.subject, required this.requestID, required this.groupID, required this.requestIdUser, required this.submitterID});

  @override
  State<TutorSessionCard> createState() => _TutorSessionCardState();
}

class _TutorSessionCardState extends State<TutorSessionCard> {
  String dateString = ""; 
  @override
  void initState() {
    super.initState();
    widget.date.forEach((element) {
      dateString += element += ", ";
    });
  }
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(10),
      ),
      child: Card(
        color: Color.fromRGBO(108, 99, 255, 0.9),
        child: Column(
          children: [
            ListTile(
              title: Text(widget.subject, style: TextStyle(color: Colors.white,)),
              subtitle: Text(dateString, style: TextStyle(color: Colors.white,),),
              trailing: IconButton(icon: Icon(Icons.close, color: Colors.white,), onPressed: () async {
                try {
                  await FirebaseFirestore.instance.runTransaction((Transaction myTransaction) async {
                      await myTransaction.delete(FirebaseFirestore.instance.collection("groups").doc(widget.groupID).collection("tutor_requests").doc(widget.requestID));
                      await myTransaction.delete(FirebaseFirestore.instance.collection("users").doc(widget.submitterID).collection("pending_requests").doc(widget.requestIdUser));
                  });
                  // await FirebaseFirestore.instance.collection("groups").doc(widget.groupID).collection("tutor_requests").doc(widget.requestID).delete();
                  // await FirebaseFirestore.instance.collection("users").doc(widget.submitterID).collection("groups").doc(widget.requestIdUser).delete(); 
                  print("success");
                } catch (e) {
                  print("Error");
                }
              },),
            ),
          ],
        ),
      )
    );
  }
}