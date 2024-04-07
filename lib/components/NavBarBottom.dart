import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:mentor_match/auth/Welcome.dart';
import 'package:mentor_match/home_pages/student/AllTutoringSessions.dart';
import 'package:mentor_match/home_pages/student/JoinAnotherGroup.dart';
import 'package:mentor_match/home_pages/student/JoinGroup.dart';
import 'package:mentor_match/home_pages/student/PendingSessions.dart';
import 'package:mentor_match/home_pages/student/RequestTutor.dart';
import 'package:mentor_match/home_pages/student/StudentHomeBase.dart';
import 'package:mentor_match/home_pages/student/StudentProfile.dart';

class DrawerFb1 extends StatelessWidget {
  const DrawerFb1({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
        child: Material(
          color: const Color.fromRGBO(108, 99, 255, 1),
          child: ListView(
            children: <Widget>[
              Container(
                padding: EdgeInsets.all(15.0),
                child: Column(
                  children: [
                    const SizedBox(height: 12),
                  
                    MenuItem(
                      text: 'Home',
                      icon: Icons.home_outlined,
                      onClicked: () => selectedItem(context, 0),
                    ),
                    const SizedBox(height: 5),
                    MenuItem(
                      text: 'Join Group',
                      icon: Icons.person_add_alt_1_outlined,
                      onClicked: () => selectedItem(context, 1),
                    ),
                    
                    const SizedBox(height: 5),
                    MenuItem(
                      text: 'Pending Sessions',
                      icon: Icons.timer_outlined,
                      onClicked: () => selectedItem(context, 2),
                    ),
                    const SizedBox(height: 5),
                    MenuItem(
                      text: 'Schedule Tutor',
                      icon: Icons.add_outlined,
                      onClicked: () => selectedItem(context, 3),
                    ),
                    const SizedBox(height: 8),
                    Divider(color: Colors.white70),
                    const SizedBox(height: 8),
                    MenuItem(
                      text: 'View Profile',
                      icon: Icons.person_3_outlined,
                      onClicked: () => selectedItem(context, 4),
                    ),
                    MenuItem(
                      text: 'Log Out',
                      icon: Icons.logout_outlined,
                      onClicked: () => selectedItem(context, 5),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
    );
  }



  Future<void> selectedItem(BuildContext context, int index) async {
    Navigator.of(context).pop();
    switch (index) {
      case 0:
        // Navigator.of(context).push(MaterialPageRoute(
        //   builder: (context) => StudentHomeLoaded(), // Page 1
        // ));
        break;
      case 1:
        Navigator.of(context).push(MaterialPageRoute(
          builder: (context) => JoinGroup(uid: FirebaseAuth.instance.currentUser!.uid,), // Page 2
        ));
        break;
      case 2:
        Navigator.of(context).push(MaterialPageRoute(
          builder: (context) => PendingSessions(),
        ));
        break;
      case 3:
        Navigator.of(context).push(MaterialPageRoute(
          builder: (context) => RequestTutor(), // Page 4
        ));
        break;
      case 4:
        Navigator.of(context).push(MaterialPageRoute(
          builder: (context) => StudentProfile(), // Page 4
        ));
        break;
      case 5:
        await FirebaseAuth.instance.signOut(); 
        Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => Welcome()));
        break;
    }
  }
}
class MenuItem extends StatelessWidget {
  final String text;
  final IconData icon;
  final VoidCallback? onClicked;
  
  const MenuItem({required this.text,
    required this.icon,
    this.onClicked,Key? key, }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final color = Colors.white;
    final hoverColor = Colors.white70;

    return ListTile(
      leading: Icon(icon, color: color),
      title: Text(text, style: TextStyle(color: color)),
      hoverColor: hoverColor,
      onTap: onClicked,
    );
  }
}
class SearchFieldDrawer extends StatelessWidget {
  const SearchFieldDrawer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final color = Colors.white;

    return TextField(
      style: TextStyle(color: color,fontSize: 14),
      decoration: InputDecoration(
        contentPadding: EdgeInsets.symmetric(horizontal: 5, vertical: 5),
        hintText: 'Search',
        hintStyle: TextStyle(color: color),
        prefixIcon: Icon(Icons.search, color: color,size: 20,),
        filled: true,
        fillColor: Colors.white12,
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(15),
          borderSide: BorderSide(color: color.withOpacity(0.7)),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(15),
          borderSide: BorderSide(color: color.withOpacity(0.7)),
        ),
      ),
    );
  }
}