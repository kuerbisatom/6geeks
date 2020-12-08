import 'package:flutter/material.dart';
import 'package:co2_tracker/screens/home_screen.dart';
//import 'package:splashscreen/splashscreen.dart';
import 'package:co2_tracker/screens/survey.dart';
import 'package:shared_preferences/shared_preferences.dart';

Future<void> main() async{
  WidgetsFlutterBinding.ensureInitialized();
  SharedPreferences prefs = await SharedPreferences.getInstance();
  await prefs.setBool('showSurvey', true);
  var showSurvey = prefs.getBool("showSurvey") ?? true;

  runApp(MaterialApp(
    title: 'CO-2 Tracker',
    //debugShowCheckedModeBanner: false,
    theme: ThemeData(

      primarySwatch: Colors.green,

      visualDensity: VisualDensity.adaptivePlatformDensity,
    ),
    home: showSurvey ? Intro() : MyHomePage(),

  ));
}
