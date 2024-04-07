import 'package:flutter/material.dart';

class DropDownSelectGrade extends StatefulWidget {
  const DropDownSelectGrade({super.key});

  @override
  State<DropDownSelectGrade> createState() => _DropDownSelectGradeState();
}

class _DropDownSelectGradeState extends State<DropDownSelectGrade> {
  var currentSelectedValue;
  
  static const deviceTypes = ["6", "7", "8", "9", "10", "11", "12"];
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15),
        color: Colors.blueGrey[50],
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
                currentSelectedValue = newValue;
              });
              print(currentSelectedValue);
            },
            items: deviceTypes.map((String value) {
              return DropdownMenuItem<String>(
                value: value,
                child: Text(value),
              );
            }).toList(),
          ),
        ),
      ),
    );
  }
}