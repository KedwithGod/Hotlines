import 'package:flutter/material.dart';

class Textfieldout extends StatelessWidget {
  final TextInputType typ;
  final TextEditingController cntrl;
  final String lab;
  final String hnt;
  final IconData icon;
  final String functionValue;


  const Textfieldout(this.typ, this.cntrl, this.lab, this.hnt, this.icon,
      this.functionValue);

  bool isValidPhoneNumber(String input) {
    final RegExp regex = new RegExp(r'^\(\d\d\d\)\d\d\d\-\d\d\d\d$');
    return regex.hasMatch(input);
  }

  bool isValidEmail(String input) {
    final RegExp regex = new RegExp(
        r"^[a-zA-Z0-9.!#$%&'*+/=?^_`{|}~-]+@[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,253}[a-zA-Z0-9])?(?:\.[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,253}[a-zA-Z0-9])?)*$");
    return regex.hasMatch(input);
  }

  @override
  Widget build(BuildContext context) {
    Orientation orientation = MediaQuery.of(context).orientation;
    return TextFormField(
      keyboardType: typ,
      controller: cntrl,
      autofocus: false,
      validator: (value) {
        if (functionValue == 'email') {
          return isValidEmail(value)
              ? null
              : 'Please enter a valid email address';
        }

         else if (functionValue == 'name') {
          return value.isEmpty ? 'Value  is required' : null;
        }
        return null;
      },
      style: TextStyle(
          color: Colors.blue,
          fontSize: orientation == Orientation.portrait
              ? MediaQuery.of(context).size.height * 0.025
              : MediaQuery.of(context).size.width * 0.025,
          fontWeight: FontWeight.bold),
      autocorrect: true,
      decoration: InputDecoration(
        prefixIcon: Icon(icon,color: Colors.blue,),
        labelText: '$lab',
        hintStyle: TextStyle(color: Colors.grey[300]),
        hintText: '$hnt',
        labelStyle: TextStyle(
            fontSize: orientation == Orientation.portrait
                ? MediaQuery.of(context).size.height * 0.020
                : MediaQuery.of(context).size.width * 0.020,
            color: Colors.blue,
            fontWeight: FontWeight.bold),
        contentPadding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
        border: OutlineInputBorder(
            borderRadius: orientation == Orientation.portrait
                ? BorderRadius.circular(
                    MediaQuery.of(context).size.height * 0.020)
                : BorderRadius.circular(
                    MediaQuery.of(context).size.width * 0.020,
                  )),
      ),
    );
  }
}
