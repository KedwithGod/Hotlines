import 'package:flutter/material.dart';

class Sizedbox extends StatelessWidget {
  final double size;
  Sizedbox(this.size);
  @override
  Widget build(BuildContext context) {
    Orientation orientation =MediaQuery.of(context).orientation;
    return SizedBox(height: 
    orientation==Orientation.portrait?
      MediaQuery.of(context).size.height*size:
      MediaQuery.of(context).size.width*size,);
      
    
  }
}