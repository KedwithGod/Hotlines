import 'package:flutter/material.dart';

class BottomNavigationout extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    Orientation orientation =MediaQuery.of(context).orientation;
    return SafeArea(
      child: BottomAppBar(
        child: Text(
          'Emergency services at your finger tips',
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            fontSize:orientation==Orientation.portrait? MediaQuery.of(context).size.height*0.025:MediaQuery.of(context).size.width*0.025 ,
          ),
          textAlign: TextAlign.center,
        ),
        color: Colors.blue,
      ),
    );
  }
}
