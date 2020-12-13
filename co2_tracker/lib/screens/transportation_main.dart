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
          body: Center(
              child: Column(
                children: [
                  Row(
                    children: [Container(
                      child: Text("Detected Trips:",
                          style: TextStyle(
                              fontSize: 26, fontWeight: FontWeight.bold)),
                      margin: EdgeInsets.only(left: 20, top: 20),)
                    ],
                  ),
                  Row(
                     children: [
                      Container(
                        child: new Text("Metro",
                            style: TextStyle(
                                fontSize: 24, fontWeight: FontWeight.bold)),
                                margin: EdgeInsets.only(left: 20, top: 20),
                        ),
                    ],
                  ),
                  Row(
                     children: [
                      Container(
                        child: new Text("5km (20min)",
                            style: TextStyle(
                                fontSize: 24, fontWeight: FontWeight.normal)),
                                margin: EdgeInsets.only(left: 20, top: 0),
                        ),
                    ],
                  ),
                  Row(
                     children: [
                      Container(
                        child: new Text("10 AM",
                            style: TextStyle(
                                fontSize: 24, fontWeight: FontWeight.normal)),
                                margin: EdgeInsets.only(left: 20, top: 0),
                        ),
                    ],
                  ),
                  Row(
                     children: [
                      Container(
                        child: new Text("near Saldanha",
                            style: TextStyle(
                                fontSize: 24, fontWeight: FontWeight.normal)),
                                margin: EdgeInsets.only(left: 20, top: 0),
                        ),
                    ],
                  ),
                  Container(
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
                
                  Row(
                     children: [
                      Container(
                        child: new Text("Car",
                            style: TextStyle(
                                fontSize: 24, fontWeight: FontWeight.bold)),
                                margin: EdgeInsets.only(left: 20, top: 20),
                        ),
                    ],
                  ),
                  Row(
                     children: [
                      Container(
                        child: new Text("10km (30min)",
                            style: TextStyle(
                                fontSize: 24, fontWeight: FontWeight.normal)),
                                margin: EdgeInsets.only(left: 20, top: 0),
                        ),
                    ],
                  ),
                  Row(
                     children: [
                      Container(
                        child: new Text("12 PM",
                            style: TextStyle(
                                fontSize: 24, fontWeight: FontWeight.normal)),
                                margin: EdgeInsets.only(left: 20, top: 0),
                        ),
                    ],
                  ),
                  Row(
                     children: [
                      Container(
                        child: new Text("near Alfragide",
                            style: TextStyle(
                                fontSize: 24, fontWeight: FontWeight.normal)),
                                margin: EdgeInsets.only(left: 20, top: 0),
                        ),
                    ],
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
                    margin: EdgeInsets.only(top: 140.0),
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
