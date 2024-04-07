import 'package:flutter/material.dart';

class DrawerTile extends StatefulWidget {
  final String title;
  final IconData icon;
  final Function onTap;
  final bool isSelected; 
  final Color iconColor;

  DrawerTile(
      {
        required this.title,
        required this.icon,
        required this.onTap,
        required this.isSelected,
        required this.iconColor});

  @override
  State<DrawerTile> createState() => _DrawerTileState();
}

class _DrawerTileState extends State<DrawerTile> {

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: widget.onTap(),
      child: Container(
          padding: EdgeInsets.all(16),
          decoration: BoxDecoration(
              color: widget.isSelected ? Colors.grey[200] : Colors.white,
              borderRadius: BorderRadius.all(Radius.circular(8))),
          child: Row(
            children: [
              Icon(widget.icon,
                  size: 20, color: widget.isSelected ? Color.fromRGBO(108, 99, 255, 1) : Color.fromRGBO(108, 99, 255, 0.7)),
              Padding(
                padding: const EdgeInsets.only(left: 8.0),
                child: Text(widget.title,
                    style: TextStyle(
                        letterSpacing: .3,
                        fontSize: 15,
                        color: widget.isSelected
                            ? Colors.black
                            : Color.fromRGBO(0, 0, 0, 1))),
              )
            ],
          )),
    );
  }
}
