import 'package:flutter/material.dart';
import 'package:hotlines_afrca/UI_functions/Drop_down_button.dart';
import 'package:hotlines_afrca/UI_functions/List_tile.dart';
import 'package:hotlines_afrca/UI_functions/RaisedButton.dart';
import 'package:hotlines_afrca/UI_functions/Rate_us.dart';
import 'package:hotlines_afrca/UI_functions/Text.dart';
import 'package:hotlines_afrca/UI_functions/hero_icon.dart';
import 'package:hotlines_afrca/UI_functions/shared_preference.dart';
import 'package:hotlines_afrca/pages/Emergency_contact_pages/contact.dart';
import 'package:hotlines_afrca/pages/Profile_page/Profile_Edit_page.dart';
import '../Emergency_services_page/Emergency_service.dart';
import 'feedback.dart';
import 'dart:io';

class DrawerOnly extends StatefulWidget {
  final String username;
  final String location;
  final String email;
  final String phone;
  final String occupation;
  final cntrl = TextEditingController();

  DrawerOnly(
      this.location, this.username, this.email, this.phone, this.occupation);

  @override
  _DrawerOnlyState createState() => _DrawerOnlyState();
}

class _DrawerOnlyState extends State<DrawerOnly> {
  List<String> name;
  List<String> number;
  bool autovalidate = false;

  Image imageFromPreferences;

  @override
  _displayDialog(BuildContext context, loc, email, username, phone, occupation,
      cntrl, autovalidate) async {
    return showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Textout('Change Location', 0.028, Colors.blue),
            content: SafeArea(
              left: true,
              bottom: true,
              top: true,
              right: true,
              child: Dropdown(),
            ),
            actions: <Widget>[
              RaisedButtonout(
                  'This button help synchronize the app \n to your current location',
                  () {
                Utility.Getlocation(loc).then((onValue) {
                  setState(() {
                    loc = onValue;
                  });
                });
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => EmergencyService(
                            loc, username, email, phone, occupation)));
              }, 0.0209, 'New Location')
            ],
          );
        });
  }

  loadImageFromPreferences() {
    Utility.getImageFromPrefences().then((img) {
      if (null == img) {
        return;
      }
      setState(() {
        imageFromPreferences = Utility.imageFromBase64String(img);
      });
    });
  }

  Widget build(BuildContext context) {
    loadImageFromPreferences();
    final orientation = MediaQuery.of(context).orientation;
    return new Drawer(
        child: Container(
      color: Colors.blue,
      child: new ListView(children: <Widget>[
        new UserAccountsDrawerHeader(
          currentAccountPicture: Container(
              height: orientation == Orientation.portrait
                  ? MediaQuery.of(context).size.height * 0.5
                  : MediaQuery.of(context).size.width * 0.5,
              decoration: BoxDecoration(
                  image: DecorationImage(
                      image: AssetImage('icons/profile3.jpg'),
                      fit: BoxFit.contain),
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(10),
                      topRight: Radius.circular(10)))),

          accountName:
              Textout('Username: ${widget.username}', 0.020, Colors.white),

          accountEmail: Textout('Email: ${widget.email}', 0.020, Colors.white),
          arrowColor: Colors.white,
          //onDetailsPressed: ,
        ),
        Listtileout('update location', () {
          _displayDialog(
              context,
              widget.location,
              widget.email,
              widget.username,
              widget.phone,
              widget.occupation,
              widget.cntrl,
              autovalidate);
        }, 'Change location', Herowid('locationdynamics', 0.044, Icons.location_on)),
        Listtileout('Available emergency sevices', () {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => EmergencyService(
                      widget.location,
                      widget.username,
                      widget.email,
                      widget.phone,
                      widget.occupation)));
        }, 'Emergency Services', Herowid('Emergencyservices', 0.044, Icons.announcement)),
        Listtileout('my 7 emergency contact', () {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => Contact(
                      widget.location,
                      widget.username,
                      widget.email,
                      widget.phone,
                      widget.occupation)));
        }, 'Emergency Contacts', Herowid('contacts of emergency', 0.044, Icons.contacts)),
        Listtileout('Edit your personal details', () {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => Profile_edit(
                      widget.username, widget.location, widget.email,widget.phone,widget.occupation)));
        }, 'Edit Profile', Herowid('edit profile', 0.044, Icons.edit)),
        Listtileout('type in how satisfied you are with the app', () {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => FeedBack(
                      widget.location,
                      widget.username,
                      widget.email,
                      widget.phone,
                      widget.occupation)));
        }, 'Feedback', Herowid('500', 0.044, Icons.rss_feed)),
        Listtileout('Do you want to exit app', () {
          Rating();
          exit(0);
        }, 'Exit', Herowid('Exit', 0.044, Icons.close)),
      ]),
    ));
  }
}
