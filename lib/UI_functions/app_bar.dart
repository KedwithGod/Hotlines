import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hotlines_afrca/UI_functions/sizedbox.dart';

class Appbarout extends StatelessWidget {
  final Widget headtx;
  final String loc;
  final String usr;

  Appbarout(this.headtx, this.loc, this.usr);

  @override
  Widget build(BuildContext context) {
    Orientation orientation = MediaQuery.of(context).orientation;
    return SafeArea(
        child: AppBar(
      centerTitle: true,
      backgroundColor: Colors.blue,
      elevation: 0.0,
      title: Container(padding: EdgeInsets.only(top: 10), child: headtx),
      bottom: PreferredSize(
          preferredSize: MediaQuery.of(context).size* 0.08,
          child: Padding(
            padding: EdgeInsets.only(left:  orientation == Orientation.portrait
                ? MediaQuery.of(context).size.height * 0.25
                : MediaQuery.of(context).size.width * 0.25,right:orientation == Orientation.portrait
                ? MediaQuery.of(context).size.height * 0.005
                : MediaQuery.of(context).size.width * 0.005),
            child: Column(
              mainAxisSize: MainAxisSize.max,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                    SizedBox(
                      height: 25,
                      child: OutlineButton.icon(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12)),
                        borderSide: BorderSide(color: Colors.white,style: BorderStyle.solid),
                        onPressed: null,
                        icon: Icon(
                          Icons.person,
                          size: orientation == Orientation.portrait
                              ? MediaQuery.of(context).size.height * 0.023
                              : MediaQuery.of(context).size.width * 0.023,
                          color: Colors.white,
                        ),
                        label: Text(
                          usr == null ? '' : usr,
                          style: TextStyle(
                            fontSize: orientation == Orientation.portrait
                                ? MediaQuery.of(context).size.height * 0.023
                                : MediaQuery.of(context).size.width * 0.023,
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                          textAlign: TextAlign.end,
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 3.0,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                    SizedBox(
                      height: 25,
                      child: OutlineButton.icon(
                        onPressed: null,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12)),
                        borderSide: BorderSide(color: Colors.white,style: BorderStyle.solid),
                        icon: Icon(
                          Icons.location_on,
                          size: orientation == Orientation.portrait
                              ? MediaQuery.of(context).size.height * 0.023
                              : MediaQuery.of(context).size.width * 0.023,
                          color: Colors.white,
                        ),
                        label: Text(
                          loc == null ? '' : loc,
                          style: TextStyle(
                            fontSize: orientation == Orientation.portrait
                                ? MediaQuery.of(context).size.height * 0.023
                                : MediaQuery.of(context).size.width * 0.023,
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                          textAlign: TextAlign.end,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          )),

      /*bottom: PreferredSize(
            preferredSize:MediaQuery.of(context).size*0.060,

            child: SafeArea(
              child: Container(
                padding: EdgeInsets.symmetric(horizontal:MediaQuery.of(context).size.height*0.02),
                child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: <Widget>[

                      Column(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: <Widget>[
                            Icon(Icons.location_on,
                              size:orientation==Orientation.portrait?MediaQuery.of(context).size.height*0.022:
                              MediaQuery.of(context).size.width*0.022,color: Colors.white,),
                            Icon(Icons.person,size: orientation==Orientation.portrait?MediaQuery.of(context).size.height*0.022:
                            MediaQuery.of(context).size.width*0.022,color: Colors.white,),

                          ]),


                      Column(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: <Widget>[Text(
                            loc,
                            style: TextStyle(
                              fontSize: orientation==Orientation.portrait?MediaQuery.of(context).size.height*0.022:
                              MediaQuery.of(context).size.width*0.022,
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                            ),textAlign: TextAlign.end,
                          ),

                            Text(

                              usr,
                              style: TextStyle(
                                fontSize: orientation==Orientation.portrait?MediaQuery.of(context).size.height*0.022:
                                MediaQuery.of(context).size.width*0.0,
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                              ),textAlign: TextAlign.end,
                            ),
                          ])
                    ]),
              ),
            ),

          )
*/
    ));
  }
}

/*
Column(
      mainAxisSize: MainAxisSize.min,
    crossAxisAlignment: CrossAxisAlignment.stretch,
    children: <Widget>[
      Row(mainAxisAlignment: MainAxisAlignment.end,
        children: <Widget>[
          FlatButton.icon(onPressed: null, icon:Icon(Icons.person,
            size:orientation==Orientation.portrait?MediaQuery.of(context).size.height*0.018:
            MediaQuery.of(context).size.width*0.018,color: Colors.white,), label: Text(

            usr,
            style: TextStyle(
              fontSize: orientation==Orientation.portrait?MediaQuery.of(context).size.height*0.018:
              MediaQuery.of(context).size.width*0.018,
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),textAlign: TextAlign.end,
          ),),
        ],
      ),
      Row(mainAxisAlignment: MainAxisAlignment.end,
        children: <Widget>[
          FlatButton.icon(onPressed: null, icon: Icon(Icons.location_on,
            size:orientation==Orientation.portrait?MediaQuery.of(context).size.height*0.018:
            MediaQuery.of(context).size.width*0.018,color: Colors.white,), label: Text(
            loc,
            style: TextStyle(
              fontSize: orientation==Orientation.portrait?MediaQuery.of(context).size.height*0.018:
              MediaQuery.of(context).size.width*0.018,
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),textAlign: TextAlign.end,
          ),),
        ],
      )

    ],
    ),


bottom: PreferredSize(
preferredSize:MediaQuery.of(context).size*0.060,

child: SafeArea(
child: Container(
padding: EdgeInsets.symmetric(horizontal:MediaQuery.of(context).size.height*0.02),
child: Row(
mainAxisAlignment: MainAxisAlignment.end,
children: <Widget>[
Column(
mainAxisAlignment: MainAxisAlignment.end,
children: <Widget>[
Icon(Icons.location_on,
size:orientation==Orientation.portrait?MediaQuery.of(context).size.height*0.03:
MediaQuery.of(context).size.width*0.03,color: Colors.white,),
Icon(Icons.person,size: orientation==Orientation.portrait?MediaQuery.of(context).size.height*0.03:
MediaQuery.of(context).size.width*0.03,color: Colors.white,),

]),


Column(
mainAxisAlignment: MainAxisAlignment.end,
children: <Widget>[Text(
loc,
style: TextStyle(
fontSize: orientation==Orientation.portrait?MediaQuery.of(context).size.height*0.03:
MediaQuery.of(context).size.width*0.03,
color: Colors.white,
fontWeight: FontWeight.bold,
),textAlign: TextAlign.end,
),

Text(

usr,
style: TextStyle(
fontSize: orientation==Orientation.portrait?MediaQuery.of(context).size.height*0.03:
MediaQuery.of(context).size.width*0.03,
color: Colors.white,
fontWeight: FontWeight.bold,
),textAlign: TextAlign.end,
),
])
]),
),
),

)*/
