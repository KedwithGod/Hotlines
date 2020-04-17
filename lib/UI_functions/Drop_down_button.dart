import 'package:flutter/material.dart';
import 'package:hotlines_afrca/UI_functions/Text.dart';
import 'shared_preference.dart';
class Dropdown extends StatefulWidget {


  const Dropdown();

  @override
  _DropdownState createState() => _DropdownState();
}

class _DropdownState extends State<Dropdown> {
  List<String> dropdownlist=['',
    'Lagos','Akure'
  ];
  String dropdownValue='';
  _DropdownState();

  @override
  Widget build(BuildContext context) {
    Orientation orientation =MediaQuery.of(context).orientation;
    return  FormField(
      builder: (FormFieldState state) {
      return InputDecorator(
          decoration: InputDecoration(
            labelStyle: TextStyle(
                fontSize:orientation==Orientation.portrait? MediaQuery.of(context).size.height*0.027:MediaQuery.of(context).size.width*0.027,
                 color: Colors.blue, fontWeight: FontWeight.bold),
            contentPadding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
            border: OutlineInputBorder(
                borderRadius:orientation==Orientation.portrait? BorderRadius.circular(MediaQuery.of(context).size.height*0.017):
                BorderRadius.circular(MediaQuery.of(context).size.width*0.017,)),
            prefixIcon: const Icon(Icons.location_on),
    labelText: 'Location',hintText:'City',
            errorText: state.hasError ? state.errorText : null
    ),
        isEmpty: dropdownValue== '',
    child: new DropdownButtonHideUnderline(
      child: DropdownButton<String>(
          value: dropdownValue,
         isDense: true,
          onChanged: (String newValue) {
            setState(() {
              dropdownValue = newValue;
              Utility.Setlocation(newValue);
              state.didChange(newValue);
            });
          },
          items:dropdownlist
              .map<DropdownMenuItem<String>>((String value) {
            return DropdownMenuItem<String>(
              value: value,
              child: Textout(value, 0.029, Colors.blue),
            );
          })
              .toList(),
      ),
    ));
  },  validator: (val) {
      return val != '' ? null : 'Please select a Location';
    }  );
}}
