import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:hotlines_afrca/UI_functions/Drop_down_button.dart';
import 'package:hotlines_afrca/UI_functions/Hero.dart';
import 'package:hotlines_afrca/UI_functions/RaisedButton.dart';
import 'package:hotlines_afrca/UI_functions/Second_appbar.dart';
import 'package:hotlines_afrca/UI_functions/shared_preference.dart';
import 'package:hotlines_afrca/UI_functions/sizedbox.dart';
import 'package:hotlines_afrca/pages/Functionality_page/DrawerOnly.dart';
import 'package:hotlines_afrca/pages/Profile_page/profile.dart';


class Edit extends StatefulWidget {
  final String username;
  final String location;
  final String email;
  final String phone;
  final String occupation;

  Edit(this.username, this.location, this.email, this.phone, this.occupation);

  @override
  _EditState createState() => _EditState();
}

class _EditState extends State<Edit> {
  final _formKey = GlobalKey<FormState>();
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();



  String location;
  String username;
  String email;
  String occupation;
  String phone;
 TextEditingController usernameController;
  TextEditingController emailController ;
  TextEditingController occupationController;
  TextEditingController numberController;
  int count = 0;
  var reference = Firestore.instance.collection('User_data');


  @override
  void initState() {
    var emailController = TextEditingController(text: widget.email==null?'Email':widget.email);
    var usernameController = TextEditingController(text: widget.username==null?'Email':widget.username);
    var numberController = TextEditingController(text: widget.phone==null?'Email':widget.phone);
    var occupationController = TextEditingController(text: widget.occupation==null?'Email':widget.occupation);
    super.initState();
  }

  @override
  Future<bool> User(
    name,
    occupation,
    email,
      phone
  ) async {
    setState(() {});
    Utility.Setusername(name);
    Utility.Setoccupation(occupation);
    Utility.Setemail(email);
    Utility.setPhone(phone);

    setState(() {});

    return true;
  }

  Future<bool> read_location() async {
    Utility.Getlocation(location).then((onValue) {
      setState(() {
        location = onValue;
      });
    });
    Utility.Getusername(username).then((onValue) {
      setState(() {
        username = onValue;
      });
    });
    Utility.Getemail(email).then((onValue) {
      setState(() {
        email = onValue;
        print (email);
      });
    });
    Utility.Getoccupation(occupation).then((onValue) {
      setState(() {
        occupation = onValue;
        print (occupation);
      });
    });

    Utility.getPhone(phone).then((onValue) {
      setState(() {
        phone = onValue;
      });
    });
    print('read_location function has beena accessed');
    return true;
  }

  @override
  Widget build(BuildContext context) {
    final logo = Heroout('edi logo', 'icons/edit_profile.jpg', 0.088);

    final ema = TextFieldOut(TextInputType.emailAddress,(val){setState(() {email=val;

    });},
        'Enter your email', widget.email, Icons.email, 'email',widget.email==null?'Email':widget.email);
    final user = TextFieldOut(
        TextInputType.text,
       (val){setState(() {
         username=val;
       });},
        'Enter your username',
        widget.username,
        Icons.person,
        'name', widget.username==null?'username':widget.username);
    final occup = TextFieldOut(
        TextInputType.text,
        (val){setState(() {
          occupation=val;
        });},
        'Enter your occupation',
        'Student',
        Icons.work,
        'name',widget.occupation==null?'occupation':widget.occupation);
    final phoneNo = TextFieldOut(TextInputType.number,(val){setState(() {
      phone=val;
    });},
        'Phone Number', '09023867500', Icons.phone, 'phone', widget.phone==null?'phone':widget.phone);
    final loca = Dropdown();
    final loginButton = RaisedButtonout('Edit', () async {
      if(_formKey.currentState.validate()){
      await User(username==null?widget.username:username, occupation==null?widget.occupation:occupation,
          email==null?widget.email:email,phone==null?widget.phone:phone);
      reference.document(username).setData({
        'Username': username==null?widget.username:username,
        'Occupation':  occupation==null?widget.occupation:occupation,
        'Email Address': email==null?widget.email:email,
        'Phone Number': phone==null?widget.phone:phone,
        "timestamp": new DateTime.now().toString(),
      }, merge: true).then((_) => {});

      print(location);

      Navigator.push(
          context, MaterialPageRoute(builder: (context) => Profile()));
    }else {return null;}
      }, 0.030, 'EDIT');

    return Scaffold(
      drawer: new DrawerOnly(
          location == null ? widget.location : location,
          username == null ? widget.username : username,
          email == null ? widget.email : email,
          phone==null?widget.phone:phone,
          occupation==null?widget.occupation:occupation),
      key: _scaffoldKey,
      backgroundColor: Colors.white,
      appBar: PreferredSize(
          preferredSize: Size.fromRadius(40),
          child: Appbar2('Edit Profile',0.040)),
      body: Form(
        key: _formKey,
        child: ListView(
            shrinkWrap: true,
            padding: EdgeInsets.only(left: 24.0, right: 24.0),
            children: <Widget>[
              Sizedbox(0.0083),
              logo,
              Sizedbox(0.0333),
              user,
              Sizedbox(0.0333),
              ema,
              Sizedbox(0.0333),
              phoneNo,
              Sizedbox(0.0333),
              loca,
              Sizedbox(0.0333),
              occup,
              Sizedbox(0.0333),
              loginButton
            ]),
      ), //<Widget>[]

      //Center
    );
  }
}






class TextFieldOut extends StatelessWidget {
  final TextInputType typ;
  final String lab;
  final String hnt;
  final IconData icon;
  final String functionValue;
  final Function onChanged;
  final String initValue;


  const TextFieldOut(this.typ, this.onChanged, this.lab, this.hnt, this.icon,
      this.functionValue,this.initValue);

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
     initialValue: initValue,
     onChanged: onChanged,
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
        prefixIcon: Icon(icon),
        labelText: '$lab',
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