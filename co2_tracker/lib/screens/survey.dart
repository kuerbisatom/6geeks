import 'package:co2_tracker/screens/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/gestures.dart' show DragStartBehavior;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:splashscreen/splashscreen.dart';

class Intro extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.green,
      body: Padding(
        padding: EdgeInsets.only(top:30),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly, //NOT WORKING!
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Center(
                child: Text(
              "CO2-Tracker",
              style: new TextStyle(fontSize: 30,color: Colors.white),
            )),
            Center(child: Image.asset("assets/launcher/logo.png", scale: 2.5)),
            Center(child: Text("Ready to Start your CO2-Journey?",
              style: new TextStyle(fontSize: 20,color: Colors.white),),),
            Center(child: FlatButton(
              height: 40,
              child: Text('Find your C02 Baseline',
                  textScaleFactor: 1.4,
                  style: TextStyle(color: Colors.green)),
              padding: EdgeInsets.only(top: 13.0, bottom: 13, right:40, left:40),
              color: Colors.white,
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => Survey()),
                );
              },
              shape: RoundedRectangleBorder(
                  borderRadius: const BorderRadius.all(Radius.circular(25.0))),),),
          Center(child: FlatButton(
            height: 40,
            child: Text('Skip this Step',
                textScaleFactor: 1.4,
                style: TextStyle(color: Colors.white)),
            padding: EdgeInsets.only(top: 13.0, bottom: 13, right:40, left:40),
            color: Colors.grey,
            onPressed: () {
              Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(builder: (context) => MyHomePage()),
                    (Route <dynamic> route) => false,
              );
            },
            shape: RoundedRectangleBorder(
                borderRadius: const BorderRadius.all(Radius.circular(25.0))),),),
            Center(child: Text("You can edit later on your profile", style: new TextStyle(color: Colors.white),),)

          ],
        ),
      ),
    );
  }
}

class Survey extends StatefulWidget {

  SurveyState createState() => SurveyState();
}

class SurveyState extends State<Survey> {
  bool checkboxValue1 = false;
  bool checkboxValue2 = false;
  bool checkboxValue3 = false;
  bool checkboxValue4 = false;
  bool checkboxValue5 = false;
  bool checkboxValue6 = false;
  bool checkboxValue7 = false;
  bool checkboxValue8 = false;
  bool checkboxValue9 = false;
  bool checkboxValue10 = false;
  int radioValue1 = 0;
  int radioValue2 = 0;
  int radioValue3 = 0;

  void handleRadioValueChanged1(int value){
    setState(() {
      radioValue1 = value;
    });
  }
  void handleRadioValueChanged2(int value){
    setState(() {
      radioValue2 = value;
    });
  }
  void handleRadioValueChanged3(int value){
    setState(() {
      radioValue3 = value;
    });
  }

