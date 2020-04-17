import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hotlines_afrca/UI_functions/Text.dart';
import 'package:hotlines_afrca/UI_functions/TextField.dart';
import 'package:hotlines_afrca/UI_functions/app_bar.dart';
import 'package:hotlines_afrca/UI_functions/sizedbox.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:hotlines_afrca/pages/Emergency_contact_pages/Emergency_contact.dart';
import 'package:hotlines_afrca/pages/Functionality_page/DrawerOnly.dart';
import 'package:hotlines_afrca/UI_functions/shared_preference.dart';

enum option{edit,insert}

Future<option> displayDialog(BuildContext context) async{
  Orientation orientation =MediaQuery.of(context).orientation;
  return showDialog<option>(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Textout( 'You clicked Edit button', 0.028,Colors.blue) ,
          content: Textout( 'What will you like to do to the contact', 0.028,Colors.blue) ,
          actions: <Widget>[
            Tooltip(
                message:
                'ADD A NEW CONTACT TO THE LIST',
                verticalOffset: 48,
                height: 30,
                child: Container(
                  height: MediaQuery.of(context).size.height * 0.15,
                  width: MediaQuery.of(context).size.width * 0.20,
                  padding: EdgeInsets.symmetric(vertical: 16.0),
                  child: FlatButton(
                      color: Colors.blue,shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(24),
                  ),
                      onPressed: () {Navigator.of(context).pop(option.insert);},
                      padding: EdgeInsets.all(8),
                      child: Text(
                        'ADD',
                        style: TextStyle(
                            color: Colors.white,
                            fontSize:
                            orientation==Orientation.portrait?MediaQuery
                                .of(context)
                                .size
                                .height * 0.027:MediaQuery
                                .of(context)
                                .size
                                .width * 0.027,
                            fontWeight: FontWeight.bold),
                      )),
                )),
            Tooltip(
                message:
                'EDIT THIS CONTACT',
                verticalOffset: 48,
                height: 30,
                child: Container(
                  height: MediaQuery.of(context).size.height * 0.15,
                  width: MediaQuery.of(context).size.width * 0.20,
                  padding: EdgeInsets.symmetric(vertical: 16.0),
                  child: FlatButton(
                      color: Colors.blue,shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(24),
                  ),
                      onPressed: () {Navigator.of(context).pop(option.edit);},
                      padding: EdgeInsets.all(8),
                      child: Text(
                        'EDIT ',
                        style: TextStyle(
                            color: Colors.white,
                            fontSize:
                            orientation==Orientation.portrait?MediaQuery
                                .of(context)
                                .size
                                .height * 0.027:MediaQuery
                                .of(context)
                                .size
                                .width * 0.027,

                            fontWeight: FontWeight.bold),
                      )),
                ))
          ],
        );
      });
}//AppBar}

class Contact extends StatefulWidget{

  final location;
  final username;
  final email;
  final String phone;
  final String occupation;


  Contact(
      this.location, this.username, this.email, this.phone, this.occupation);

  @override
  ContactState createState() => ContactState();
}

class ContactState extends State<Contact> {
  TextEditingController eCtrl = new TextEditingController();
  TextEditingController pCtrl = new TextEditingController();
  int count=0;
  List namelist;
  List numberlist;
  List<int> iconlist=[1,2,3,4,5,6,7];
  var getlist;
  bool autovalidate=false;
  bool colorchange=false;
  var listController=ScrollController();

  void initState(){
    super.initState();
    getValues ();

  }

getValues ()async {
   await Utility.getnamelist(namelist).then((onValue){setState(() {
      setState(() {
        namelist=onValue;
      });
    });});
   await Utility.getnumberlist(numberlist).then((onValue){setState(() {
      setState(() {
        numberlist=onValue;
      });
    });});
  }

  void deleteItem(index) async{
    setState(() {
      namelist.removeAt(index);

    });
    await Utility.savenamelist(namelist);
  }

  void undoDeletion(index, item,item2) async {
    /*
    This method accepts the parameters index and item and re-inserts the {item} at
    index {index}
    */
    setState(() {
      namelist.insert(index, item);
      numberlist.insert(index, item2);

    });

    await Utility.savenamelist(namelist);
    await Utility.savenumberlist(numberlist);
  }




  removeitem( index) async {
    setState(() {
      numberlist.removeAt(index);

    });
    await Utility.savenumberlist(numberlist);
  }

  _launchURL(String url) async {
  if (await canLaunch(url)) {
    await launch(url);
  } else {
    throw 'Could not launch $url';
  }
  }

