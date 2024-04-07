import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:mentor_match/auth/CreateAccountStudent.dart';
import 'package:mentor_match/auth/SignInEducator.dart';
import 'package:mentor_match/auth/SignInStudent.dart';

class Welcome extends StatefulWidget {
  const Welcome({super.key});

  @override
  State<Welcome> createState() => _WelcomeState();
}

class _WelcomeState extends State<Welcome> {
  final String assetName = 'assets/images/undraw_schedule_re_2vro.svg';
  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height; 
    double width = MediaQuery.of(context).size.width; 

    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text("Mentor Match", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 32),),
            Text("Schedule Your Academic Success", style: TextStyle(fontWeight: FontWeight.w400, fontSize: 15),),
            
            Container(
              width: width * 0.75,
              height: height * 0.45,
              child: SvgPicture.asset(
              assetName,
            ),
            ),
            SizedBox(height: 25),
            Container(
              width: width * 0.75,
              child: ElevatedButton(
                  onPressed: () {
                    Navigator.of(context).push(MaterialPageRoute(builder: (context) => SignInStudent()));                  },
                  style: ElevatedButton.styleFrom(
                    foregroundColor: Colors.white,
                    backgroundColor: Color.fromRGBO(108, 99, 255, 1),
                  ),
                  child: const Padding(
                    padding:
                        EdgeInsets.symmetric(horizontal: 24.0, vertical: 12.0),
                    child: Text("Login"),
                  ),
                ),
            ),
              SizedBox(height: 15.0), 
              Container(
                width: width * 0.75,
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.of(context).push(MaterialPageRoute(builder: (context) => SignUpStudent()));
                  },
                  style: ElevatedButton.styleFrom(
                    foregroundColor: Colors.white,
                    backgroundColor: Colors.white,
                  ),
                  child: const Padding(
                    padding:
                        EdgeInsets.symmetric(horizontal: 24.0, vertical: 12.0),
                    child: Text("Register", style: TextStyle(color: Color.fromRGBO(108, 99, 255, 1),)),
                  ),
                ),
              ),
              SizedBox(height: 15,),
              RichText(
                text: TextSpan(children: [
                  TextSpan(
                    text: 'Are you an educator? ',
                    style: TextStyle(color: Colors.grey, fontSize: 15),
                  ),
                  TextSpan(
                      text: 'Continue here',
                      style: TextStyle(color: Colors.blue, fontSize: 15),
                      recognizer: TapGestureRecognizer()
                        ..onTap = () {
                          Navigator.of(context).push(MaterialPageRoute(builder: (context) => SignInEducator()));
                        }),
                ]),
              ),
          ]
        ),
      ),
    );
  }
}