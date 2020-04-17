import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

class Rating extends StatefulWidget {
  @override
  _RatingState createState() => _RatingState();
}

class _RatingState extends State<Rating> {



  content() {
    return Column(mainAxisAlignment: MainAxisAlignment.center,children: <Widget>[
      Container(padding: EdgeInsets.all(10.0),child: RichText(text: TextSpan(text: 'RATE',style: TextStyle(
          fontSize:MediaQuery.of(context).size.width *0.058, fontFamily: 'josef', color: Colors.black, fontWeight: FontWeight.bold),
          children: [TextSpan(text: 'US',style: TextStyle(
              fontSize:MediaQuery.of(context).size.width *0.058, fontFamily: 'lobby', color: Colors.black87, fontWeight: FontWeight.bold))])),),
      AnimatedContainer(duration:Duration(milliseconds: 20),curve:Curves.fastOutSlowIn,
          padding: EdgeInsets.all(10.0),
          alignment: Alignment.center,
          child: RatingBar(
            initialRating:3,
            itemCount:5,
            itemBuilder:(context, index){
              switch(index){
                case 0:
                  return Icon(Icons.sentiment_very_dissatisfied,
                      color:Colors.blue);
                  case 1:
                 return Icon(Icons.sentiment_dissatisfied,
                        color:Colors.blue);
                  case 2:
                    return Icon(Icons.sentiment_neutral,
                        color:Colors.blue[400]);
                    case 3:
                      return Icon(Icons.sentiment_satisfied,
                        color:Colors.blue[700]);
                    case 4:
                      return Icon(Icons.sentiment_very_dissatisfied,
                        color:Colors.blue[600]);}}))]);
    }






  @override
  Widget build(BuildContext context) {
    return SafeArea(child: content());
  }
}

