import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class TutorSessionPendingCard extends StatefulWidget {

  final List date; 
  final String subject;
  final String description;

  final String groupID; 
  final String requestID; 

  final String submitterID; 

  const TutorSessionPendingCard({super.key, required this.date, required this.subject, required this.description, required this.groupID, required this.requestID, required this.submitterID});

  @override
  State<TutorSessionPendingCard> createState() => _TutorSessionPendingCardState();
}

class _TutorSessionPendingCardState extends State<TutorSessionPendingCard> {
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
      margin: EdgeInsets.all(15),
      child: Card(
        color: Colors.white,
        child: Column(
          children: [
            Container(
              padding: EdgeInsets.fromLTRB(14, 14, 14, 1),
              child: ListTile(
                title: Text(widget.subject, style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold, fontSize: 20)),
                subtitle: Row(
                  children: [
                    Expanded(child: Text(widget.description, style: TextStyle(color: Colors.black87, ), maxLines: 1, overflow: TextOverflow.ellipsis,)),
                  ],
                ),
                trailing: IconButton(tooltip: "Cancel", icon: Icon(Icons.close, color: Colors.red,), onPressed: () async {
                  try {
                    await FirebaseFirestore.instance.runTransaction((Transaction myTransaction) async {

                        await myTransaction.delete(FirebaseFirestore.instance.collection("groups").doc(widget.groupID).collection("tutor_requests").doc(widget.requestID));
                        // await myTransaction.delete(FirebaseFirestore.instance.collection("users").doc(widget.submitterID).collection("pending_requests").doc(widget.requestIdUser));
                    });
                    print("success");
                  } catch (e) {
                    print("Error");
                  }
                },),
              ),
            ),
            Container(
              width: MediaQuery.of(context).size.width * 0.8,
              child: Divider(
                thickness: 1,
              ),
            ),
            Container(
              margin: EdgeInsets.all(14),
              child: Row(
                children: [
                  Icon(Icons.schedule_outlined, color: Color.fromRGBO(163, 124, 240, 0.9),),
                  SizedBox(width: 10,),
                  Text("Pending approval", style: TextStyle(color: Color.fromRGBO(163, 124, 240, 0.9)),),

                  SizedBox(width: 24),
                  Icon(Icons.calendar_month_outlined, color: Color.fromRGBO(163, 124, 240, 0.9),),
                  SizedBox(width: 10),
                  Expanded(child: Text(dateString.substring(0, dateString.length - 2), style: TextStyle(color: Color.fromRGBO(163, 124, 240, 0.9)), maxLines: 1, overflow: TextOverflow.ellipsis,))
                ],
              ),
            )
          ],
        ),
      )
    );
  }
}