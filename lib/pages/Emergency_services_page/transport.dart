import 'package:flutter/material.dart';
import 'package:hotlines_afrca/UI_functions/Service_Dialog.dart';

class TransportP extends StatelessWidget {

  final String location;
  final String username;
  final String email;
  final String phone;
  final String occupation;

  TransportP(this.location, this.username,this.email, this.phone,
      this.occupation);

  Widget build(BuildContext context) {

    return
      Servicedialog(location, username, email, 'TRANSPORT AGENCIES',location,'Transport_agency','icons/transport.png',phone,occupation);
    }}
























