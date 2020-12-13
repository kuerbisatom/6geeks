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

class TransportationEdit extends StatefulWidget {
  final int index;
    TransportationEdit({Key key, @required this.index}) : super(key: key);
  State<TransportationEdit> createState() => _TransportationEditState();
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

class _TransportationEditState extends State<TransportationEdit> {
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
          )
        ));
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
