import 'package:flutter/material.dart';
import 'package:hotlines_afrca/UI_functions/Service_Dialog.dart';

class OthersP extends StatelessWidget {
  final String location;
  final String username;
  final String email;
  final String phone;
  final String occupation;



  OthersP(this.location, this.username,this.email, this.phone,
      this.occupation);

  Widget build(BuildContext context) {

    return  Servicedialog(location, username, email, 'OTHER AGENCIES',location,'Others_agency','icons/5.jpg',phone,occupation);
  }}





