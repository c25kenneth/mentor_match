import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:mentor_match/components/TopBar.dart';
import 'package:mentor_match/home_pages/admin/PendingSessionsAdmin.dart';

class GroupHome extends StatefulWidget {
  final String title; 
  final String groupID; 
  const GroupHome({super.key, required this.title, required this.groupID});

  @override
  State<GroupHome> createState() => _GroupHomeState();
}

class _GroupHomeState extends State<GroupHome> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
              title: Text(widget.title, style: TextStyle(
                color: Colors.black, fontSize: 25, fontWeight: FontWeight.bold),),
              
      ),
      body: Column(
        children: [
          Expanded(
            child: GridView.count(
              primary: false,
              padding: const EdgeInsets.all(20),
              crossAxisSpacing: 10,
              mainAxisSpacing: 10,
              crossAxisCount: 2,
              children: <Widget>[
                Material(
                  elevation: 8,
                  borderRadius: BorderRadius.circular(15),
                  child: InkWell(
                    onTap: () {
                      
                    },
                    child: Container(
                      padding: const EdgeInsets.all(8),
                      child: Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(Icons.view_agenda, color: Colors.deepPurple[300], size: 45,),
                            SizedBox(height: 15),
                            Text("All Sessions", style: TextStyle(color: Colors.deepPurple[300], fontSize: 18),)
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
                Material(
                  elevation: 8,
                  borderRadius: BorderRadius.circular(15),
                  child: InkWell(
                    onTap: (){
                       Navigator.of(context).push(MaterialPageRoute(builder: (context) => PendingSessionsAdmin(groupID: widget.groupID,)));
                    },
                    child: Container(
                      padding: const EdgeInsets.all(8),
                      child: Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(Icons.schedule, color: Colors.deepPurple[300], size: 45,),
                            SizedBox(height: 15),
                            Text("Pending Sessions", style: TextStyle(color: Colors.deepPurple[300], fontSize: 15),)
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
                Material(
                  elevation: 8,
                  borderRadius: BorderRadius.circular(15),
                  child: InkWell(
                    onTap: (){
                      
                    },
                    child: Container(
                      padding: const EdgeInsets.all(8),
                      child: Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(Icons.group, color: Colors.deepPurple[300], size: 45,),
                            SizedBox(height: 15),
                            Text("Members", style: TextStyle(color: Colors.deepPurple[300], fontSize: 18),)
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
                Material(
                  elevation: 8,
                  borderRadius: BorderRadius.circular(15),
                  child: InkWell(
                    onTap: (){
                      
                    },
                    child: Container(
                      padding: const EdgeInsets.all(8),
                      child: Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(Icons.info, color: Colors.deepPurple[300], size: 45,),
                            SizedBox(height: 15),
                            Text("Group Info", style: TextStyle(color: Colors.deepPurple[300], fontSize: 18),)
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}