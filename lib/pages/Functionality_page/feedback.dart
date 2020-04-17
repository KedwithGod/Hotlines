import 'package:flutter/material.dart';
import 'package:flutter_sms/flutter_sms.dart';
import 'package:hotlines_afrca/UI_functions/RaisedButton.dart';
import 'package:hotlines_afrca/UI_functions/Text.dart';
import 'package:hotlines_afrca/UI_functions/app_bar.dart';
import 'package:hotlines_afrca/UI_functions/bottomNavig.dart';
import 'DrawerOnly.dart';


class FeedBack extends StatefulWidget {
  final String location;
  final String username;
  final String email;
  final String phone;
  final String occupation;

  FeedBack(this.location, this.username,this.email,this.phone,this.occupation);
  @override
  State createState() => Feeds();
}

class Feeds extends State<FeedBack>{
  final generalfeedbackController = TextEditingController(text: 'Type in your feedbakc');

  @override


  void dispose(){
    super.dispose();
    generalfeedbackController.dispose();


  }

  _sendSms(String message, List<String> recipients)async {
    String _result=await FlutterSms.sendSMS(message:message,recipients:recipients).catchError((onError){print(onError);});
    return _result;

  }










  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        drawer: new DrawerOnly(widget.location,widget.username,widget.email,widget.phone, widget.occupation),
        appBar: PreferredSize(
            preferredSize: Size.fromRadius(57),
            child:Appbarout( Textout( 'FEEDBACK PAGE',0.035,Colors.white), widget.location, widget.username)),//AppBar
        body:
        ListView(
          shrinkWrap: true,
          padding: EdgeInsets.only(left: 24.0, right: 24.0),
          children: <Widget>[

          SizedBox(height: 20.0,),
      TextFormField(
        keyboardType: TextInputType.multiline,
        maxLines: 10,
        controller: generalfeedbackController,
        autovalidate: true,
        style: TextStyle(color: Colors.blue[900]),
        autocorrect: true,
        autofocus: true,
        decoration: InputDecoration(
            labelText: 'Type feedback:', hintText: 'feedback',
            contentPadding: EdgeInsets.only(bottom: 100.0,left: 20.0,top:0.0),
            border: OutlineInputBorder(borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(50.0),
                topRight: Radius.circular(50.0)
            ))),
      ),
      SizedBox(height: 20.0,),

            RaisedButtonout('provide feedback',(){_sendSms(generalfeedbackController.text,['09064703871']);}, 0.022,'Send Feedback'),

      SizedBox(height: 20.0,),



    ]), //<Widget>[]

        //Center

    ); // Scaffold


  }
}