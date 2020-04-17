import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';

class Getvalues extends ChangeNotifier{
  CollectionReference locationvalue;

   CollectionReference location(){
     locationvalue=Firestore.instance.collection('Location');
     notifyListeners();
     return locationvalue;

   }
}