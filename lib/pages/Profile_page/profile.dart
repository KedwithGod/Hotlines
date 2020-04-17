import 'package:flutter/material.dart';
import 'package:hotlines_afrca/UI_functions/List_tile.dart';
import 'package:hotlines_afrca/UI_functions/Second_appbar.dart';
import 'package:hotlines_afrca/UI_functions/Text.dart';
import 'package:hotlines_afrca/UI_functions/hero_icon.dart';
import 'package:hotlines_afrca/UI_functions/shared_preference.dart';
import 'package:hotlines_afrca/UI_functions/sizedbox.dart';
import 'package:hotlines_afrca/pages/Functionality_page/DrawerOnly.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Profile extends StatefulWidget {

  @override
  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
 
  String location;
  String username;
  String email;
  String occupation;
  String phone;
  Image imageFromPreferences;

  @override
  void initState() {
    read_location();
    loadImageFromPreferences();
    super.initState();
  }
  @override



  Future<bool> read_location()async {
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

  loadImageFromPreferences() {
    Utility.getImageFromPrefences().then((img) {
      if (null == img) {
        return;
      }
      setState(() {
        imageFromPreferences = Utility.imageFromBase64String(img);
      });
    });
  }
   @override
  Widget build(BuildContext context) {
    final orientation=MediaQuery.of(context).orientation;
    final profile= Container(
        height: orientation==Orientation.portrait?MediaQuery.of(context).size.height*0.3:
        MediaQuery.of(context).size.width*0.3,
        decoration: BoxDecoration(image: DecorationImage(image:AssetImage('icons/profile3.jpg'),
            fit: BoxFit.contain),
            borderRadius: BorderRadius.only(topLeft: Radius.circular(10),
                topRight: Radius.circular(50))));


    final user=JobContainer(Icons.person, username==null?'No Username':username, 'userinprofile', 1, Colors.blue);
    final locality=JobContainer(Icons.location_on, location==null?'No Location':location,'Locationinprofile', 1, Colors.blue);
    final mail=JobContainer(Icons.mail, email==null?'No Email':email, 'Emailinprofile', 2, Colors.blue);
    final work=JobContainer(Icons.work, occupation==null?'No Occupation':occupation, 'Ocupationinprofile', 1, Colors.blue);
    final phoneNo=JobContainer(Icons.mobile_screen_share, phone==null?'No Phone no':phone, 'phoneinprofile', 1, Colors.blue);
    final editbutton=Textout( 'EDIT PROFILE', 0.030,Colors.blue);
    return Scaffold(
        backgroundColor: Colors.white,
        drawer: DrawerOnly(location,username,email,phone,occupation),
        appBar: PreferredSize(
            preferredSize:Size.fromRadius(40),
            child:Appbar2('PROFILE PAGE',0.040)),
        body:
        ListView(
            shrinkWrap: true,
            padding: EdgeInsets.only(left: 24.0,right: 24.0),
            children: <Widget>[
              Sizedbox(0.05333),
              profile
              /*imageFromPreferences==null?profile: Container(
                height: orientation==Orientation.portrait?MediaQuery.of(context).size.height*0.02:
                MediaQuery.of(context).size.width*0.02,
                decoration: BoxDecoration(image: DecorationImage(image:AssetImage(imageFromPreferences.toString()),
                    fit: BoxFit.contain),
                    borderRadius: BorderRadius.only(topLeft: Radius.circular(10),
                        topRight: Radius.circular(10))),
              )*/ ,
              Sizedbox(0.0233),
              user,
              Sizedbox(0.0233),
              locality,
              Sizedbox(0.0233),
              mail,
              Sizedbox(0.0233),
              work,
              Sizedbox(0.00333),
              phoneNo,
              Sizedbox(0.02333),
              Center(child: editbutton),

            ]
        ) //<Widget>[]

        //Center

    );
  }
}



class JobContainer extends StatelessWidget {
  final IconData icon;
  final String tag;
  final String text;
  final int textSpan;
  final Color color;


  JobContainer(this.icon, this.text,this.tag,this.textSpan,this.color, );
  @override
  Widget build(BuildContext context) {
    Orientation orientation = MediaQuery.of(context).orientation;
    return ListTile(
      leading:
      Herowid(
          tag,
          0.04,

            icon,
          ),
      title:
      Textout(text, 0.025, color,
          ),




    )
    ;

  }
}