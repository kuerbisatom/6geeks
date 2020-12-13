import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:co2_tracker/screens/survey.dart';
import 'package:co2_tracker/screens/home_screen.dart';
import 'package:co2_tracker/screens/globals.dart' as globals;
import 'package:flutter/services.dart';

typedef Valuebool = bool Function(bool);

class UserProfile extends StatefulWidget {
  //Valuebool callback;
  UserProfile();

  _UserProfileState createState() => new _UserProfileState();
}

class _UserProfileState extends State<UserProfile> {
  TextEditingController _controller1;
  TextEditingController _controller2;
  TextEditingController _controller3;

  void initState() {
    super.initState();
    _controller1 = TextEditingController();
    _controller2 = TextEditingController();
    _controller3 = TextEditingController();
  }

  void dispose() {
    _controller1.dispose();
    _controller2.dispose();
    _controller3.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
        body: StreamBuilder(
            stream: Firestore.instance.collection("users").document(globals.username).snapshots(),
            builder: (context, snapshot) {
              if(!snapshot.hasData) return CircularProgressIndicator();
              return new Center(
                child: new Column(
                  children: <Widget>[
                    new Container(
                        margin: EdgeInsets.all(30),
                        width: 290.0,
                        height: 150.0,
                        decoration: new BoxDecoration(
                            shape: BoxShape.circle,
                            image: new DecorationImage(
                                fit: BoxFit.fill,
                                image: new NetworkImage(
                                    "https://www.irishtimes.com/polopoly_fs/1.3452937.1523022969!/image/image.jpg_gen/derivatives/box_620_330/image.jpg")
                            )
                        )),
                    new Text(snapshot.data["name"],
                      textScaleFactor: 1.5,
                      style: TextStyle(fontWeight: FontWeight.bold),),
                    new Text (snapshot.data["age"].toString(),
                        textScaleFactor: 1.2),
                    new Text (snapshot.data["city"],
                        textScaleFactor: 1.2),
                    new Container(
                      margin: EdgeInsets.only(top: 20.0),
                      child: FlatButton(
                        height: 40,
                        child: Text("Edit Initial Survey",
                            textScaleFactor: 1.4,
                            style: TextStyle(color: Colors.white)),
                        padding: EdgeInsets.all(13.0),
                        color: Color(0xFF66BB64),
                        onPressed: () {
                          // Set state "overlay = false; from another class)
                          setState(() {
                            globals.currentOverlay = false;
                            Navigator.pushAndRemoveUntil(
                              context,
                              MaterialPageRoute(builder: (context) => Survey()),
                                  (Route<dynamic> route) => false,
                            );
                          });
                        },
                        shape: RoundedRectangleBorder(
                            borderRadius: const BorderRadius.all(Radius.circular(25.0))),),),
                    new Container(
                        margin: EdgeInsets.only(top: 10, bottom: 10),
                        child: Column(
                          children: [
                            Text("Not you? Create a new Pofile"),
                            OutlineButton(
                                onPressed: () {
                                  showDialog(
                                    context: context,
                                    builder: (context) => AlertDialog(
                                      title: Text("Create new user"),
                                      content: SingleChildScrollView(
                                        child: ListBody(
                                          children: <Widget>[
                                            TextField(
                                              decoration: InputDecoration(
                                                border: OutlineInputBorder(),
                                                labelText: 'Name',
                                              ),
                                              controller: _controller1,
                                            ),
                                            Container(
                                              margin: EdgeInsets.only(top: 10),
                                              child: TextField(
                                                decoration: InputDecoration(
                                                  border: OutlineInputBorder(),
                                                  labelText: 'Age',
                                                ),
                                                inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                                                keyboardType: TextInputType.number,
                                                controller: _controller2,
                                              ),),
                                            Container(
                                              margin: EdgeInsets.only(top: 10),
                                              child: TextField(
                                                decoration: InputDecoration(
                                                  border: OutlineInputBorder(),
                                                  labelText: 'City',
                                                ),
                                                controller: _controller2,
                                              ),)
                                          ],
                                        ),
                                      ),
                                      actions: <Widget>[
                                        TextButton(
                                          child: Text('Cancel'),
                                          onPressed: () {
                                            Navigator.of(context).pop();
                                          },
                                        ),
                                        TextButton(
                                          child: Text('Add'),
                                          onPressed: () {

                                            _controller2.clear();
                                            _controller1.clear();
                                            _controller3.clear();
                                            Navigator.of(context).pop();
                                          },
                                        ),
                                      ],),
                                  );
                                },
                                child: Text("Create", style: new TextStyle(color: Colors.green),))
                          ],
                        )),

                    new Divider(),
                    new Container(
                      margin: EdgeInsets.only(right: 260.0, top: 10),
                      child: Text ("Badges",
                        textScaleFactor: 1.2,
                        style: TextStyle(fontWeight: FontWeight.bold),),),
                    new Container(
                      margin: EdgeInsets.only(right: 250.0, top: 20),
                      height: 70.0,
                      child: Image.network("https://i.pinimg.com/originals/11/5f/0a/115f0ac90dfc685ff3564a27cb9e11d1.png"),),
                  ],
                ),
              );})
    );
  }
}

