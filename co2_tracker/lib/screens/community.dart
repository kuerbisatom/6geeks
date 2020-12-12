import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_swiper/flutter_swiper.dart';


class Community extends StatefulWidget {
  @override
  _CommunityState createState() => _CommunityState();
}

class _CommunityState extends State<Community>{

  final List<String> entries = ["Lisa","Peter","You","Fish","Dog","Wolf"];
  final List<String> em = ["14","15","1234","123","121","1452"];
  final List<String> cards = ["Test1","Test2"];
  final List<String> challenge = ["Challenge1", "Challenge2"];

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Text("Weekly Dashboard", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20)),
            Divider(color: Colors.black12),
            Container(
                width: 400,
                height: 300,
              child: ListView.separated(
                padding: const EdgeInsets.all(8),
                itemCount: entries.length,
                itemBuilder: (BuildContext context, int index) {
                  return Container(
                    height: 50,
                    child: create_List(index),
                  );
                },
                separatorBuilder: (BuildContext context, int index) => const Divider(),
              )
            ),
            Divider(color: Colors.black12),
            Text("Challenges", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20)),
            StreamBuilder(
                stream: Firestore.instance.collection("challenges").snapshots(),
                builder: (context, snapshot) {
                  if (!snapshot.hasData) return CircularProgressIndicator();
                  return Container(
                      margin: EdgeInsets.only(bottom: 10),
                      height: 200,
                      width: 400,
                      child: new Swiper(
                        itemBuilder: (BuildContext context, int index) {
                          return create_Cards(index);
                        },
                        itemCount: cards.length,
                        viewportFraction: 0.8,
                        scale: 0.9,
                      )
                  );
                }
            ),

          ],
      ),
    );
  }

  create_List(index) {
    return Row (
      children: [
        Text((index+1).toString(), style: TextStyle(fontWeight: FontWeight.bold,) ),
        Container(
            margin: new EdgeInsets.only(left: 10.0),
            height: 50,
            width: 50,
            decoration: new BoxDecoration(
                border: Border.all(color: Colors.green, width: 3.0),
                shape: BoxShape.circle,
                image: new DecorationImage(
                    fit: BoxFit.fill,
                    image: new NetworkImage(
                        "https://www.irishtimes.com/polopoly_fs/1.3452937.1523022969!/image/image.jpg_gen/derivatives/box_620_330/image.jpg")
                )
            )
        ),
        Expanded(
            child: Center(
              child: Text(entries[index]),
            )
        ),
        Container(
          margin: EdgeInsets.only(right: 20),
          child: Text(em[index] + "kg",style: TextStyle(fontWeight: FontWeight.bold,) ),
        ),
      ],
    );
  }

  Widget create_Cards(index) {
    return Container(
        child: Card(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
             ListTile(
                title: Text(cards[index], textAlign: TextAlign.center,),
            ),
              Expanded(
                  child: Container(
                    child: Text(challenge[index])
                  )
                ),
              Center(child: FlatButton(
                  height: 10,
                  child: Text('Join',
                      textScaleFactor: 1.0,
                      style: TextStyle(color: Colors.white)),
                  padding: EdgeInsets.only(top: 13.0, bottom: 13, right:40, left:40),
                  color: Colors.green,
                  onPressed: () {},
                  shape: RoundedRectangleBorder(
                      borderRadius: const BorderRadius.all(Radius.circular(25.0))),),),
              ],
              ),
          )
        );
  }
}