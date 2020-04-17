import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:async';
import 'dart:convert';


class Utility{
  // This is for the login details
  String location;
  static const String IMG_KEY='IMAGE_KEY';


  static Future<bool> saveImageToPreferences (String value) async {
    final SharedPreferences preferences= await SharedPreferences.getInstance();
    return preferences.setString(IMG_KEY, value);
  }

  static Future<String> getImageFromPrefences() async {
    final SharedPreferences preferences= await SharedPreferences.getInstance();
    return preferences.get(IMG_KEY);
  }

  static String base64String(Uint8List data){
   return base64Encode(data);
  }

  static Image imageFromBase64String(String base64String){
    return Image.memory(base64Decode(base64String),
    fit: BoxFit.fill);

  }

  static Future<String> Setlocation (location) async {
    final prefs2=await SharedPreferences.getInstance();
    await prefs2.setString('Location', location);
    return location;
  }
  static Future<String> Setusername (username) async {
    final prefs=await SharedPreferences.getInstance();
    await prefs.setString('username', username);
    return username;
  }
  static Future<String> Setemail (email) async {
    final prefs=await SharedPreferences.getInstance();
    await prefs.setString('Email', email);
    return email;
  }
  static Future<String> Setoccupation (var occupation) async {
    final prefs=await SharedPreferences.getInstance();
    await prefs.setString('Occupation', occupation);
    return occupation;
  }

  static Future<String> setPhone (var phone) async {
    final prefs=await SharedPreferences.getInstance();
    await prefs.setString('phone', phone);
    return phone;
  }

  // This is for getting values for the login details
  static Future<String> getPhone (phone) async {
    final prefs2=await SharedPreferences.getInstance();
    phone= prefs2.getString('phone')?? '';
    return phone;
  }


  static Future<String> Getlocation (location) async {
    final prefs2=await SharedPreferences.getInstance();
    location=await prefs2.getString('Location')?? '';
    return location;
  }

  static Future<String> Getusername (username) async {
    final prefs=await SharedPreferences.getInstance();
    username= await prefs.getString('username') ?? '';
    return username;
  }

  static Future<String> Getemail (email) async {
    final prefs=await SharedPreferences.getInstance();
    email=await prefs.getString('Email')?? '';
    return email;
  }

  static Future<String> Getoccupation (occupation) async {
    final prefs=await SharedPreferences.getInstance();
    occupation=await prefs.getString('Occupation')?? '';
    return occupation;
  }

// this is for 7 emergency contact list
  static Future<List> savenamelist(List<String> name) async {
    final list = await SharedPreferences.getInstance();
    list.setStringList('name', name);
    return name;
    }

  static Future<List> savenumberlist(List<String> number) async {
    final list = await SharedPreferences.getInstance();
    list.setStringList('number', number);
    return number;
  }

  static Future<List> getnamelist(List<String> name) async {
    final list = await SharedPreferences.getInstance();
    name=list.getStringList('name',) ?? [];
    return name;
  }


  static Future<List> getnumberlist(List<String> number) async {
    final list = await SharedPreferences.getInstance();
    number=list.getStringList('number') ?? [];
    return number;
  }

  static final String kOnBoardingStatus = 'onBoardingStatus';
  static final String kUser = 'user';

  static bool getOnBoardingStatus(SharedPreferences prefs) {
    return prefs.containsKey(kOnBoardingStatus)
        ? prefs.getBool(kOnBoardingStatus ?? false)
        : false;
  }

  static Future<bool> setOnBoardingStatus(bool value, SharedPreferences prefs) {
    return prefs.setBool(kOnBoardingStatus, value);
  }





}

