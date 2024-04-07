import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:mentor_match/FirestoreOperations.dart';
import 'package:mentor_match/components/GradientButton.dart';
import 'package:mentor_match/components/InputInfoField.dart';
import 'package:mentor_match/components/TopBar.dart';

class StudentProfile extends StatefulWidget {
  
  const StudentProfile({super.key});

  @override
  State<StudentProfile> createState() => _StudentProfileState();
}

class _StudentProfileState extends State<StudentProfile> {
  final TextEditingController _textEditingControllerName = TextEditingController();  
  var currentSelectedValue = "6";
  
  String errorMessage = ""; 
  static const allGrades = ["6", "7", "8", "9", "10", "11", "12"];

  late Stream _stream;

  @override
  void initState() {
    super.initState();

    _stream = FirebaseFirestore.instance.collection("users").doc(FirebaseAuth.instance.currentUser?.uid).snapshots();
  }
  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    return StreamBuilder(
      stream: _stream,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return GestureDetector(
            onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
            child: Scaffold(
              resizeToAvoidBottomInset: false,
              body: SingleChildScrollView(
                child: Column(
                  children: [
                    SafeArea(
                        child: Align(
                          alignment: Alignment.topLeft,
                          child: Container(
                            padding: EdgeInsets.fromLTRB(9, 0, 0, 0),
                            margin: EdgeInsets.fromLTRB(15, 0, 0, 0), 
                            child: TopBarFb1(title: "Edit Profile",)
                          ),
                        ),
                      ),
                    CircleAvatar(
                      radius: screenWidth * 0.15,
                      backgroundColor: Colors.grey[400],
                      child: Icon(Icons.person_2, color: Colors.grey[200], size: screenWidth * 0.15,),
                    ),
                    SizedBox(height: 12),
                    Text(snapshot.data!["name"], style: TextStyle(fontWeight: FontWeight.bold, fontSize: 32),),
                    Text("Grade: " + snapshot.data!["grade"], style: TextStyle(fontWeight: FontWeight.w400, fontSize: 28, color: Colors.grey[500])),
                    SizedBox(height: 12),
                    Container(
                      child: InfoInputFieldFb1(inputController: _textEditingControllerName, title: "New Name", description: snapshot.data!["name"],), width: screenWidth * 0.8,),
                            
                    SizedBox(height: 17),

                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("Grade", style: TextStyle(fontSize: 14, color: Colors.grey[600]),),
                    Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15),
                        color: Colors.white,
                      ),
                      width: screenWidth * 0.8,
                      child: InputDecorator(
                        decoration: InputDecoration(
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(15.0))),
                        child: DropdownButtonHideUnderline(
                          child: DropdownButton<String>(
                            hint: Text("Select Grade"),
                            value: currentSelectedValue,
                            isDense: true,
                            onChanged: (newValue) {
                              setState(() {
                                currentSelectedValue = newValue!;
                              });
                            },
                            items: allGrades.map((String value) {
                              return DropdownMenuItem<String>(
                                value: value,
                                child: Text(value),
                              );
                            }).toList(),
                          ),
                        ),
                      ),
                    ),
                    
                  ],
                ),
                SizedBox(height: 28),
                    Container(
                      width: screenWidth * 0.75,
                      child: GradientButtonFb1(text: "Edit", onPressed: () async {
                          if (snapshot.data!["name"] != _textEditingControllerName.text || snapshot.data!["grade"] != currentSelectedValue) {
                            
                            // Update Profile
                            dynamic result = await editProfile(_textEditingControllerName.text, currentSelectedValue ?? snapshot.data!["grade"], FirebaseAuth.instance.currentUser!.uid); 
                            
                            if (result.runtimeType == String) {
                              setState(() {
                                errorMessage = "Error Updating Profile"; 
                              });
                            }
                          } else {
                          setState(() {
                            errorMessage = "Fields cannot be empty!";
                          });
                        }
                      })),
                      SizedBox(height: 20), 
                      Text(errorMessage, style: TextStyle(color: Colors.red, fontWeight: FontWeight.bold),),
                      ],
                    ),
                    
              ),
            ),
          );
        } else {
          return Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Center(
                child: CircularProgressIndicator(),
              ),
            ],
          );
        }
      }
    );
  }
}