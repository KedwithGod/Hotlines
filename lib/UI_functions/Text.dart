import 'package:flutter/material.dart';

class Textout extends StatelessWidget {
  final String text;
  final double fontSize;
  final Color color;
  const Textout( this.text, this.fontSize,this.color) ;

  @override
  Widget build(BuildContext context) {
    Orientation orientation =MediaQuery.of(context).orientation;
    return
          Text(
            text,
            style: TextStyle(
                fontSize:orientation==Orientation.portrait? MediaQuery.of(context).size.height*fontSize
                    :MediaQuery.of(context).size.width*fontSize, color: color, fontWeight: FontWeight.bold),
            textAlign: TextAlign.left,

    ) ;
  }
}
