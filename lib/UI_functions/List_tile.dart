import 'package:flutter/material.dart';
import 'package:hotlines_afrca/UI_functions/Text.dart';

class Listtileout extends StatelessWidget {
  final String tip;
  final Function press;
  final String tex;
  final Widget icon;
  const Listtileout( this.tip, this.press, this.tex, this.icon);
  @override
  Widget build(BuildContext context) {
    Orientation orientation =MediaQuery.of(context).orientation;
    return

        ListTile(
            title: SizedBox(height:orientation==Orientation.landscape? MediaQuery.of(context).size.width*0.090:MediaQuery.of(context).size.height*0.090 ,
              width: orientation==Orientation.landscape? MediaQuery.of(context).size.height*0.028:MediaQuery.of(context).size.width*0.028 ,
              child: Tooltip(
              message:
              tip,
              verticalOffset:orientation==Orientation.portrait? MediaQuery.of(context).size.height*0.027:MediaQuery.of(context).size.width*0.027,
              decoration: BoxDecoration(color: Colors.white,
                shape: BoxShape.rectangle,),
                height: 30,

          child: Container(
          height:orientation==Orientation.landscape? MediaQuery.of(context).size.width*0.090:MediaQuery.of(context).size.height*0.090 ,
          width: orientation==Orientation.landscape? MediaQuery.of(context).size.height*0.028:MediaQuery.of(context).size.width*0.028 ,
          padding: EdgeInsets.all(8.0),

          child: FlatButton(
          color: Colors.white,
                shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              onPressed: press,
              padding: EdgeInsets.all(8),

                child: Stack(
                  children: <Widget>[
                    Align(
                        alignment: Alignment.centerRight,
                        child: icon
                    ),
                    Align(
                        alignment: Alignment.centerLeft,
                        child:  Textout(tex,  0.025,Colors.blue[900]) )
                        ,

                  ],),


          ),
      )),
            ));



  }
}
