import 'package:flutter/material.dart';
import 'package:mentor_match/home_pages/admin/GroupHome.dart';

class GroupCardAdmin extends StatefulWidget {
  final String title; 
  final String subtitle; 
  final String groupID; 
  const GroupCardAdmin({super.key, required this.title, required this.subtitle, required this.groupID});

  @override
  State<GroupCardAdmin> createState() => _GroupCardAdminState();
}

class _GroupCardAdminState extends State<GroupCardAdmin> {
  @override
  Widget build(BuildContext context) {
    return Card(
        elevation: 5.0,
        shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(27),
        ),
        margin: new EdgeInsets.symmetric(horizontal: 10.0, vertical: 6.0),
        child: Container(

            width: MediaQuery.of(context).size.width * 0.8,
            decoration: BoxDecoration(color: Color.fromARGB(200, 165, 55, 253), borderRadius: BorderRadius.circular(27),),
            child: ListTile(
                onTap: () {
                  Navigator.of(context).push(MaterialPageRoute(builder: (context) => GroupHome(title: widget.title, groupID: widget.groupID)));
                },
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(27)
                ),
                contentPadding:
                    EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
                leading: Container(
                  padding: EdgeInsets.only(right: 12.0),
                  decoration: BoxDecoration(
                      border: new Border(
                          right: new BorderSide(
                              width: 1.0, color: Colors.white24))),
                  child: Icon(Icons.group, color: Colors.white),
                ),
                title: Text(
                  widget.title,
                  style: TextStyle(
                      color: Colors.white, fontWeight: FontWeight.bold),
                ),
                // subtitle: Text("Intermediate", style: TextStyle(color: Colors.white)),

                subtitle: Row(
                  children: <Widget>[
                    Icon(Icons.linear_scale, color: Colors.white),
                    Text(widget.subtitle, style: TextStyle(color: Colors.white))
                  ],
                ),
                trailing: Icon(Icons.keyboard_arrow_right,
                    color: Colors.white, size: 30.0))),
      );
  }
}