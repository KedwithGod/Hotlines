import 'package:flutter/material.dart';
import 'package:hotlines_afrca/UI_functions/RaisedButton.dart';
import 'package:hotlines_afrca/UI_functions/Text.dart';
import 'package:hotlines_afrca/UI_functions/TextField.dart';
import 'package:hotlines_afrca/UI_functions/app_bar.dart';
import 'package:hotlines_afrca/UI_functions/bottomNavig.dart';
import 'package:hotlines_afrca/UI_functions/sizedbox.dart';
import 'package:hotlines_afrca/pages/Functionality_page/DrawerOnly.dart';
import './contact.dart';
import 'package:hotlines_afrca/UI_functions/shared_preference.dart';
import 'package:cloud_firestore/cloud_firestore.dart';


class EmergencyCont extends StatefulWidget {
  final String username;
  final String location;
  final String email;
  final String phone;
  final String occupation;


  EmergencyCont(this.location, this.username, this.email, this.phone,
      this.occupation);

  @override
  State createState() => Emergency();
}

class Emergency extends State<EmergencyCont> {
  List<String> name = [];
  List<String> number = [];
  List<String> newname = [];
  TextEditingController eCtrl = new TextEditingController();
  TextEditingController pCtrl = new TextEditingController();
  final _formKey = GlobalKey<FormState>();
  ContactState obj = ContactState();
  var reference = Firestore.instance.collection('Emergency_Contact');

  @override
  void initState() {
    getInitList();

    super.initState();
  }

  getInitList() async {
    await Utility.getnamelist(name).then((onValue) {
      setState(() {
        name = onValue;
      });
    });
    await Utility.getnumberlist(number).then((onValue) {
      setState(() {
        onValue=number;
      });
    });
  }

  List<String> toList() {
    name.forEach((item) {
      newname.add(item.toString());
    });

    return newname.toList();
  }

  @override
  Widget build(BuildContext context) {

    Orientation orientation = MediaQuery
        .of(context)
        .orientation;

    return Scaffold(
        backgroundColor: Colors.white,
        drawer: DrawerOnly(
            widget.location, widget.username, widget.email, widget.phone,
            widget.occupation),

        appBar: PreferredSize(
            preferredSize: Size.fromRadius(55),
            child: Appbarout(
                Textout('Emergency \n contact', 0.030, Colors.white),
                widget.location, widget.username)),
        body: SingleChildScrollView(
          child: Container(
            padding:EdgeInsets.symmetric(horizontal: 8.0),
              width: MediaQuery
                  .of(context)
                  .size
                  .width,
              height: MediaQuery
                  .of(context)
                  .size
                  .height * 0.78,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(70.0))),

              child:
              Form(
                key: _formKey,

                child: new Column(
                  children: <Widget>[
                    Sizedbox(0.003),
                    SizedBox(
                      child: Card(
                        color: Colors.white,
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15.0)),
                        elevation: 0.0,

                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            FlatButton.icon(onPressed: null, icon: Icon(Icons.add_call,color:Colors.green), label:Textout('Add 7 Emergency contact'
                               , 0.020,Colors.blue) ),
                            FlatButton.icon(onPressed: null, icon: Icon(Icons.update,color:Colors.pink), label:Textout(
                                'Click Update to store Contact' , 0.020,Colors.blue) ),
                            FlatButton.icon(onPressed: null, icon: Icon(Icons.move_to_inbox,color:Colors.yellow), label:Textout(' Click Contacts to go to Contact Page', 0.020,Colors.blue) ),

                          ],
                        ),
                ),height: MediaQuery.of(context).size.height*0.25,
                      width:  MediaQuery.of(context).size.width
                    ),

                    Textout('Contact NO ${name.length == null
                        ? 1
                        : name.length + 1}', 0.025, Colors.blue),
                    SizedBox(height: 10.0),
                     new Textfieldout(
                        TextInputType.text,
                        eCtrl,
                        'Contact Name',
                        'Enter contact name',
                        Icons.person,
                        'name',
                        ),
                    SizedBox(height: 5.0),
                    Textout('Phone No ${name.length == null
                        ? 1
                        : name.length + 1} ', 0.025, Colors.blue),
                    SizedBox(height: 10.0),
                     new Textfieldout(
                        TextInputType.number,
                        pCtrl,
                        'Phone number',
                        'Enter phone no',
                        Icons.phone,
                        'phone',
                        ),
                    Sizedbox(0.020),
                    new Row(mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Tooltip(
                            message: 'Please update contact',
                            verticalOffset: orientation == Orientation.portrait
                                ? MediaQuery
                                .of(context)
                                .size
                                .height * 0.07
                                : MediaQuery
                                .of(context)
                                .size
                                .width * 0.07,
                            height: 30,
                            child: SafeArea(
                                child: RaisedButton(padding: EdgeInsets.all(8),
                                    splashColor: Color.fromRGBO(
                                        197, 194, 20, 0),
                                    color: Colors.blue,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(
                                        orientation == Orientation.portrait
                                            ? MediaQuery
                                            .of(context)
                                            .size
                                            .height * 0.030
                                            : MediaQuery
                                            .of(context)
                                            .size
                                            .width * 0.030,),
                                    ),
                                    child: Text(
                                      'Update',
                                      style: TextStyle(color: Colors.white,
                                          fontSize: MediaQuery
                                              .of(context)
                                              .size
                                              .height * 0.022,
                                          fontWeight: FontWeight.bold),
                                    ),
                                    onPressed: () async{
                                      if (_formKey.currentState.validate()) {
                                        if (name.length != 7) {
                                          name.add(eCtrl.text);
                                          eCtrl.clear();
                                          number.add(pCtrl.text);
                                          pCtrl.clear();
                                          toList();
                                          setState(() {

                                          });
                                          await Utility.savenamelist(name);
                                          await Utility.savenumberlist(number);
                                          print(name);

                                          reference.document(widget.username)
                                              .setData(
                                              {
                                                'name': name,
                                                'number': number,
                                              },
                                              merge: true)
                                              .then((_) =>
                                          {
                                          });
                                        }
                                      }
                                      else {
                                        Navigator.push(context,
                                            MaterialPageRoute(builder: (context) =>
                                                Contact(widget.location, widget.username,
                                                    widget.email, widget.phone, widget.
                                                    occupation)));
                                      }
                                    })),
                          ),
                          RaisedButtonout('Add new contact here', () {
                            if (name.length != 2 && name.isEmpty == true) {
                              return null;
                            }
                            {
                              Navigator.push(context,
                                  MaterialPageRoute(builder: (context) =>
                                      Contact(widget.location, widget.username,
                                          widget.email, widget.phone, widget.
                                          occupation)));
                            }
                          }, 0.022, 'Contacts'),


                        ])
                  ],),
              )),
        ),

    );
  }
}