  @override
  Widget build(BuildContext context) {

    const sizedBoxSpace = SizedBox(height: 24);
    const sizedBoxSpace2 =  SizedBox(height: 32);
    const sizedBoxSpaceWidth2 = SizedBox(width: 50);
    const sizedBoxSpaceWidth1 = SizedBox(width: 20);
    const sizedBoxSpaceWidth3 = SizedBox(width: 110);
    const sizedBoxSpaceWidth4 = SizedBox(width: 130);


    return new Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text("CO2 Baseline Survey"),
      ),
      body: new Form(
          child: Scrollbar(
              child: SingleChildScrollView(
                dragStartBehavior: DragStartBehavior.down,
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Column(
                  children: [
                    sizedBoxSpace,
                    new Text( "How many low energy light bulbs do you have in your home?",
                    textScaleFactor: 1.3,
                    style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    TextFormField(
                      decoration: InputDecoration(
                        labelText:"Insert number...",
                      ),
                    ),

                    sizedBoxSpace,
                    new Text( "When was your Property built?",
                      textScaleFactor: 1.3,
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    TextFormField(
                      decoration: InputDecoration(
                        labelText:"Insert year...",
                      ),
                    ),

                    sizedBoxSpace,
                    new Text( "How many rooms do you have in your home?",
                      textScaleFactor: 1.3,
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    TextFormField(
                      decoration: InputDecoration(
                        labelText:"Insert number",
                      ),
                    ),

                    sizedBoxSpace,
                    new Text( "What is your heating system?",
                      textScaleFactor: 1.3,
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),

                    new Container(
                      child: Row(
                        children: [
                          new Container(
                            child: Column(
                              children: [

                                new Text("Central Heating",
                                  style: TextStyle(fontWeight: FontWeight.bold),
                                ),
                                sizedBoxSpace2,

                                new Text("Boiler",
                                  style: TextStyle(fontWeight: FontWeight.bold),
                                ),
                                sizedBoxSpace2,

                                new Text("Furnace",
                                  style: TextStyle(fontWeight: FontWeight.bold),
                                ),
                                sizedBoxSpace2,

                                new Text("Heat Pump",
                                  style: TextStyle(fontWeight: FontWeight.bold),
                                ),
                                sizedBoxSpace2,

                                new Text("Solar Heating",
                                  style: TextStyle(fontWeight: FontWeight.bold),
                                ),

                              ],
                            ),
                          ),
                          sizedBoxSpaceWidth1,
                          new Container(
                            child: Column(
                              children: [

                                Checkbox(
                                  value: checkboxValue1,
                                  onChanged: (value) {
                                    setState(() {
                                      checkboxValue1 = value;
                                    });
                                  },
                                ),
                                Checkbox(
                                  value: checkboxValue2,
                                  onChanged: (value) {
                                    setState(() {
                                      checkboxValue2 = value;
                                    });
                                  },
                                ),
                                Checkbox(
                                  value: checkboxValue3,
                                  onChanged: (value) {
                                    setState(() {
                                      checkboxValue3 = value;
                                    });
                                  },
                                ),
                                Checkbox(
                                  value: checkboxValue4,
                                  onChanged: (value) {
                                    setState(() {
                                      checkboxValue4 = value;
                                    });
                                  },
                                ),
                                Checkbox(
                                  value: checkboxValue5,
                                  onChanged: (value) {
                                    setState(() {
                                      checkboxValue5 = value;
                                    });
                                  },
                                ),
                              ],
                            ),
                          ),
                          sizedBoxSpaceWidth1,
                          new Container(
                            child: Column(
                              children: [

                                new Text("Electric Heating",
                                  style: TextStyle(fontWeight: FontWeight.bold),
                                ),
                                sizedBoxSpace2,

                                new Text("Portable Heater",
                                  style: TextStyle(fontWeight: FontWeight.bold),
                                ),
                                sizedBoxSpace2,

                                new Text("Fireplace",
                                  style: TextStyle(fontWeight: FontWeight.bold),
                                ),
                                sizedBoxSpace2,

                                new Text("Gas Heating",
                                  style: TextStyle(fontWeight: FontWeight.bold),
                                ),
                                sizedBoxSpace2,

                                new Text("Radiators",
                                  style: TextStyle(fontWeight: FontWeight.bold),
                                ),

                              ],
                            ),
                          ),
                          sizedBoxSpaceWidth1,
                          new Container(
                            child: Column(
                              children: [

                                Checkbox(
                                  value: checkboxValue6,
                                  onChanged: (value) {
                                    setState(() {
                                      checkboxValue6 = value;
                                    });
                                  },
                                ),
                                Checkbox(
                                  value: checkboxValue7,
                                  onChanged: (value) {
                                    setState(() {
                                      checkboxValue7 = value;
                                    });
                                  },
                                ),
                                Checkbox(
                                  value: checkboxValue8,
                                  onChanged: (value) {
                                    setState(() {
                                      checkboxValue8 = value;
                                    });
                                  },
                                ),
                                Checkbox(
                                  value: checkboxValue9,
                                  onChanged: (value) {
                                    setState(() {
                                      checkboxValue9 = value;
                                    });
                                  },
                                ),
                                Checkbox(
                                  value: checkboxValue10,
                                  onChanged: (value) {
                                    setState(() {
                                      checkboxValue10 = value;
                                    });
                                  },
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),

                    sizedBoxSpace,
                    new Text( "How often do your turn on your heating?",
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

                                new Text("Very Often",
                                  style: TextStyle(fontWeight: FontWeight.bold),
                                ),
                                sizedBoxSpace2,

                                new Text("Often",
                                  style: TextStyle(fontWeight: FontWeight.bold),
                                ),
                                sizedBoxSpace2,

                                new Text("Rarely",
                                  style: TextStyle(fontWeight: FontWeight.bold),
                                ),
                                sizedBoxSpace2,

                                new Text("Never",
                                  style: TextStyle(fontWeight: FontWeight.bold),
                                ),
                                sizedBoxSpace2,


                              ],
                            ),
                          ),
                        ],
                      ),
                    ),

                    sizedBoxSpace,
                    new Text( "Which do you most often use for cooking?",
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
                                for(int index = 0 ; index < 3; ++index)
                                  new Radio(
                                    value: index,
                                    groupValue: radioValue2,
                                    onChanged: handleRadioValueChanged2,
                                  ),
                              ],
                            ),
                          ),
                          new Container(
                            child: Column(
                              children: [
                                sizedBoxSpace2,

                                new Text("Liquid Fuel",
                                  style: TextStyle(fontWeight: FontWeight.bold),
                                ),
                                sizedBoxSpace2,

                                new Text("Gas Fuel",
                                  style: TextStyle(fontWeight: FontWeight.bold),
                                ),
                                sizedBoxSpace2,

                                new Text("Electricity",
                                  style: TextStyle(fontWeight: FontWeight.bold),
                                ),
                                sizedBoxSpace2,



                              ],
                            ),
                          ),
                        ],
                      ),
                    ),

                    sizedBoxSpace,
                    new Text( "How many adults live in your home?",
                      textScaleFactor: 1.3,
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    TextFormField(
                      decoration: InputDecoration(
                        labelText:"Insert number",
                      ),
                    ),

                    sizedBoxSpace,
                    new Text( "Do you recycle?",
                      textScaleFactor: 1.3,
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),

                    Container(
                      child: Row(
                        children: [
                          sizedBoxSpaceWidth4,


                          new Container(
                            child: Column(
                              children: [
                                for(int index = 0 ; index < 2; ++index)
                                  new Radio(
                                    value: index,
                                    groupValue: radioValue3,
                                    onChanged: handleRadioValueChanged3,
                                  ),
                                sizedBoxSpaceWidth1,
                              ],
                            ),
                          ),
                          new Container(
                            child: Column(
                              children: [
                                sizedBoxSpace2,

                                new Text("Yes",
                                  style: TextStyle(fontWeight: FontWeight.bold),
                                ),
                                sizedBoxSpace2,

                                new Text("No",
                                  style: TextStyle(fontWeight: FontWeight.bold),
                                ),
                                sizedBoxSpace2,
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),

                    sizedBoxSpace,
                    Container(
                      child: FlatButton(
                        height: 40,
                        child: Text("Get Results",
                            textScaleFactor: 1.4,
                            style: TextStyle(color: Colors.white)),
                        padding: EdgeInsets.all(13.0),
                        color: Color(0xFF66BB64),
                        onPressed: () {
                          //_dontShowSurveyagain();
                          Navigator.pushAndRemoveUntil(
                            context,
                            MaterialPageRoute(builder: (context) => Outro()),
                              (Route<dynamic> route) => false,
                          ); },
                        shape: RoundedRectangleBorder(
                            borderRadius: const BorderRadius.all(Radius.circular(100.0))
                        ),
                      ),
                    ),
                    sizedBoxSpace,

                  ],
                ),
              ),
          ),
      ),
    );

  }
}

class Outro extends StatelessWidget{

  Widget build(BuildContext context) {
    return new SplashScreen(
        seconds: 3,
        navigateAfterSeconds: new AfterSplash(),
        title: new Text('Calculating your Baseline',
          style: new TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 20.0
          ),),
        image: new Image.network('https://i.imgur.com/TyCSG9A.png'),
        backgroundColor: Colors.white,
        styleTextUnderTheLoader: new TextStyle(),
        photoSize: 100.0,
        onClick: ()=>Text("Keep calm and drink a tea"),
        loaderColor: Colors.red
    );
  }
}

class AfterSplash extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      body: new Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget> [
            Center(child: Text("Good Job!",
                style: new TextStyle(
                    fontSize: 25.0)),
            ),
            Center(child: Text("Your daily CO2 Baseline is:",
                style: new TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 25.0),)),
            Center(child: Text("10kg:",
              style: new TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 30.0),)),
            Center(child: Text("That is less than 98% of the humans", textAlign: TextAlign.center,
              style: new TextStyle(
                  fontSize: 25.0),)),
            MaterialButton(
              onPressed: () {},
              color: Colors.blue,
              textColor: Colors.white,
              padding: EdgeInsets.all(16),
              shape: CircleBorder(),
            )
          ]
        )
      ),
    );
  }
}

_dontShowSurveyagain() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  await prefs.setBool('showSurvey', false);
}



