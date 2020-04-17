import 'package:flutter/material.dart';
import 'package:hotlines_afrca/UI_functions/Service_Dialog.dart';

class HealthP extends StatelessWidget {
  final String username;
  final String email;
  final String location;
  final String phone;
  final String occupation;


  HealthP(this.location, this.username, this.email, this.phone,
      this.occupation);
  @override

  Widget build(BuildContext context) {

    return  Servicedialog(location, username, email, 'HEALTH AGENCIES',location,'Health_agency','icons/health_agency.jpg',phone,occupation);}}




