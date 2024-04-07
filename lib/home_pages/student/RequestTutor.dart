import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:mentor_match/LoadingScreen.dart';
import 'package:mentor_match/components/GradientButton.dart';
import 'package:mentor_match/components/TopBar.dart';
import 'package:mentor_match/home_pages/student/RequestTutorOtherInfo.dart';

class RequestTutor extends StatefulWidget {
  const RequestTutor({super.key});

  @override
  State<RequestTutor> createState() => _RequestTutorState();
}

class _RequestTutorState extends State<RequestTutor> {
  late List subjects = [];
  final FirebaseAuth _auth = FirebaseAuth.instance; 
  final FirebaseFirestore _db = FirebaseFirestore.instance; 
  Map groupData = {}; 
  String selectedSubject = "Choose Subject"; 
  String currentSelectedValue = "";  

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width; 
    
    return StreamBuilder(
      stream: _db.collection("users").doc(_auth.currentUser!.uid).collection("groups").snapshots(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return Scaffold(
            body: Center(
              child: Column(
                children: [
                  SafeArea(
                      child: Align(
                        alignment: Alignment.topLeft,
                        child: Container(
                          padding: EdgeInsets.fromLTRB(12, 0, 12, 0),
                          margin: EdgeInsets.fromLTRB(15, 0, 15, 0), 
                          child: TopBarFb1(title: "Request a Tutor",)
                        ),
                      ),
                    ),
                  SizedBox(height: 25),
                  SvgPicture.asset(
                    "assets/images/undraw_education_f8ru.svg",
                    width: (screenWidth) * 0.75,
                    height: (screenWidth) * 0.42,
                  ),
                    SizedBox(height: 40),
                                  Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("Choose a group", style: TextStyle(fontSize: 20),),
                    SizedBox(height: 5), 
                    Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15),
                        color: Colors.white,
                      ),
                      width: MediaQuery.of(context).size.width * 0.8,
                      child: InputDecorator(
                        decoration: InputDecoration(
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(15.0))),
                        child: DropdownButtonHideUnderline(
                          child: DropdownButton<String>(
                            hint: Text("Select Group"),
                            value: (currentSelectedValue == "" ? snapshot.data!.docs[0]["group_id"] : currentSelectedValue),
                            isDense: true,
                            onChanged: (newValue) async {
                              setState(() {
                                currentSelectedValue = newValue!;
                              });
                              DocumentSnapshot<Map<String, dynamic>> data = await _db.collection("groups").doc(currentSelectedValue).get();
                              setState(() {
                                subjects = data["available_subjects"];
                              });
                              print(subjects);
                            },
                            items: snapshot.data!.docs.map((DocumentSnapshot doc) {
                              Map<String, dynamic>? data = doc.data() as Map<String, dynamic>?;
                              return DropdownMenuItem<String>(
                                value: data?["group_id"],
                                child: Text(data?["group_name"]),
                              );
                            }).toList(),
                          ),
                        ),
                      ),
                    ),
                  ],
                                  ), 
                      SizedBox(height: 30),
                    GradientButtonFb1(text: "Next", onPressed: (){
                      Navigator.of(context).push(MaterialPageRoute(builder: (context) => RequestTutorOtherInfo(groupID: currentSelectedValue == "" ? snapshot.data!.docs[0]["group_id"] : currentSelectedValue)));
                    })
                  
                ],
              ),
            ),
          );
        } else {
          return LoadingScreen(); 
        }
      }
    );
  }
}
