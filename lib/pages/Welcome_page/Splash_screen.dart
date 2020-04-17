import 'package:hotlines_afrca/UI_functions/Hero.dart';
import 'package:hotlines_afrca/UI_functions/Text.dart';
import 'package:hotlines_afrca/UI_functions/shared_preference.dart';
import '../Emergency_services_page/Emergency_service.dart';
import 'package:flutter/material.dart';
import 'package:splashscreen/splashscreen.dart';
class Splash extends StatefulWidget {
  @override
  _SplashState createState() => _SplashState();
}

class _SplashState extends State<Splash> {
  String location;
  String username;
  String  email;
  String phone;
  String occupation;

  @override
  void initState() {
    super.initState();
    Utility.Getlocation(location).then((onValue){
      setState(() {
        location=onValue;
      });
    });
    Utility.Getusername(username).then((onValue){
      setState(() {
        username=onValue;
      });
    });
    Utility.Getemail(email).then((onValue){
      setState(() {
        email=onValue;
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
    Orientation orientation= MediaQuery.of(context).orientation;
    return SplashScreen(
        seconds: 2,
        navigateAfterSeconds: new EmergencyService(location,username,email,phone,occupation),
        title: new Text('HOTLINES AFRICA',
          style: new TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 20.0
          ),),
        image: new Image.asset('icons/hotlines_logo.PNG'),
        backgroundColor: Colors.white,
        styleTextUnderTheLoader: new TextStyle(),
        photoSize: 100.0,
        onClick: ()=> EmergencyService(location,username,email,phone,occupation),
        loaderColor: Colors.blue
    );




    /*Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: InkWell(
          splashColor: Colors.red.withOpacity(0.3),
          onTap:() {Navigator.of(context).pop();

          Navigator.push(context,MaterialPageRoute(builder: (context)=>EmergencyService(location,username,email,phone,occupation)));} ,
          child: Column(mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[

              Heroout( 'splash logo', 'icons/hotlines_logo.PNG', 0.30),

              Padding(padding: EdgeInsets.all(orientation==Orientation.portrait?MediaQuery.of(context).size.height*0.003:
                                        MediaQuery.of(context).size.width*0.003),),

              Container(color: Colors.white,
                  child: Center(child:Column(
                    mainAxisAlignment: MainAxisAlignment.center,children: <Widget>[
                      Textout('Welcome Back',0.025,Colors.blue[900]),
                  ],))),
            ],
          ),
        ),
      ),
    );*/

  }
}
