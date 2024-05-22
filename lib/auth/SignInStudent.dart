import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:mentor_match/FirestoreOperations.dart';
import 'package:mentor_match/auth/CreateAccountStudent.dart';
import 'package:mentor_match/auth/OnboardingScreen.dart';
import 'package:mentor_match/auth/SignInWithGoogle.dart';
import 'package:mentor_match/auth/auth.dart';
import 'package:mentor_match/home_pages/Home_base.dart';

class SignInStudent extends StatefulWidget {
  const SignInStudent({super.key});

  @override
  State<SignInStudent> createState() => _SignInStudentState();
}

class _SignInStudentState extends State<SignInStudent> {
  bool hidePassword = true; 
  String email = ""; 
  String password = ""; 
  String errorMessage = ""; 

  TextEditingController _textEditingControllerEmail = TextEditingController();
  TextEditingController _textEditingControllerPassword = TextEditingController();
  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width; 
    double screenHeight = MediaQuery.of(context).size.height; 
    return GestureDetector(
      onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
      child: Scaffold(
        resizeToAvoidBottomInset: true,
        body: Center(
          child: SingleChildScrollView(
            child: SafeArea(
              child: Padding(
                padding: EdgeInsets.all(screenWidth * 0.075),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("Welcome back", style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),),
                    Text("Please sign in to continue", style: TextStyle(fontSize: 18, color: Colors.grey[600]),),
                    Column(
                      children: [
                        SizedBox(height: 25),
                        Container(
                          // width: screenWidth * 0.8,
                          child: TextField(
                            onChanged: (val) {
                              _textEditingControllerEmail.text = val; 
                            },
                            decoration: InputDecoration(
                              hintText: 'Enter email',
                              filled: true,
                              fillColor: Colors.blueGrey[50],
                              labelStyle: TextStyle(fontSize: 12),
                              contentPadding: EdgeInsets.only(left: 30),
                              enabledBorder: OutlineInputBorder(
                                borderSide: BorderSide(color: Colors.blueGrey),
                                borderRadius: BorderRadius.circular(15),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(color: Colors.blueGrey),
                                borderRadius: BorderRadius.circular(15),
                              ),
                            ),
                          ),
                        ),
                        SizedBox(height: 25),
                        Container(
                          // width: screenWidth * 0.8,
                          child: TextField(
                            onChanged: (value) {
                              _textEditingControllerPassword.text = value; 
                            },
                            obscureText: hidePassword,
                            decoration: InputDecoration(
                              hintText: 'Password',
                              suffixIcon: IconButton(
                                icon: hidePassword
                                    ? Icon(Icons.visibility_off_outlined)
                                    : Icon(Icons.visibility_outlined),
                                color: Colors.grey,
                                onPressed: () {
                                  setState(() {
                                    hidePassword = !hidePassword;
                                  });
                                },
                              ),
                              filled: true,
                              fillColor: Colors.blueGrey[50],
                              labelStyle: TextStyle(fontSize: 12),
                              contentPadding: EdgeInsets.only(left: 30),
                              enabledBorder: OutlineInputBorder(
                                borderSide: BorderSide(color: Colors.blueGrey),
                                borderRadius: BorderRadius.circular(15),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(color: Colors.blueGrey),
                                borderRadius: BorderRadius.circular(15),
                              ),
                            ),
                          ),
                        ),
                        SizedBox(height: 10),
                        errorMessage == "" ? Container() : Text(errorMessage, style: TextStyle(color: Colors.red, fontWeight: FontWeight.w400, fontSize: 15),),
                        SizedBox(height: 30),
                        Container(
                          // width: screenWidth * 0.8,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(30),
                          ),
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: const Color.fromRGBO(108, 99, 255, 1)
                            ),
                            child: Container(
                                width: double.infinity,
                                height: 50,
                                child: Center(child: Text("Sign In", style: TextStyle(color: Colors.white),))),
                                onPressed: () async {
                            
                                  if (_textEditingControllerEmail.text != "" && _textEditingControllerPassword.text != "") {
                                    dynamic res = await signInStudent(_textEditingControllerEmail.text, _textEditingControllerPassword.text);
                                    if (res.runtimeType != String) {
                                      dynamic doesExist = await doesProfileExist(res.user.uid);
                                      if (doesExist.runtimeType == bool && doesExist == false) {
                                        Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (context) => OnBoarding(userCred: res)), (Route<dynamic> route) => false); 
                                      } else if (doesExist.runtimeType == bool && doesExist == true) {
                                        Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (context) => HomeBase(uid: res.user.uid,)), (Route<dynamic> route) => false); 
                                      } else if (doesExist.runtimeType == String) {
                                        setState(() {
                                          errorMessage = res; 
                                        });
                                      }
                                    } else {
                                      print(res); 
                                      setState(() {
                                        errorMessage = res; 
                                      });
                                    }
                                  } else {
                                    setState(() {
                                      errorMessage = "Fields must not be empty"; 
                                    });
                                  }
                                } 
                          ),
                        ),
                        Column(
                                        children: [
                                           Padding(
                                        padding: const EdgeInsets.symmetric(horizontal: 35.0, vertical: 25),
                                        child: Row(
                                          children: [
                        Expanded(
                          child: Divider(
                            thickness: 0.5,
                            color: Colors.grey[400],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 10.0),
                          child: Text(
                            'Or continue with',
                            style: TextStyle(color: Colors.grey[700]),
                          ),
                        ),
                        Expanded(
                          child: Divider(
                            thickness: 0.5,
                            color: Colors.grey[400],
                          ),
                        ),
                                          ],
                                        ),
                                      ),
                                      Container(
                                        child: GoogleBtn1(onPressed: () async {
                                        dynamic result = await signInWithGoogle();
                                        print(result);
                                        if (result.runtimeType == String) {
                                          setState(() {
                        errorMessage = result; 
                                          });
                                        } else {
                                          dynamic doesUserExist = await doesProfileExist(result.user.uid);
                                          
                                          if (doesUserExist.runtimeType == bool && doesUserExist == false) {
                        Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (context) => OnBoarding(userCred: result)), (Route<dynamic> route) => false);
                                          } else if (doesUserExist.runtimeType == bool && doesUserExist == true){
                        Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (context) => HomeBase(uid: result.user.uid)), (Route<dynamic> route) => false);
                                          } else if (doesUserExist.runtimeType == String) {
                        setState(() {
                          errorMessage = doesUserExist; 
                        });
                                          }
                                        }
                                      })),
                                      SizedBox(height: 15),
                                      RichText(
                                        text: TextSpan(children: [
                                          TextSpan(
                        text: "Don't have an account? ",
                        style: TextStyle(color: Colors.grey, fontSize: 15),
                                          ),
                                          TextSpan(
                          text: 'Register',
                          style: TextStyle(color: Colors.blue, fontSize: 15),
                          recognizer: TapGestureRecognizer()
                            ..onTap = () {
                              Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => SignUpStudent()));
                            }),
                                        ]),
                                      ),
                                ],),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}