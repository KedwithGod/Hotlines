import 'package:flutter/material.dart';

class Heroout extends StatelessWidget {
  final String no;
  final double size;
  final String name;

  const Heroout( this.no, this.name, this.size);

  @override
  Widget build(BuildContext context) {
    Orientation orientation =MediaQuery.of(context).orientation;
    return
      Hero(
        tag:
        'hero $no'
        ,
        child: CircleAvatar(
          backgroundColor: Colors.transparent, radius: orientation==Orientation.portrait?
        MediaQuery.of(context).size.height*size:MediaQuery.of(context).size.width*size ,
          child: Image.asset(name),

        ),
      )
    ;
  }
}
