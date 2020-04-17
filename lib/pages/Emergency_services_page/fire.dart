import 'package:flutter/material.dart';
import 'package:hotlines_afrca/UI_functions/Service_Dialog.dart';

class FireP extends StatelessWidget {
  final String location;
  final String username;
  final String email;
  final String phone;
  final String occupation;


  FireP(this.location, this.username,this.email, this.phone,
  this.occupation);

  Widget build(BuildContext context) {

    return  Servicedialog(location, username, email, 'FIRE AGENCIES',location,'Fire_agency','icons/fire.jpg',phone,occupation);
  }}
























