import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:mentor_match/FirestoreOperations.dart';
import 'package:mentor_match/UserModel.dart';
import 'package:mentor_match/components/GradientButton.dart';
import 'package:mentor_match/components/InputInfoField.dart';

class JoinAnotherGroup extends StatefulWidget {
  final String uid; 
  const JoinAnotherGroup({super.key, required this.uid});

  @override
  State<JoinAnotherGroup> createState() => _JoinAnotherGroupState();
}

class _JoinAnotherGroupState extends State<JoinAnotherGroup> {
  final _textEditingController = TextEditingController(); 
  FirebaseFirestore db = FirebaseFirestore.instance;
  String errorMessage = "";
  
  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width; 
    return StreamBuilder<DocumentSnapshot>(
      stream: db.collection("users").doc(widget.uid).snapshots(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return GestureDetector(
            onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
            child: Scaffold(
              body: Center(
                child: SingleChildScrollView(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      SizedBox(height: 75), 
                      SvgPicture.asset(
                                    "assets/images/undraw_add_information_j2wg.svg",
                                    width: (screenWidth) * 0.75,
                                    height: (screenWidth) * 0.42,
                      ),
                      SizedBox(height: 30,),
                      Container(
                        width: MediaQuery.of(context).size.width * 0.8,
                        child: InfoInputFieldFb1(inputController: _textEditingController, title: "Group Code", description: "Enter Group Code to Join",), 
                      ),
                      SizedBox(height: 12),
                      errorMessage != "" ? Text(errorMessage, style: TextStyle(color: Colors.red, fontWeight: FontWeight.w400, fontSize: 18),) : SizedBox(),
                      SizedBox(height: 35), 
                      GradientButtonFb1(text: "Join", onPressed: () async {
                        if (_textEditingController.text != "") {
                          dynamic result = await joinGroup(_textEditingController.text, 
                          widget.uid, 
                          UserModel(
                            grade: snapshot.data!["grade"], 
                            name: snapshot.data!["name"],
                            role: snapshot.data!["role"], 
                            uid: widget.uid, 
                            email: snapshot.data!["email"]
                          ),  
                          );
                                
                          if (result.runtimeType == String) {
                            setState(() {
                              errorMessage = result; 
                            });
                          } else {
                            Navigator.of(context).pop(); 
                          }
                        } else {
                          setState(() {
                            errorMessage = "Enter a code!";
                          });
                        }
                      })
                    ],
                  ),
                ),
              ),
            ),
          );
        } else {
          return Scaffold(
          body: const Center(
            child: const Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [const CircularProgressIndicator()],
            ),
          ),
        );
        }
      }
    );
  }
}