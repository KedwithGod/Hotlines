import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hotlines_afrca/UI_functions/Loading.dart';
import 'package:hotlines_afrca/UI_functions/sizedbox.dart';
import '../UI_functions/Text.dart';
import '../pages/Functionality_page/DrawerOnly.dart';

import 'Hero.dart';
import 'package:url_launcher/url_launcher.dart';

_launchURL(String url) async {;
  if (await canLaunch(url)) {
    await launch(url);
  } else {
    throw 'Could not launch $url';
  }
}

class Servicedialog extends StatefulWidget {
  final String location;
  final String username;
  final String email;
  final String occupation;
  final String phone;
  final String text;
  final String agencydoc;
  final String agencycol;
  final String icondata;


  Servicedialog(this.location, this.username,this.email,this.text,this.agencydoc,this.agencycol,this.icondata,this.phone,
      this.occupation);

  @override
  _ServicedialogState createState() => _ServicedialogState();
}

class _ServicedialogState extends State<Servicedialog> with SingleTickerProviderStateMixin {
  TabController controller;
  var iconno=new List<int>.generate(100, (i)=> i+1);

  void iniState(){
    super.initState();
    loadData();
    controller= TabController(vsync: this,length: 3);
  }

  void dispose(){
    super.dispose();
  }

  @override
  Widget _buildListitem(BuildContext context,DocumentSnapshot document,index,String icon){
    Orientation orientation =MediaQuery.of(context).orientation;
    return
        Padding(
          padding: const EdgeInsets.fromLTRB(8.0,20.0,8.0,0.0),
          child: Container(
            alignment: Alignment.center,
            height: 63,
              decoration: BoxDecoration( border: Border.all(color: Colors.blue,style: BorderStyle.solid),
          borderRadius: BorderRadius.all(Radius.circular(30))),
          child:ListTile(
              leading: Hero(
                tag:
                '${document['name']}'
                ,
                child:  CircleAvatar(
                    backgroundColor: Colors.blue, radius:orientation==Orientation.portrait? MediaQuery.of(context).size.height*0.028
                    :MediaQuery.of(context).size.width*0.028,
                    child: Text('${iconno[index]}', style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: orientation==Orientation.portrait? MediaQuery.of(context).size.height*0.028
                          :MediaQuery.of(context).size.width*0.028,
                    ),
                      textAlign: TextAlign.center,
                    ),

                  ),

              ),
              title:  Column(children:[FlatButton(
                        child: Container(
                          child: Text(document['name'],
                              style: TextStyle(
                                  fontSize:orientation==Orientation.portrait? MediaQuery.of(context).size.height*0.030
                                      :MediaQuery.of(context).size.width*0.030,
                                  color: Colors.blue,
                                  fontWeight: FontWeight.bold),
                              textAlign: TextAlign.left),
                        alignment: Alignment.bottomLeft,
                        ),
                        onPressed: () {
                          ServiceDialog(context,document['name'],document['Description'],document['Phone'],icon);

                        }),

                    ]),
              )),
        );
  }

  Future<Timer> loadData() async{
    return Timer(Duration(seconds: 5), onDone);}

    onDone(){
    return Center(
      child: Material(
        elevation: 2.0,
        shadowColor: Colors.blue[400],
        color: Colors.white,
        borderRadius: BorderRadius.all(Radius.circular(25.0)),
        child: Column(mainAxisAlignment: MainAxisAlignment.center,children: <Widget>[
          Loading(),
          Textout('Fetching data', 0.034, Colors.blue)

        ],),
      ),
    );
    }


  Widget build(BuildContext context) {
    final TopText =Textout('${widget.text} IN ${widget.location.toUpperCase()}',0.022,Colors.white);

    return DefaultTabController(length: 3,child:Scaffold(
        backgroundColor: Colors.white,
        drawer: new DrawerOnly(widget.location,widget.username,widget.email,widget.phone,widget.occupation),
        appBar: AppBar(
          centerTitle: true,
          backgroundColor: Colors.blue,
          title:PreferredSize(
              preferredSize:MediaQuery.of(context).size*0.05,
              child: TopText)),

        body:
              StreamBuilder(
         stream: Firestore.instance.collection('Location').document(widget.agencydoc).collection(widget.agencycol).snapshots(),
          builder: (context,snapshot) {


           if(!snapshot.hasData)
             {return Center(child: Column(
               children: <Widget>[ Center(
             child: Material(
               elevation: 2.0,
               shadowColor: Colors.blue[400],
               color: Colors.white,
               borderRadius: BorderRadius.all(Radius.circular(25.0)),
               child: Column(mainAxisAlignment: MainAxisAlignment.center,children: <Widget>[
                 Loading(),
                 Textout('Fetching data', 0.034, Colors.blue)

               ],),
             ),
             )


               ],
             ));}
                  else if (snapshot.hasData){
                    return ListView.builder(
                  itemExtent: 80.0,
                  itemCount: snapshot.data.documents.length,
                  itemBuilder:(context, index)=>_buildListitem(context, snapshot.data.documents[index],index,widget.icondata));}
         return Center(child: Textout('Please put on your data, \n to access this page', 0.089, Colors.red));}
          ),

        //Center

    )); // Scaffold ,) Scaffold
  }
}

ServiceDialog(BuildContext context, String text, String text1, phone, String icon) async {
  return showDialog(
      context: context,
      builder: (context) {
        return Theme(
          data: ThemeData(dialogBackgroundColor: Colors.transparent),
          child: AlertDialog(
            content: ListView(children: [
              Card(color:Colors.white,elevation: 4.0,

                shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20),
            ),
              child: new Column(mainAxisSize: MainAxisSize.max,crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                Sizedbox(0.0233),
                Heroout( 'Service dialog logo', icon,0.20),Container(
                    padding: EdgeInsets.only(left: 20, right:20),
                    alignment: Alignment.center,
                      child: Textout('$text1',0.025,Colors.blue[400]))

                ,Container(
                      padding: EdgeInsets.only(left:20,right:20),
                      alignment: Alignment.center,child: Textout('$text',0.030,Colors.blue[900])),
                Sizedbox(0.0233),
                SizedBox.fromSize(
                  size: Size(63, 63), // button width and height
                  child: ClipOval(
                    child: Material(
                      color: Colors.blue[900], // button color
                      child: InkWell(
                        splashColor: Colors.blue, // splash color
                        onTap: () {_launchURL('tel: $phone');}, // button pressed
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Icon(Icons.call,color: Colors.white,), // icon
                            Textout("CALL",0.022,Colors.white), // text
                          ],
                        ),
                      ),
                    ),
                  ),
                ),


                  Sizedbox(0.0233)],),)]),

          ),
        );
      }
  );
}

























