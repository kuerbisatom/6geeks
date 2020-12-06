import 'package:flutter/material.dart';
import 'package:co2_tracker/screens/home_screen.dart';
import 'package:splashscreen/splashscreen.dart';



void main() {
  runApp(MyApp());
}


// class MyApp extends StatefulWidget {
//   @override
//   _MyAppState createState() => new _MyAppState();
// }
//
// class _MyAppState extends State<MyApp> {
//   @override
//   Widget build(BuildContext context) {
//     return new SplashScreen(
//         seconds: 14,
//         navigateAfterSeconds: new AfterSplash(),
//         title: new Text('Welcome In SplashScreen',
//           style: new TextStyle(
//               fontWeight: FontWeight.bold,
//               fontSize: 20.0
//           ),),
//         image: new Image.network('https://i.imgur.com/TyCSG9A.png'),
//         backgroundColor: Colors.white,
//         styleTextUnderTheLoader: new TextStyle(),
//         photoSize: 100.0,
//         onClick: ()=>print("Flutter Egypt"),
//         loaderColor: Colors.red
//     );
//   }
// }
//
// class AfterSplash extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return new Scaffold(
//       appBar: new AppBar(
//           title: new Text("Welcome In SplashScreen Package"),
//           automaticallyImplyLeading: false
//       ),
//       body: new Center(
//         child: new Text("Done!",
//           style: new TextStyle(
//               fontWeight: FontWeight.bold,
//               fontSize: 30.0
//           ),),
//
//       ),
//     );
//   }
// }


class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'CO-2 Tracker',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.green,
        // This makes the visual density adapt to the platform that you run
        // the app on. For desktop platforms, the controls will be smaller and
        // closer together (more dense) than on mobile platforms.
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: MyHomePage(title: 'CO2 - Tracker'),
    );
  }
}

