import 'package:flutter/material.dart';
import 'package:flip_card/flip_card.dart';
import 'Edit.dart';
import 'profile.dart';

class Profile_edit extends StatelessWidget {
  final String username;
  final String location;
  final String email;
  final String phone;
  final String occupation;

  Profile_edit(this.username,this.location,this.email,this.phone,
      this.occupation);
  @override
  Widget build(BuildContext context) {
    return FlipCard(speed:380,
    direction:FlipDirection.HORIZONTAL,
    front:Profile(),
    back: Edit(username,location,email,phone,occupation));
  }
}
