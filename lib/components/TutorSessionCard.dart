import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class TutorSessionCard extends StatefulWidget {

  final List date; 
  final String subject;
  final String description;

  final String requestID; 
  final String groupID; 

  final String requestIdUser; 

  final String submitterID; 

  const TutorSessionCard({super.key, required this.date, required this.subject, required this.description, required this.requestID, required this.groupID, required this.requestIdUser, required this.submitterID});

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
      margin: EdgeInsets.all(15),
      child: Card(
        color: Color.fromRGBO(163, 124, 240, 0.9),
        child: Column(
          children: [
            Container(
              padding: EdgeInsets.fromLTRB(14, 14, 14, 1),
              child: ListTile(
                title: Text(widget.subject, style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 20)),
                subtitle: Row(
                  children: [
                    Expanded(child: Text(widget.description, style: TextStyle(color: Colors.white, ), maxLines: 1, overflow: TextOverflow.ellipsis,)),
                  ],
                ),
                trailing: IconButton(icon: Icon(Icons.close, color: Colors.white,), onPressed: () async {
                  try {
                    await FirebaseFirestore.instance.runTransaction((Transaction myTransaction) async {
                        await myTransaction.delete(FirebaseFirestore.instance.collection("groups").doc(widget.groupID).collection("tutor_requests").doc(widget.requestID));
                        await myTransaction.delete(FirebaseFirestore.instance.collection("users").doc(widget.submitterID).collection("pending_requests").doc(widget.requestIdUser));
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
                  Icon(Icons.schedule_outlined, color: Colors.white,),
                  SizedBox(width: 10,),
                  Text("Pending approval", style: TextStyle(color: Colors.white),),

                  SizedBox(width: 24),
                  Icon(Icons.calendar_month_outlined, color: Colors.white,),
                  SizedBox(width: 10),
                  Expanded(child: Text(dateString.substring(0, dateString.length - 2), style: TextStyle(color: Colors.white), maxLines: 1, overflow: TextOverflow.ellipsis,))
                ],
              ),
            )
          ],
        ),
      )
    );
  }
}