import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:co2_tracker/screens/globals.dart' as globals;


class Community extends StatefulWidget {
  @override
  _CommunityState createState() => _CommunityState();
}

class _CommunityState extends State<Community>{

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }


  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Text("Daily Dashboard", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20)),
          Divider(color: Colors.black12),
          Container(
              width: 400,
              height: 300,
              child: StreamBuilder(
                stream: Firestore.instance.collection("users").snapshots(),
                builder: (context, snapshot) {
                  if (!snapshot.hasData) return CircularProgressIndicator();
                  DateTime now = new DateTime.now();
                  DateTime date = new DateTime(now.year,now.month,now.day);

                  Map<int, String> map = Map.fromIterable(
                    snapshot.data.documents,
                    key: (item) {
                      DateTime dt = new DateTime.fromMillisecondsSinceEpoch(
                          item["daily"]["day"].seconds * 1000);
                      if (dt == date){
                        return item["baseline"] + item["daily"]["emission"];
                      } else {
                        return 0;
                      }
                    },
                    value: (item) => item.documentID,
                  );
                  var sorted = map.keys.toList()..sort();
                  List <String> n_temp = [];
                  List <int> e_temp = [];
                  for (var elem in sorted) {
                    if (elem != 0){
                      if (map[elem] == globals.username) {
                        n_temp.add("You");
                      } else {
                        n_temp.add(map[elem]);
                      }
                      e_temp.add(elem);
                    }
                  }
                  return ListView.separated(
                    padding: const EdgeInsets.all(8),
                    itemCount: n_temp.length,
                    itemBuilder: (BuildContext context, int index) {
                      return Container(
                        height: 50,
                        child: create_List(n_temp,e_temp,index),
                      );
                    }, separatorBuilder: (BuildContext context, int index) => const Divider(),
                  );
                },
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
                        return create_Cards(index,snapshot.data.documents);
                      },
                      itemCount: snapshot.data.documents.length,
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

  create_List(name, emission, index) {
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
              child: big(name[index]),
            )
        ),
        Container(
          margin: EdgeInsets.only(right: 20),
          child: Text(emission[index].toString() + " kg",style: TextStyle(fontWeight: FontWeight.bold,) ),
        ),
      ],
    );
  }
  big (name) {
    if (name == "You"){
      return Text(name, style: new TextStyle(fontWeight: FontWeight.bold));
    }
    return Text(name);
  }

  Widget create_Cards(index, documents) {
    return Container(
        child: Card(
          shadowColor: Colors.green,
          borderOnForeground: true,
          //elevation: 10,
          shape: new RoundedRectangleBorder(
            side: new BorderSide(color: Colors.green, width: 2.0),
            borderRadius: BorderRadius.circular(20.0)),
          //clipBehavior: Clip.hardEdge,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              ListTile(
                title: Text(
                  documents[index]["Title"],
                  textAlign: TextAlign.center,
                  style: new TextStyle(fontWeight: FontWeight.bold),),
              ),
              Expanded(
                  child: new SingleChildScrollView(
                    scrollDirection: Axis.vertical,
                    child: Container(
                      margin: EdgeInsets.only(left: 20, right: 20,),
                      child: Column (
                          children: <Widget> [
                            Text(documents[index]["Content"]),
                            check_part(documents[index]["participants"]),
                          ]
                      ),
                  )
                ),
              ),
              Center(
                child: FlatButton(
                  height: 10,
                  child: Text('Join',
                      textScaleFactor: 1.0,
                      style: TextStyle(color: Colors.white)),
                  padding: EdgeInsets.only(top: 13.0, bottom: 10, right:40, left:40),
                  color: Colors.green,
                  onPressed: () {
                    showDialog(
                      context: context,
                      builder: (context) => AlertDialog(
                        title: Text('Join ' + documents[index]["Title"]),
                        content: SingleChildScrollView(
                          child: ListBody(
                            children: <Widget>[
                              Text('This will join you as an participant in the Challenge'),
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
                            child: Text('Approve'),
                            onPressed: () {
                              Firestore.instance.collection("challenges").document(documents[index].documentID).updateData(
                                  {"participants": FieldValue.arrayUnion([globals.username])}
                              );
                              Navigator.of(context).pop();
                            },
                        ),
                      ],),
                    );
                  },

                  shape: RoundedRectangleBorder(
                      borderRadius: const BorderRadius.all(Radius.circular(25.0))),),),
            ],
          ),
        )
    );
  }
}

check_part(part) {

  if (part.length == 0){
    return Text("No Participants");
  } else {
    String p = "";
    for (var x in part){
      p += x + " ";
    }
    return Text('Participants: $p');
  }
}