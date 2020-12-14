import 'package:co2_tracker/screens/home_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:searchable_dropdown/searchable_dropdown.dart';
import 'package:co2_tracker/screens/data_saving.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:flutter/services.dart';
import 'package:co2_tracker/screens/globals.dart' as globals;
import 'package:flutter/gestures.dart' show DragStartBehavior;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:splashscreen/splashscreen.dart';
import 'package:co2_tracker/screens/transportation_edit.dart';

class TransportationMain extends StatefulWidget {
  final int index;
  TransportationMain({Key key, @required this.index}) : super(key: key);
  State<TransportationMain> createState() => _TransportationMainState();
}
class listItem{
  String name;
  int _value;
  listItem(this.name,this._value);

  @override
  String toString() {
    return this.name;
  }

  int value(){
    return _value;
  }
}

class _TransportationMainState extends State<TransportationMain> {
  @override
  List<int> selectedItems = [];

  void initState() {
    super.initState();
  }

  final List<listItem> items = [
    listItem("apple", 1),
    listItem("beef", 2),
    listItem("margarita", 3),
    listItem("brie cheese", 4)
  ];

  Widget build(BuildContext context) {
    return new WillPopScope(
        onWillPop: _requestPop,
        child: Scaffold(
          resizeToAvoidBottomInset: false,
          appBar: AppBar(
            leading: IconButton(
              icon: Icon(Icons.arrow_back),

              onPressed: () =>
              {
                globals.currentOverlay = true,
                Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(builder: (context) => MyHomePage()),
                      (Route<dynamic> route) => false,
                ),
              },
            ),
            centerTitle: true,
            title: Text("Transportation"),
            automaticallyImplyLeading: false,
          ),
          body: SingleChildScrollView(
              child: Column(
                children: [
                  Container (
                      margin: EdgeInsets.all(10),
                      child: Text("Detected Trips",
                      style: TextStyle(
                          fontSize: 26, fontWeight: FontWeight.bold)
                  )),
                  Divider(),
                  Container(
                      margin: EdgeInsets.all(10),
                      decoration: BoxDecoration(
                          border: Border.all(color: Colors.green,width: 3),
                        borderRadius: BorderRadius.all(Radius.circular(20)),
                      ),
                      child: SizedBox(
                          width: MediaQuery.of(context).size.width -10,
                          height: 150,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Text("Metro",
                                style: TextStyle(
                                    fontSize: 24, fontWeight: FontWeight.bold)),
                            Text("5km (20min)",
                                style: TextStyle(
                                    fontSize: 24, fontWeight: FontWeight.normal)),
                            Text("10 AM",
                                style: TextStyle(
                                    fontSize: 24, fontWeight: FontWeight.normal)),
                            Text("near Saldanha",
                                style: TextStyle(
                                    fontSize: 24, fontWeight: FontWeight.normal)),
                          ]
                      ))
                  ),
                  Container(
                  ),
                  new Container(
                    margin: EdgeInsets.all( 10.0),
                    child: FlatButton(
                      height: 40,
                      child: Text('Edit Trip',
                          textScaleFactor: 1.4,
                          style: TextStyle(color: Colors.white)),
                      padding: EdgeInsets.only(
                          top: 13.0, bottom: 13, right: 40, left: 40),
                      color: Color(0xFF66BB64),
                      onPressed: () {
                        globals.currentOverlay = true;
                        Navigator.pushAndRemoveUntil(
                          context,
                          MaterialPageRoute(builder: (context) => TransportationEdit()),
                              (Route <dynamic> route) => false,
                        );
                      },
                      shape: RoundedRectangleBorder(
                          borderRadius: const BorderRadius.all(
                              Radius.circular(25.0))),),
                  ),
                  Divider(),
                  Container(
                      margin: EdgeInsets.all(10),
                      decoration: BoxDecoration(
                          border: Border.all(color: Colors.green, width: 3),
                        borderRadius: BorderRadius.all(Radius.circular(20)),
                      ),

                      child: SizedBox(
                          width: MediaQuery.of(context).size.width -10,
                          height: 150,
                          child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                Text("Car",
                                    style: TextStyle(
                                        fontSize: 24, fontWeight: FontWeight.bold)),
                                Text("10 km (30 min)",
                                    style: TextStyle(
                                        fontSize: 24, fontWeight: FontWeight.normal)),
                                Text("12 AM",
                                    style: TextStyle(
                                        fontSize: 24, fontWeight: FontWeight.normal)),
                                Text("near Alfragide",
                                    style: TextStyle(
                                        fontSize: 24, fontWeight: FontWeight.normal)),
                              ]
                          ))
                  ),
                  new Container(
                    margin: EdgeInsets.only(top: 20.0),
                    child: FlatButton(
                      height: 40,
                      child: Text('Edit Trip',
                          textScaleFactor: 1.4,
                          style: TextStyle(color: Colors.white)),
                      padding: EdgeInsets.only(
                          top: 13.0, bottom: 13, right: 40, left: 40),
                      color: Color(0xFF66BB64),
                      onPressed: () {
                        globals.currentOverlay = true;
                        Navigator.pushAndRemoveUntil(
                          context,
                          MaterialPageRoute(builder: (context) => TransportationEdit()),
                              (Route <dynamic> route) => false,
                        );
                      },
                      shape: RoundedRectangleBorder(
                          borderRadius: const BorderRadius.all(
                              Radius.circular(25.0))),),
                  ),
                  new Container(
                    margin: EdgeInsets.only(top: 140.0, bottom:20),
                    child: FlatButton(
                      height: 40,
                      child: Text('Insert Manually',
                          textScaleFactor: 1.4,
                          style: TextStyle(color: Colors.white)),
                      padding: EdgeInsets.only(
                          top: 13.0, bottom: 13, right: 40, left: 40),
                      color: Color(0xFF66BB64),
                      onPressed: () {
                        globals.currentOverlay = true;
                        Navigator.pushAndRemoveUntil(
                          context,
                          MaterialPageRoute(builder: (context) => TransportationEdit()),
                              (Route <dynamic> route) => false,
                        );
                      },
                      shape: RoundedRectangleBorder(
                          borderRadius: const BorderRadius.all(
                              Radius.circular(25.0))),),
                  ),

                ],
              )),
        )
    );
  }

  Future <bool> _requestPop() {
    print("Something");
    globals.currentOverlay = true;
    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(builder: (context) => MyHomePage()),
          (Route<dynamic> route) => false,);
    return new Future.value(true);
  }
}
