import 'package:flutter/material.dart';

class AssignTutor extends StatefulWidget {
  const AssignTutor({super.key});

  @override
  State<AssignTutor> createState() => _AssignTutorState();
}

class _AssignTutorState extends State<AssignTutor> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
              title: Text("Assign a tutor", style: TextStyle(
                color: Colors.black, fontSize: 25, fontWeight: FontWeight.bold),),
              leading: IconButton(
              icon: const Icon(
                Icons.arrow_back,
                color: Color(0xff4338CA),
              ),
              onPressed: () {
                Navigator.of(context).pop(); 
              },
            ),
      ),
    );
  }
}