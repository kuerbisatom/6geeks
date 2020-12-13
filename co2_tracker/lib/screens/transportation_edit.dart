import 'package:co2_tracker/screens/home_screen.dart';
import 'package:co2_tracker/screens/transportation_main.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:co2_tracker/screens/globals.dart' as globals;
import 'package:flutter/gestures.dart' show DragStartBehavior;

class TransportationEdit extends StatefulWidget {
  final int index;
    TransportationEdit({Key key, @required this.index}) : super(key: key);
  State<TransportationEdit> createState() => _TransportationEditState();
}

class _TransportationEditState extends State<TransportationEdit> {
  @override
  final myController1 = TextEditingController();
    final myController2 = TextEditingController();
   final myController3 = TextEditingController();
  int radioValue1 = 0;
  int radioValue2 = 0;
  int radioValue3 = 0;

  void initState() {
    super.initState();
  }

  void handleRadioValueChanged1(int value){
    setState(() {
      radioValue1 = value;
    });
  }

 Widget build(BuildContext context) {
   const sizedBoxSpace = SizedBox(height: 24);
    const sizedBoxSpace2 =  SizedBox(height: 32);
    const sizedBoxSpaceWidth3 = SizedBox(width: 110);
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
                  MaterialPageRoute(builder: (context) => TransportationMain()),
                      (Route<dynamic> route) => false,
                ),
              },
            ),
            centerTitle: true,
            title: Text("Transportation"),
            automaticallyImplyLeading: false,
          ),
        body: new Form(
          child: Scrollbar(
              child: SingleChildScrollView(
                dragStartBehavior: DragStartBehavior.down,
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Column(
                  children: [
                    sizedBoxSpace,
                    new Text( "Method:",
                      textScaleFactor: 1.3,
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    Container(
                      child: Row(
                        children: [

                          sizedBoxSpaceWidth3,
                          new Container(
                            child: Column(
                              children: [
                                for(int index = 0 ; index < 4; ++index)
                                  new Radio(
                                    value: index,
                                    groupValue: radioValue1,
                                    onChanged: handleRadioValueChanged1,
                                  ),
                              ],
                            ),
                          ),
                          new Container(
                            child: Column(
                              children: [
                                sizedBoxSpace2,

                                new Text("Car",
                                  style: TextStyle(fontWeight: FontWeight.bold),
                                ),
                                sizedBoxSpace2,

                                new Text("Bus",
                                  style: TextStyle(fontWeight: FontWeight.bold),
                                ),
                                sizedBoxSpace2,

                                new Text("Metro",
                                  style: TextStyle(fontWeight: FontWeight.bold),
                                ),
                                sizedBoxSpace2,

                                new Text("Bike",
                                  style: TextStyle(fontWeight: FontWeight.bold),
                                ),
                                sizedBoxSpace2,
                              ]
                          ),
                        ),
                    ],
                    )),
                    sizedBoxSpace,
                    new Text( "Duration:",
                      textScaleFactor: 1.3,
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                      ],
                    )),
                )),
            ),
                  
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
