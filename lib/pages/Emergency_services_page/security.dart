import 'package:flutter/material.dart';
import 'package:hotlines_afrca/UI_functions/Service_Dialog.dart';

class SecurityP extends StatelessWidget {
  final String location;
  final String username;
  final String email;
  final String phone;
  final String occupation;


  SecurityP(this.location, this.username,this.email, this.phone,
      this.occupation);

  Widget build(BuildContext context) {

    return
      Servicedialog(location, username, email, 'SECURITY AGENCIES',location,'Security_agency','icons/security.png',phone,occupation);
    }}









