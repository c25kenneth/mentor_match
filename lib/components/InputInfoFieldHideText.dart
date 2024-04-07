import 'package:flutter/material.dart';

class InfoInputFieldHidePasswordFb1 extends StatefulWidget {
  final String title;  
  final String description; 
  final bool hideText; 
  final TextEditingController inputController;
  const InfoInputFieldHidePasswordFb1({Key? key,required this.inputController, required this.title, required this.description, required this.hideText}) : super(key: key);

  @override
  State<InfoInputFieldHidePasswordFb1> createState() => _InfoInputFieldHidePasswordFb1State();
}

class _InfoInputFieldHidePasswordFb1State extends State<InfoInputFieldHidePasswordFb1> {
  @override
  Widget build(BuildContext context) {
    const primaryColor = Color(0xff4338CA);
    const secondaryColor = Color(0xff6D28D9);
    const accentColor = Color(0xffffffff);
    // const backgroundColor = Color(0xffffffff);
    const errorColor = Color(0xffEF4444);
   
    return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            widget.title,
            style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.normal,
                color: Colors.grey[600]),
          ),
          const SizedBox(
            height: 8,
          ),
          Container(
            height: 50,
            decoration: BoxDecoration(boxShadow: [
              BoxShadow(
                  offset: const Offset(12, 26),
                  blurRadius: 50,
                  spreadRadius: 0,
                  color: Colors.grey.withOpacity(.1)),
            ]),
            child: TextField(

              controller: widget.inputController,
              onChanged: (value) {
                setState(() {
                  widget.inputController.text = value; 
                });
              },
              obscureText: widget.hideText,
              keyboardType: TextInputType.emailAddress,
              style: const TextStyle(fontSize: 14, color: Colors.black),
              decoration: InputDecoration(
                // prefixIcon: Icon(Icons.email),
                filled: true,
                fillColor: accentColor,
                hintText: widget.description,
                hintStyle: TextStyle(color: Colors.grey.withOpacity(.75)),
                contentPadding:
                    const EdgeInsets.symmetric(vertical: 0.0, horizontal: 20.0),
                border: const OutlineInputBorder(
                  borderSide: BorderSide(color: primaryColor, width: 1.0),
                  borderRadius: BorderRadius.all(Radius.circular(10.0)),
                ),
                focusedBorder: const OutlineInputBorder(
                  borderSide: BorderSide(color: secondaryColor, width: 1.0),
                  borderRadius: BorderRadius.all(Radius.circular(10.0)),
                ),
               errorBorder:const OutlineInputBorder(
                  borderSide: BorderSide(color: errorColor, width: 1.0),
                  borderRadius: BorderRadius.all(Radius.circular(10.0)),
                ) ,
                enabledBorder: const OutlineInputBorder(
                  borderSide: BorderSide(color: primaryColor, width: 1.0),
                  borderRadius: BorderRadius.all(Radius.circular(10.0)),
                ),
              ),
            ),
          ),
        ],
    );
  }
}