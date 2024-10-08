import 'package:flutter/material.dart';

class TopBarFb1 extends StatefulWidget {
  final String title; 
  const TopBarFb1({Key? key, required this.title}) : super(key: key);

  @override
  State<TopBarFb1> createState() => _TopBarFb1State();
}

class _TopBarFb1State extends State<TopBarFb1> {
  final primaryColor = const Color(0xff4338CA);

  final secondaryColor = const Color(0xff6D28D9);

  final accentColor = const Color(0xffffffff);

  final backgroundColor = const Color(0xffffffff);

  final errorColor = const Color(0xffEF4444);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
            decoration: BoxDecoration(
              color: Colors.white,
              shape: BoxShape.circle,
              boxShadow: [
              BoxShadow(
                  offset: const Offset(12, 26),
                  blurRadius: 50,
                  spreadRadius: 0,
                  color: Colors.grey.withOpacity(.25)),
            ]),
            child: IconButton(
              icon: const Icon(
                Icons.arrow_back,
                color: Color(0xff4338CA),
              ),
              onPressed: () {
                Navigator.of(context).pop(); 
              },
            )),
        const SizedBox(
          height: 10,
        ),
        Text(widget.title,
            style: TextStyle(
                color: Colors.black, fontSize: 30, fontWeight: FontWeight.bold))
      ],
    );
  }
}