import 'package:flutter/material.dart';
import 'package:hotlines_afrca/onboarding/onboarding.dart';
import 'package:hotlines_afrca/onboarding/onboarding_circle.dart';
import 'package:hotlines_afrca/pages/Emergency_services_page/Emergency_service.dart';
import 'package:hotlines_afrca/pages/Profile_page/Login_Page.dart';
import 'pages/Welcome_page/Splash_screen.dart';
import 'package:hotlines_afrca/UI_functions/shared_preference.dart';

void main() => runApp(MyApp());

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  String location;
  String username;
  String  email;
  String phone;
  String occupation;

  @override
  void initState() {
    super.initState();

    Utility.Getlocation(location).then((onValue) {
      setState(() {
        location = onValue;
      });
    });

    Utility.Getusername(username).then((value){
      setState(() {
        username=value;
      });
    });
    Utility.Getemail(email).then((value){
      setState(() {
        email=value;
      });
    });
    Utility.Getoccupation(occupation).then((onValue){
      setState(() {
        occupation=onValue;
      });
    });


    Utility.getPhone(phone).then((onValue){
      setState(() {
        phone=onValue;
      });
    });

  }



  @override
  Widget build(BuildContext context) {
    return  MaterialApp(
          title: 'HOTLINES AFRICA',
          debugShowCheckedModeBanner: false,
          theme: ThemeData(
            primarySwatch: Colors.blue,
          ),
          home: MaterialApp(
            home: location==''?OnBoardingCircle():Splash()));


  }
}



