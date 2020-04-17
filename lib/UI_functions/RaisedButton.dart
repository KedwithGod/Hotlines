import 'package:flutter/material.dart';

class RaisedButtonout extends StatelessWidget {
final String tip;
  final Function press;
  final double fontsize;
  final String tex;

  const RaisedButtonout( this.tip, this.press, this.fontsize,this.tex) ;

  @override
  
  Widget build(BuildContext context) {
    Orientation orientation =MediaQuery.of(context).orientation;
    return SafeArea(
      child: Tooltip(
          message: '$tip',
          verticalOffset: orientation==Orientation.portrait? MediaQuery.of(context).size.height*0.07:MediaQuery.of(context).size.width*0.07,
          height: 30,
            child: SizedBox(
              height: MediaQuery.of(context).size.height*0.05,
              width: MediaQuery.of(context).size.width*0.31,

              child: RaisedButton(
                  splashColor: Colors.green,
                  color: Colors.blue,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(orientation==Orientation.portrait? MediaQuery.of(context).size.height*0.030:MediaQuery.of(context).size.width*0.030,),
                  ),
                  onPressed:press,
                  padding: EdgeInsets.all(2),
                  child: Text(
                    '$tex',
                    style: TextStyle(color: Colors.white, fontSize:orientation==Orientation.portrait? MediaQuery.of(context).size.height*fontsize:MediaQuery.of(context).size.width*fontsize, fontWeight: FontWeight.bold),
                  )),
            ),
          ),
    );
  }
}
