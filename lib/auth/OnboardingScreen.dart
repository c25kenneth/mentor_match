import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:mentor_match/auth/Welcome.dart';
import 'package:mentor_match/auth/auth.dart';
import 'package:mentor_match/components/GradientButton.dart';
import 'package:mentor_match/components/InputInfoField.dart';
import 'package:mentor_match/components/LockedInputInfoField.dart';
import 'package:mentor_match/components/TopBar.dart';
import 'package:mentor_match/home_pages/Home_base.dart';

class OnBoarding extends StatefulWidget {
  final UserCredential userCred; 
  const OnBoarding({super.key, required this.userCred});

  @override
  State<OnBoarding> createState() => _OnBoardingState();
}

class _OnBoardingState extends State<OnBoarding> {
  TextEditingController _emailController = TextEditingController();
  TextEditingController _nameController = TextEditingController();
  String currentSelectedValue = "6"; 
  String errorMessage = ""; 
  static const allGrades = ["6", "7", "8", "9", "10", "11", "12"];

  @override
  void initState() {
    super.initState();
    _emailController.text = widget.userCred.user!.email!; 
  }
  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width; 
    double screenHeight = MediaQuery.of(context).size.height; 
    return Scaffold(
      appBar: AppBar(title: Text("Setup Account"),),
      body: SafeArea(
        child: Center(
          child: Column(
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: 25),
                  Container(
                    width: (screenWidth) * 0.8,
                    height: (screenHeight) * 0.2,
                    child: Center(
                      child: SvgPicture.asset(
                        "assets/images/undraw_profile_re_4a55.svg",
                          
                      ),
                    ),
                  ),
                  SizedBox(height: 30),
                  Text("Your Email"),
                  SizedBox(height: 5),
                  Container(width: screenWidth * 0.8, child: InfoInputFieldLockedFb1(inputController: _emailController, title: "Email", description: "Email", readOnly: true,)), 
                  SizedBox(height: 20),
                  Text("Your Name"),
                  SizedBox(height: 5),
                  Container(width: screenWidth * 0.8, child: InfoInputFieldFb1(inputController: _nameController, title: "", description: "Name")), 
                  SizedBox(height: 20),
                  Text("Select your grade*"),
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
                        hint: Text("Select Grade"),
                        value: currentSelectedValue,
                        isDense: true,
                        onChanged: (newValue) {
                          setState(() {
                            currentSelectedValue = newValue!;
                          });
                          print(currentSelectedValue);
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
                      SizedBox(height: 20),
                      (errorMessage != "") ? Text(errorMessage, style: TextStyle(color: Colors.red, fontSize: 16),) : SizedBox(), 
                ],
              ),
              SizedBox(height: 30),
                      GradientButtonFb1(text: "Create Account", onPressed: () async {
                        if (_nameController.text != "") {
                          dynamic res = addStudentInfo(widget.userCred.user!.uid, currentSelectedValue, widget.userCred.additionalUserInfo?.profile?["email"], _nameController.text); 
                          if (res.runtimeType == String) {
                            setState(() {
                              errorMessage = res; 
                            });
                          } else {
                            Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (context) => HomeBase(uid: widget.userCred.user!.uid)), (Route<dynamic> route) => false);
                          }
                        } else {
                          setState(() {
                            errorMessage = "Must enter name!"; 
                          });
                        }

                      }),
            ],
          ),
        ),
      ),
    );
  }
}