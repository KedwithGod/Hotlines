import 'package:flutter/material.dart';

import 'Text.dart';

class Appbar2 extends StatelessWidget {
  final String txt;
  final double fontSize;

  const Appbar2(this.txt,this.fontSize);

  @override
  Widget build(BuildContext context) {
    return  AppBar(
        title:
        Container(
            padding: EdgeInsets.all(2.0),
            child:Textout( txt, fontSize,Colors.white),
                ),

        centerTitle: true,
        backgroundColor: Colors.blue,
      elevation: 0.0,
      );
  }
}
