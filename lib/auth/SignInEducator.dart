import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:mentor_match/auth/auth.dart';
import 'package:mentor_match/home_pages/Home_base.dart';

class SignInEducator extends StatefulWidget {
  const SignInEducator({super.key});

  @override
  State<SignInEducator> createState() => _SignInEducatorState();
}

class _SignInEducatorState extends State<SignInEducator> {
  bool hidePassword = true;
  String email = "";  
  String password = "";
  String error = ""; 
  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width; 
    return GestureDetector(
      onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            'Educator Sign In',
             style: TextStyle(
              fontWeight: FontWeight.bold,
             ),
          ),
          leading: IconButton(
            icon: Icon(Icons.arrow_back),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
        ),
        resizeToAvoidBottomInset: true,
        body: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
            
                    SizedBox(height: 35),
                    Center(
                        child: SvgPicture.asset(
                          "assets/images/undraw_educator_re_ju47.svg",
                          width: (screenWidth) * 0.75,
                          height: (screenWidth) * 0.42,
                        ),
                      ),
                    SizedBox(height: 25),
                    Container(
                      width: screenWidth * 0.8,
                      child: TextField(
                        onChanged: (value) {
                          setState(() {
                            email = value; 
                          });
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
                    SizedBox(height: 30),
                    Container(
                      width: screenWidth * 0.8,
                      child: TextField(
                        onChanged: (value) {
                          setState(() {
                            password = value; 
                          });
                        },
                        obscureText: hidePassword,
                        decoration: InputDecoration(
                          hintText: 'Password',
                          counterText: 'Forgot password?',
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
                    error == "" ? Container() : Text(error, style: TextStyle(color: Colors.red, fontWeight: FontWeight.w400, fontSize: 15),),
                    SizedBox(height: 30),
                    Container(
                      width: screenWidth * 0.8,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(30),
                      ),
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Color.fromRGBO(108, 99, 255, 1)
                        ),
                        child: Container(
                            width: double.infinity,
                            height: 50,
                            child: Center(child: Text("Sign In", style: TextStyle(color: Colors.white),))),
                        onPressed: () async {

                          if (email != "" && password != "") {
                            dynamic userCred = await signInStudent(email, password);

                            if (userCred.runtimeType != String) {
                              Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (context) => HomeBase(uid: userCred.user!.uid)), (Route<dynamic> route) => false); 
                            } else {
                              print(userCred.toString()); 
                            }
                          } else {
                            setState(() {
                              error = "Fields must not be empty";
                            });
                          }
                        },
                      ),
                    ),
                    SizedBox(height: 15),
                    // Row(children: [
                    //   Expanded(
                    //     child: Divider(
                    //       color: Colors.grey[300],
                    //       height: 50,
                    //       indent: screenWidth * 0.1,
                    //     ),
                    //   ),
                    //   Padding(
                    //     padding: const EdgeInsets.symmetric(horizontal: 20),
                    //     child: Text("Or continue with"),
                    //   ),
                    //   Expanded(
                    //     child: Divider(
                    //       color: Colors.grey[400],
                    //       height: 50,
                    //       endIndent: screenWidth * 0.1,
                    //     ),
                    //   ),
                    // ]),
                    // SizedBox(height: 15),
                    // _loginWithButton(image: "assets/images/google.png"),
                    // SizedBox(height: 15),
                    RichText(
                      text: TextSpan(children: [
                        TextSpan(
                          text: 'Want to add your institution? ',
                          style: TextStyle(color: Colors.grey, fontSize: 15),
                        ),
                        TextSpan(
                            text: 'Contact Us',
                            style: TextStyle(color: Colors.blue, fontSize: 15),
                            recognizer: TapGestureRecognizer()
                              ..onTap = () {
                              }),
                      ]),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}