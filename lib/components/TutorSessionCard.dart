import 'package:flutter/material.dart';

class TutorSessionCard extends StatefulWidget {
  // final double screenHeight; 
  final double screenWidth;
  const TutorSessionCard({super.key, required this.screenWidth});

  @override
  State<TutorSessionCard> createState() => _TutorSessionCardState();
}

class _TutorSessionCardState extends State<TutorSessionCard> {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(10),
      color: Color.fromRGBO(108, 99, 255, 1),
      ),
      width: widget.screenWidth * 0.8,
      child: Padding(
        padding: const EdgeInsets.all(14.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("Session Name", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 24),),
            Text("Kenneth and Joe", style: TextStyle(color: Colors.white70, fontWeight: FontWeight.w300, fontSize: 18),),
            SizedBox(height: 9),
            Row(
              children: [
            Text("📆 12 June", style: TextStyle(color: Colors.white, fontWeight: FontWeight.w300),),
            Spacer(), 
            Text("3:00 - 4:00 PM", style: TextStyle(color: Colors.white, fontWeight: FontWeight.w300),),
              ],
            )
          ],
        ),
      ),
    );
  }
}