  Widget emptyList(){
    return Center(
        child:  Text('No items')
    );
  }
  Widget List_Builder() {
    Orientation orientation =MediaQuery.of(context).orientation;

    return ListView.builder(
      scrollDirection: Axis.vertical,
        controller: listController,
        shrinkWrap: true,
        itemCount: namelist.length,
        itemBuilder: (BuildContext context,int index) {

          return Dismissible(
              key: Key('${namelist[index]}'),
          onDismissed: (direction){var item = namelist.elementAt(index);
          var item2 = numberlist.elementAt(index);
          //To delete

          deleteItem(index);
          removeitem(index);

          //To show a snackbar with the UNDO button
          Scaffold.of(context).showSnackBar(SnackBar(
          content: Text("item deleted"),
          action: SnackBarAction(
          label: "UNDO",
          onPressed: () {
          //To undo deletion
          undoDeletion(index, item,item2);
          })));},
          direction: DismissDirection.startToEnd,
          background: Container(color:Colors.red[700]),child:SingleChildScrollView(
              child:Padding(
              padding: const EdgeInsets.fromLTRB(8.0, 20.0, 8.0, 0.0),
              child: Container(
                alignment: Alignment.center,
                height: 63,
                decoration: BoxDecoration(
                    border: Border.all(
                        color: Colors.blue, style: BorderStyle.solid),
                    borderRadius: BorderRadius.all(Radius.circular(30))),
                child: ListTile(
                    leading: Hero(
                      tag:
                      '${iconlist[index]}'
                      ,
                      child: CircleAvatar(
                        backgroundColor: Colors.blue, radius:20,
                        child: Text('${iconlist[index]}', style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: orientation==Orientation.portrait?MediaQuery
                              .of(context)
                              .size
                              .height * 0.027:MediaQuery
                              .of(context)
                              .size
                              .width * 0.027,
                        ),
                          textAlign: TextAlign.center,
                        ),

                      ),
                    ),
                    title: FlatButton(
                      child: Text('${namelist[index]}',
                          style: TextStyle(
                              fontSize:  orientation==Orientation.portrait?MediaQuery
                                  .of(context)
                                  .size
                                  .width * 0.06:MediaQuery
                                  .of(context)
                                  .size
                                  .height * 0.06,
                              color: Colors.blue,
                              fontWeight: FontWeight.bold),
                          textAlign: TextAlign.left),
                      onPressed: (){_launchURL('tel: ${numberlist[index]}');},
                      onLongPress: () async {var item = namelist.elementAt(index);
                      var item2 = numberlist.elementAt(index);
                      //To delete

                      deleteItem(index);
                      removeitem(index);

                      //To show a snackbar with the UNDO button
                      Scaffold.of(context).showSnackBar(SnackBar(
                          content: Text("${namelist[index]} deleted"),
                          action: SnackBarAction(
                              label: "UNDO",
                              onPressed: () {
                                //To undo deletion
                                undoDeletion(index, item,item2);
                                })));},
                      highlightColor: Colors.blue,
                      splashColor: Colors.green,
                    ),
                    trailing:
                    RaisedButton(padding: EdgeInsets.all(8),
                        splashColor: Colors.green,
                        color: Colors.blue,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(orientation==Orientation.portrait?
                          MediaQuery.of(context).size.height*0.030:MediaQuery.of(context).size.width*0.030,),
                        ),
                        child: Text(
                            'Edit',
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: orientation==Orientation.portrait?MediaQuery
                                    .of(context)
                                    .size
                                    .height * 0.027:MediaQuery
                                    .of(context)
                                    .size
                                    .width * 0.027,
                                fontWeight: FontWeight.bold))
                        ,
                        onPressed: ()async { if (namelist.length==7){return showDialog(
                            context: context,
                            builder: (context) {
                              return AlertDialog(title: Textout( 'EDIT CONTACT',  0.035,Colors.blue),
                                content: SingleChildScrollView(
                                  child: Column(
                                    children:[
                                      Textfieldout(TextInputType.text, eCtrl, 'Contact Name',
                                      'Enter contact name', Icons.person, 'name'),
                                    SizedBox(
                                      height: 20.0,
                                    ),
                                    Textfieldout(TextInputType.number, pCtrl, 'Enter phone no',
                                        '0812345678', Icons.phone, 'phone', )]),
                                ),
                                actions: <Widget>[
                                  Tooltip(
                                      message:
                                      'This button help you edit and replace your contact',
                                      verticalOffset: 48,
                                      height: 30,
                                      child: Container(
                                          height:  orientation==Orientation.portrait?MediaQuery
                                              .of(context)
                                              .size
                                              .height * 0.15:MediaQuery
                                              .of(context)
                                              .size
                                              .width * 0.15,
                                          width: orientation==Orientation.portrait?MediaQuery
                                              .of(context)
                                              .size
                                              .width * 0.50:MediaQuery
                                              .of(context)
                                              .size
                                              .height * 0.50,
                                          padding: EdgeInsets.symmetric(vertical: 16.0),
                                          child: RaisedButton(
                                              color: Colors.blue,
                                              shape: RoundedRectangleBorder(
                                                borderRadius: BorderRadius.circular(orientation==Orientation.portrait?
                                                MediaQuery.of(context).size.height*0.030:MediaQuery.of(context).size.width*0.030,),

                                              ),
                                              onPressed: () async {

                                                    namelist.removeAt(index);
                                                    namelist.insert(index,eCtrl.text);
                                                    numberlist.removeAt(index);
                                                    numberlist.insert(index,pCtrl.text);
                                                    setState(() {

                                                    });
                                                    await Utility.savenamelist(namelist);
                                                    await Utility.savenumberlist(numberlist);
                                                   Navigator.pop(context);
                                                    await Navigator.push(context,
                                                        MaterialPageRoute(
                                                            builder: (context) => Contact(widget.location, widget.username, widget.email, widget.phone, widget.occupation)));

                                              },

                                              padding: EdgeInsets.all(8),
                                              child: Text(
                                                  'UPDATE',
                                                  style: TextStyle(
                                                      color: Colors.white,
                                                      fontSize:
                                                      orientation==Orientation.portrait?MediaQuery
                                                          .of(context)
                                                          .size
                                                          .height * 0.027:MediaQuery
                                                          .of(context)
                                                          .size
                                                          .width * 0.027,

                                                      fontWeight: FontWeight.bold))))

                                  )],
                              );
                            });}if (namelist.length<7){option opt= await displayDialog(context); if (opt==option.edit){
                          return showDialog(
                              context: context,
                              builder: (context) {
                                return AlertDialog(title: Textout( 'EDIT CONTACT',  0.035,Colors.blue),
                                  content: SingleChildScrollView(
                                    child: Column(
                                        children:[
                                        Textfieldout(TextInputType.text, eCtrl, 'Contact Name',
                                        'Enter contact name', Icons.person, 'name'),
                                      SizedBox(
                                        height: 20.0,
                                      ),
                                      Textfieldout(TextInputType.number, pCtrl, 'Enter phone no',
                                          '0812345678', Icons.phone, 'phone', )]),
                                  ),
                                  actions: <Widget>[
                                    Tooltip(
                                        message:
                                        'This button help you edit and replace your contact',
                                        verticalOffset: 48,
                                        height: 30,
                                        child: Container(
                                            height: orientation==Orientation.portrait?MediaQuery
                                                .of(context)
                                                .size
                                                .height * 0.15:MediaQuery
                                                .of(context)
                                                .size
                                                .width * 0.15,
                                            width: orientation==Orientation.portrait?MediaQuery
                                                .of(context)
                                                .size
                                                .width * 0.50:MediaQuery
                                                .of(context)
                                                .size
                                                .height * 0.50,
                                            padding: EdgeInsets.symmetric(vertical: 16.0),
                                            child: FlatButton(
                                                color: Colors.blue,
                                                onPressed: () async {
                                                  namelist.removeAt(index);
                                                  namelist.insert(index,eCtrl.text);
                                                  numberlist.removeAt(index);
                                                  numberlist.insert(index,pCtrl.text);
                                                 setState(() {


                                                 });
                                                await Utility.savenamelist(namelist);
                                                 await Utility.savenumberlist(numberlist);
                                                Navigator.pop(context);
                                                  await Navigator.push(context,
                                                      MaterialPageRoute(
                                                          builder: (context) => Contact(widget.location, widget.username, widget.email, widget.phone, widget.occupation)));

                                                },


                                                padding: EdgeInsets.all(8),
                                                child: Text(
                                                    'UPDATE ',
                                                    style: TextStyle(
                                                        color: Colors.white,
                                                        fontSize:
                                                        orientation==Orientation.portrait?MediaQuery
                                                            .of(context)
                                                            .size
                                                            .height * 0.027:MediaQuery
                                                            .of(context)
                                                            .size
                                                            .width * 0.027,
                                                        fontWeight: FontWeight.bold))))

                                    )],
                                );
                              });
                        }else{return showDialog(
                            context: context,
                            builder: (context) {
                              return AlertDialog(
                                title: Textout( 'ADD NEW CONTACT', 0.035,Colors.blue),
                                content: ListView(
                                    shrinkWrap: true,
                                    children:[
                                  Textfieldout(TextInputType.text, eCtrl, 'Contact Name',
                                      'Enter contact name', Icons.person, 'name', ),
                                  SizedBox(
                                    height: 20.0,
                                  ),
                                  Textfieldout(TextInputType.number, pCtrl, 'Enter phone no',
                                      '0812345678', Icons.phone, 'phone', )]),
                                actions: <Widget>[
                                  Tooltip(
                                      message:
                                      'This button help you edit and replace your contact',
                                      verticalOffset: 48,
                                      height: 30,
                                      child: Container(
                                          height: orientation==Orientation.portrait?MediaQuery
                                              .of(context)
                                              .size
                                              .height * 0.15:MediaQuery
                                              .of(context)
                                              .size
                                              .width * 0.15,
                                          width: orientation==Orientation.portrait?MediaQuery
                                              .of(context)
                                              .size
                                              . width * 0.15:MediaQuery
                                              .of(context)
                                              .size
                                              .height * 0.15,
                                          padding: EdgeInsets.symmetric(vertical: 16.0),
                                          child: FlatButton(
                                            color: Colors.blue,
                                            shape: RoundedRectangleBorder(
                                              borderRadius: BorderRadius.circular(24),
                                            ),
                                            onPressed: () async{
                                                  setState(() {
                                                    namelist.insert(index,eCtrl.text);
                                                    numberlist.insert(index,pCtrl.text);
                                                  });
                                                  Utility.savenamelist(namelist);
                                                  Utility.savenumberlist(numberlist);


                                                  await Utility.savenamelist(namelist);
                                                  await Utility.savenumberlist(numberlist);
                                                  Navigator.pop(context);
                                                  await Navigator.push(context,
                                                      MaterialPageRoute(
                                                          builder: (context) => Contact(widget.location, widget.username, widget.email, widget.phone, widget.occupation)));;
                                            },
                                            padding: EdgeInsets.all(8),
                                            child: Textout( 'ADD', 0.022,Colors.white),))

                                  )],
                              );
                            });
                        }}})),
              ),
            ),
          ));

        });
  }

  namevalue() {
    return ;
  }

  @override
  Widget build(BuildContext context) {




    return WillPopScope(
      onWillPop: () async =>false,
      child: Scaffold(
        backgroundColor: Colors.white,
        drawer:DrawerOnly(widget.location, widget.username, widget.email,widget.phone,widget.occupation),
        appBar: PreferredSize(
            preferredSize: Size.fromRadius(65),
            child: Appbarout( Textout( 'Emergency contact',  0.030,Colors.white), widget.location,  widget.username)),
        body:
        SingleChildScrollView(
          child: Column(mainAxisSize: MainAxisSize.max,
            children: <Widget>[
              FutureBuilder(
                  future: Utility.getnamelist(namelist),
                  builder: (context, snapshot){if (snapshot.connectionState==ConnectionState.done){
                    if (snapshot.data==null){
                      return Center(
                          child: Textout('Click the + button to add contact', 0.023, Colors.blue));
                    }
                    else if (snapshot.hasData){
                      return SingleChildScrollView(
                        child: Column(
                          children: <Widget>[SizedBox(
                              child: Card(
                                color: Colors.white,
                                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15.0)),
                                elevation: 0.0,

                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: <Widget>[
                                    FlatButton.icon(onPressed: null, icon: Icon(Icons.delete,color:Colors.red), label:Textout('SWIPE the contact to the RIGHT to delete it'
                                        , 0.020,Colors.blue) ),
                                    FlatButton.icon(onPressed: null, icon: Icon(Icons.call,color:Colors.yellow), label:Textout(
                                        'Tap the CONTACT NAME to make a call' , 0.020,Colors.blue) ),
                                    FlatButton.icon(onPressed: null, icon: Icon(Icons.edit,color:Colors.green), label:Textout(' Click on EDIT button to edit contact', 0.020,Colors.blue) ),

                                  ],
                                ),
                              ),height: MediaQuery.of(context).size.height*0.21,
                              width:  MediaQuery.of(context).size.width
                          ),
                            namelist.isEmpty?emptyList():List_Builder(),
                          ],
                        ),
                      );}
                  }
                  else if(snapshot.connectionState==ConnectionState.waiting){
                    return Center(
                      child: Container(child: Column(
                        children: <Widget>[
                          Textout('loading',  0.023, Colors.blue),
                          CircularProgressIndicator(),
                        ],
                      )),
                    );
                  }
                  return null;
                  }

              ),
          Sizedbox(0.03),

          Container(
              child: FlatButton.icon(
                color: Colors.black12,
                  onPressed: () {
                    if (namelist.length != 7) {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => EmergencyCont(
                                  widget.location,
                                  widget.username,
                                  widget.email,
                                  widget.phone,
                                  widget.occupation)));
                    }
                  },
                  icon: Icon(
                    namelist.length!=7?Icons.add:null,
                    color: namelist.length!=7? Colors.red : Colors.black,
                  ),
                  label: Textout(namelist.length!=7?'Add Contact':
                  'You have reach maximum no of contact, 7', 0.02, Colors.blue[900])))

            ],
          ),
        ),




        //Center

      )); // Scaffold


  }}












