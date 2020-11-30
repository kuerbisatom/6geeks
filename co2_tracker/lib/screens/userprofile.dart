import 'package:flutter/material.dart';

class UserProfile extends StatefulWidget {
  _UserProfileState createState() => new _UserProfileState();
}

class _UserProfileState extends State<UserProfile> {
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
        body: new Center(
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
                new Text("Ana Silva",
                    textScaleFactor: 1.5,
                    style: TextStyle(fontWeight: FontWeight.bold),),
                new Text ("21",
                  textScaleFactor: 1.2),
                new Text ("Porto",
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
                    onPressed: () {},
                    shape: RoundedRectangleBorder(
                      borderRadius: const BorderRadius.all(Radius.circular(25.0))),),),
                new Padding(padding: EdgeInsets.symmetric(horizontal:10.0),
                  child: Container(
                    margin:EdgeInsets.only(top: 65),
                    height: 1.0,
                    width: 800.0,
                    color: Colors.grey)),
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
       ),
    );
  }
}

