import 'package:flutter/material.dart';
class Herowid extends StatelessWidget {
  
  final String tag;
  final double size;
  final IconData icon;
  const Herowid(this.tag, this.size, this.icon);
  @override
  Widget build(BuildContext context) {
    Orientation orientation =MediaQuery.of(context).orientation;
    return  Hero(
          tag: tag,
          child: CircleAvatar(
              backgroundColor: Colors.transparent,
              radius: orientation==Orientation.portrait? MediaQuery.of(context).size.height*0.040:MediaQuery.of(context).size.width*0.060 ,
              child: Icon(icon,
                size: orientation==Orientation.portrait? MediaQuery.of(context).size.height*size:MediaQuery.of(context).size.width*size,
                color: Colors.blue[900],
              )));
  }

}