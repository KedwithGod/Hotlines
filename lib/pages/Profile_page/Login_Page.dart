import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:hotlines_afrca/UI_functions/Drop_down_button.dart';
import 'package:hotlines_afrca/UI_functions/Hero.dart';
import 'package:hotlines_afrca/UI_functions/RaisedButton.dart';
import 'package:hotlines_afrca/UI_functions/Second_appbar.dart';
import 'package:hotlines_afrca/UI_functions/Text.dart';
import 'package:hotlines_afrca/UI_functions/TextField.dart';
import 'package:hotlines_afrca/UI_functions/shared_preference.dart';
import 'package:hotlines_afrca/UI_functions/sizedbox.dart';
import 'package:hotlines_afrca/pages/Emergency_services_page/Emergency_service.dart';
import 'package:flutter/services.dart';
import 'package:need_resume/need_resume.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';

class LoginPage extends StatefulWidget {
  @override
  State createState() => Login();
}

class Login extends ResumableState<LoginPage> {
  final _formKey = GlobalKey<FormState>();
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  String location;
  String username;
  String email;
  String occupation;
  String phone;
  var usernameController = TextEditingController();
  var emailController = TextEditingController();
  var occupationController = TextEditingController();
  var numberController = TextEditingController();
  int count = 0;
  Future<File> _imageFile;
  Image imageFromPreferences;
  var reference = Firestore.instance.collection('User_data');

  @override
  Future<bool> User(name, occupation, email, phone) async {
    setState(() {});
    Utility.Setusername(name);
    Utility.Setoccupation(occupation);
    Utility.Setemail(email);
    Utility.setPhone(phone);

    setState(() {});
    print(' user function has been assessed ');
    print(name + email + occupation);

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
      });
    });
    Utility.Getoccupation(occupation).then((onValue) {
      setState(() {
        occupation = onValue;
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
  void dispose() {
    // clean up the controller when the widget is disposed
    usernameController.dispose();
    emailController.dispose();
    occupationController.dispose();
    numberController.dispose();
    super.dispose();
  }

  void showMessage(String message, [MaterialColor color = Colors.red]) {
    _scaffoldKey.currentState.showSnackBar(
        new SnackBar(backgroundColor: color, content: new Text(message)));
  }

  Future pickImageFromGallery(ImageSource source) async {
    setState(() {
      _imageFile = ImagePicker.pickImage(source: source);
    });
  }

  Widget imageFromGallery() {
    return FutureBuilder<File>(
      future: _imageFile,
      builder: (BuildContext context, AsyncSnapshot<File> snapshot) {
        if (snapshot.connectionState == ConnectionState.done &&
            null != snapshot.data) {
          Utility.saveImageToPreferences(
              Utility.base64String(snapshot.data.readAsBytesSync()));
          return CircleAvatar(
            radius: 60,
            backgroundColor: Colors.transparent,
            child: Image.file(
              snapshot.data,
            ),
          );
        } else if (null != snapshot.error) {
          return const Text(
            'Error Picking Image',
            textAlign: TextAlign.center,
          );
        } else {
          return const Text(
            'No Image Selected',
            textAlign: TextAlign.center,
          );
        }
      },
    );
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
    var logo = Textout('Type your detail below:', 0.03, Colors.blue);

    final ema = Textfieldout(TextInputType.emailAddress, emailController,
        'Enter your email', 'abc@email.com', Icons.email, 'email', );
    final user = Textfieldout(TextInputType.text, usernameController,
        'Enter your username', 'KunleIgweUmaru', Icons.person, 'name', );
    final occup = Textfieldout(TextInputType.text, occupationController,
        'Enter your occupation', 'Student', Icons.work, 'name', );
    final phoneNo = Textfieldout(TextInputType.number, numberController,
        'Phone Number', '09023867500', Icons.phone, 'name', );
    final loca = Dropdown();
    final loginButton = RaisedButtonout('SIGN IN', () async {
      if(_formKey.currentState.validate()) {
        await User(usernameController.text, occupationController.text,
            emailController.text, numberController.text);
        await read_location();

        reference.document(usernameController.text).setData({
          'Username': usernameController.text,
          'Occupation': occupationController.text,
          'Email Address': emailController.text,
          'Phone Number': numberController.text,
          "timestamp": new DateTime.now().toString(),
        }, merge: true).then((_) => {});

        print(location);

        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) =>
                    EmergencyService(
                        location, username, email, phone, occupation)));
      }
      else {return null;}
      }, 0.030, 'SIGN IN');

    return Scaffold(
      key: _scaffoldKey,
      backgroundColor: Colors.white,
      appBar: PreferredSize(
          preferredSize: Size.fromRadius(40),
          child: Appbar2('Sign Up Page',0.040)),
      body: Form(
        key: _formKey,
        child: ListView(
            shrinkWrap: true,
            padding: EdgeInsets.only(left: 24.0, right: 24.0),
            children: <Widget>[
              Sizedbox(0.0083),
              logo,
              Sizedbox(0.0533),
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
