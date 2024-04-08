import 'package:flutter/material.dart';
import 'package:mentor_match/LoadingScreen.dart';
import 'package:mentor_match/components/NavBarBottom.dart';
import 'package:mentor_match/components/NavigationDrawer.dart';
import 'package:mentor_match/components/TopBar.dart';

class AllTutoringSessions extends StatefulWidget {
  const AllTutoringSessions({super.key});

  @override
  State<AllTutoringSessions> createState() => _AllTutoringSessionsState();
}

class _AllTutoringSessionsState extends State<AllTutoringSessions> {
  
  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: null,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return Scaffold(
            body: Column(
              children: [
                SafeArea(
                  child: Align(
                    alignment: Alignment.topLeft,
                    child: Container(
                      padding: EdgeInsets.fromLTRB(9, 0, 0, 0),
                      margin: EdgeInsets.fromLTRB(15, 0, 0, 0), 
                      child: TopBarFb1(title: "All Sessions",)
                    ),
                  ),
                ),
              ],
            ),
          );
        } else {
          return LoadingScreen();
        }
      }
    );
  }
}