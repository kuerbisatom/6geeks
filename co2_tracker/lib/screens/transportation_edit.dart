import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:co2_tracker/screens/home_screen.dart';
import 'package:co2_tracker/screens/transportation_main.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:co2_tracker/screens/globals.dart' as globals;
import 'package:flutter/gestures.dart' show DragStartBehavior;
import 'package:flutter/painting.dart';
import 'package:flutter/services.dart';

class TransportationEdit extends StatefulWidget {
  final int index;
  TransportationEdit({Key key, @required this.index}) : super(key: key);
  State<TransportationEdit> createState() => _TransportationEditState();
}

class _TransportationEditState extends State<TransportationEdit> {
  @override
  void initState() {
    super.initState();
  }

  final _formKey = GlobalKey<FormState>();
  final TextEditingController _controller1 = TextEditingController();

  String dropdownValue = '  Car';

  Widget build(BuildContext context) {
    const sizedBoxSpace = SizedBox(height: 24);
    const sizedBoxSpace2 = SizedBox(height: 32);
    const sizedBoxSpaceWidth3 = SizedBox(width: 110);
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        centerTitle: true,
        title: Text("Transportation"),
        automaticallyImplyLeading: false,
      ),
      body: new Form(
        key: _formKey,
        child: Column(
            children: [
              Container(
                  margin: EdgeInsets.all(10),
                  child: Text("Add new taken route",
                    textAlign: TextAlign.center,
                    style: new TextStyle(
                        fontSize: 24, fontWeight: FontWeight.bold),)),
              Divider(),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Container(
                    width: 105,
                    child: Text(" Method:", style: new TextStyle(
                      fontSize: 20, fontWeight: FontWeight.bold,
                    ),),
                  ),
                  Container(
                    height: 60,
                    width: 250,
                    margin: EdgeInsets.all(10),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(5.0),
                        color: Colors.white,
                        border: Border.all(color: Colors.green,width: 2)),
                    child: DropdownButtonHideUnderline(
                        child: DropdownButton<String>(
                          value: dropdownValue,
                          icon: Icon(Icons.arrow_downward,color: Colors.green,),
                          iconSize: 24,
                          elevation: 16,
                          style: TextStyle(color: Colors.black,
                              fontSize: 18
                          ),
                          onChanged: (String newValue) {
                            setState(() {
                              dropdownValue = newValue;
                            });
                          },
                          items: <String>["  Car", '  Bus', '  Metro', "  Train"]
                              .map<DropdownMenuItem<String>>((String value) {
                            return DropdownMenuItem<String>(
                              value: value,
                              child: Text(value,
                                  textAlign: TextAlign.center),
                            );
                          }).toList(),
                        )),
                  ),
                ],
              ),
              Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Container(
                      width: 100,
                      child:Text("Distance:", style: new TextStyle(
                        fontSize: 20, fontWeight: FontWeight.bold,
                      ),),
                    ),
                  Container(
                    width: 250,
                    child: TextFormField(
                      decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: 'km',
                        hintText: 'Distance Traveled',
                      ),
                      inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                      keyboardType: TextInputType.number,
                      controller: _controller1,
                      validator: (value) {
                        if (value.isEmpty) {
                          return "Please enter the distance in km";
                        }
                        return null;
                      },
                    ),
                  ),
                ]
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 50.0),
                child: Center(
                    child:FlatButton(
                      height: 40,
                      child: Text('Add route',
                          textScaleFactor: 1.4,
                          style: TextStyle(color: Colors.white)),
                      padding: EdgeInsets.only(
                          top: 13.0, bottom: 13, right: 40, left: 40),
                      color: Color(0xFF66BB64),
                      onPressed: () {
                        if (_formKey.currentState.validate()) {
                          globals.addPath(dropdownValue,int.parse(_controller1.text));
                          _controller1.clear();
                          globals.currentOverlay = true;
                          Navigator.pushAndRemoveUntil(
                            context,
                            MaterialPageRoute(builder: (context) => MyHomePage()),
                                (Route <dynamic> route) => false,
                          );
                        }},
                      shape: RoundedRectangleBorder(
                          borderRadius: const BorderRadius.all(
                              Radius.circular(25.0))
                      ),
                    )
                ),
              ),
            ]
        ),
      ),
    );
  }
}