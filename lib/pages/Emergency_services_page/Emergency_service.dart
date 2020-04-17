import 'package:flutter/material.dart';
import 'package:hotlines_afrca/UI_functions/Hero.dart';
import 'package:hotlines_afrca/UI_functions/List_tile.dart';
import 'package:hotlines_afrca/UI_functions/Text.dart';
import 'package:hotlines_afrca/UI_functions/app_bar.dart';
import 'package:hotlines_afrca/UI_functions/sizedbox.dart';
import 'package:hotlines_afrca/pages/Emergency_contact_pages/contact.dart';
import 'package:hotlines_afrca/pages/Emergency_services_page/fire.dart';
import 'package:hotlines_afrca/pages/Emergency_services_page/health.dart';
import 'package:hotlines_afrca/pages/Emergency_services_page/others.dart';
import 'package:hotlines_afrca/pages/Emergency_services_page/security.dart';
import 'package:hotlines_afrca/pages/Emergency_services_page/transport.dart';
import '../Functionality_page/DrawerOnly.dart';
import 'package:shared_preferences/shared_preferences.dart';

class EmergencyService extends StatefulWidget {
  final String location;
  final String username;
  final String email;
  final String phone;
  final String occupation;

  EmergencyService(
      this.location, this.username, this.email, this.phone, this.occupation);

  @override
  State createState() => Emergency();
}

class Emergency extends State<EmergencyService> {





  Widget build(BuildContext context) {
    final toptext = Textout('EMERGENCY AGENCIES', 0.030, Colors.white);

    final health = Listtileout(
        'Fracture, illness, pregnancy or \n any health issue ! Click ME', () {
      Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => HealthP(widget.location, widget.username,
                  widget.email, widget.phone, widget.occupation)));
    }, 'HEALTH AGENCY', Heroout('health agency', 'icons/health_agency.jpg', 0.032));

    final transport =
        Listtileout('Car breakdown, need transport agencies..! Click ME', () {
      Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => TransportP(widget.location, widget.username,
                  widget.email, widget.phone, widget.occupation)));
    }, 'TRANSPORT AGENCY', Heroout('transport agency', 'icons/transport.png', 0.032));

    final security = Listtileout(
        'Rape, theft, assault or \n any security issues! Click ME', () {
      Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => SecurityP(widget.location, widget.username,
                  widget.email, widget.phone, widget.occupation)));
    }, 'SECURITY AGENCY', Heroout('security agency', 'icons/security.png', 0.032));
    final fH =
        Listtileout('Any fire hazard at home,\n or work..! Click ME', () {
      Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => FireP(widget.location, widget.username,
                  widget.email, widget.phone, widget.occupation)));
    }, 'FIRE AGENCY', Heroout('fire agency', 'icons/fire.jpg', 0.032));
    final other = Listtileout('Any Other emergency issue..! Click ME', () {
      Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => OthersP(widget.location, widget.username,
                  widget.email, widget.phone, widget.occupation)));
    }, 'OTHER AGENCY', Heroout('others agency', 'icons/5.jpg', 0.032));
    final emergencycontact = Listtileout(
        'Which of your contacts comes in mind \n during emergency, save them here',
        () {

          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => Contact(
                      widget.location,
                      widget.username,
                      widget.email,
                      widget.phone,
                    widget.occupation

      )));
    }, 'EMERGENCY CONTACTS', Heroout('the emergency contac', 'icons/call_center.jpg', 0.032));

    return WillPopScope(
        onWillPop: () async => false,
        child: Scaffold(
          backgroundColor: Colors.blue,
          drawer: DrawerOnly(widget.location, widget.username, widget.email,
              widget.phone, widget.occupation),
          appBar: PreferredSize(
              preferredSize: Size.fromRadius(57),
              child: Appbarout(toptext, widget.location, widget.username)),
          body: ListView(
            padding: EdgeInsets.fromLTRB(0.0, 5.0, 0.0, 0.0),
            shrinkWrap: true,
            children: <Widget>[
              Sizedbox(0.0233),
              emergencycontact,
              Sizedbox(0.0233),
              fH,
              Sizedbox(0.0233),
              health,
              Sizedbox(0.0233),
              security,
              Sizedbox(0.0233),
              transport,
              Sizedbox(0.0233),
              other,
            ],
          ),

//Center
        )); // Scaffold
  }
}
