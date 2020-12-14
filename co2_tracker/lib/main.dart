import 'package:co2_tracker/screens/data_saving.dart';
import 'package:flutter/material.dart';
import 'package:co2_tracker/screens/home_screen.dart';
//import 'package:splashscreen/splashscreen.dart';
import 'package:co2_tracker/screens/survey.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:co2_tracker/screens/globals.dart' as globals;

Future<void> main() async{
  WidgetsFlutterBinding.ensureInitialized();
  SharedPreferences prefs = await SharedPreferences.getInstance();
  //await prefs.setBool('showSurvey', true);
  var showSurvey = prefs.getBool("showSurvey") ?? true;
  globals.username = prefs.getString("username");
  if (globals.username == null){
    prefs.setString('username', "test");
    globals.username = "test";
  }
  globals.baseline= prefs.getInt("baseline");
  if(globals.baseline == null) {
    prefs.setInt("baseline", 60);
    globals.baseline = 60;
  }


  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    title: 'CO-2 Tracker',
    //debugShowCheckedModeBanner: false,
    theme: ThemeData(

      primarySwatch: Colors.green,

      visualDensity: VisualDensity.adaptivePlatformDensity,
    ),
    home: showSurvey ? Intro() : MyHomePage(),

  ));
}
