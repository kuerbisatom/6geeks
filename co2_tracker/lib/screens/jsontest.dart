import 'package:flutter/material.dart';
import 'dart:io';
import 'dart:convert';
import 'package:path_provider/path_provider.dart';
import 'package:charts_flutter/flutter.dart' as charts;

import 'dashboard.dart';


Directory dir;

String t_filename = 'tra.json';
//bool t_fileExists = false;
File transportFile;

//Map<String, dynamic> fileContent;
String transportContent;

String s_filename = 'sho.json';
//bool s_fileExists = false;
File shoppingFile;

//Map<String, dynamic> fileContent;
String shoppingContent;

String e_filename = 'eat.json';
//bool e_fileExists = false;
File eatingFile;


//Map<String, dynamic> fileContent;
String eatingContent;


class JSONTest extends StatefulWidget {
  @override
  State createState() => new JSONTestState();
}

class JSONTestState extends State<JSONTest> {
  TextEditingController transportInputController = new TextEditingController();
  TextEditingController shoppingInputController = new TextEditingController();
  TextEditingController eatingInputController = new TextEditingController();


  /*File jsonFile;
  Directory dir;
  String filename = 'jsontry1.json';
  bool fileExists = false;

  //Map<String, dynamic> fileContent;
  String fileContent;*/


  @override
  /*void initState() {
    super.initState();
    getApplicationDocumentsDirectory().then((Directory directory) {
      dir = directory;
      jsonFile = new File(dir.path + '/' + filename);
      fileExists = jsonFile.existsSync();
      if (fileExists) this.setState(() {
        fileContent = jsonDecode(jsonFile.readAsStringSync()).toString();
      });
    });
  }*/

  void initState() {
    super.initState();
    getApplicationDocumentsDirectory().then((Directory directory) {
      dir = directory;
      transportFile = new File(dir.path + '/' + t_filename);
      if (fileExists(transportFile)) this.setState(() {
        transportContent = jsonDecode(transportFile.readAsStringSync()).toString();
      });
      shoppingFile = new File(dir.path + '/' + s_filename);
      if (fileExists(shoppingFile)) this.setState(() {
        shoppingContent = jsonDecode(shoppingFile.readAsStringSync()).toString();
      });
      eatingFile = new File(dir.path + '/' + e_filename);
      if (fileExists(eatingFile)) this.setState(() {
        eatingContent = jsonDecode(eatingFile.readAsStringSync()).toString();
      });
    });
  }

  @override
  void dispose() {
    transportInputController.dispose();
    shoppingInputController.dispose();
    eatingInputController.dispose();
    super.dispose();
  }

  void createFile(Map<String, dynamic> content, Directory dir, String filename) {
    print('creating file');
    File file = new File(dir.path + '/' + filename);
    file.createSync();
    //fileExists = true;
    //file.writeAsStringSync(jsonEncode(content));
  }

  void saveData(File jsonFile, String filename, String fileContent, dynamic value) {
    print('Writing to file');
    DateTime dt = DateTime.now();
    DateTime shortdt = new DateTime(dt.year, dt.month, dt.day);
    String date = shortdt.toString();
    print(date);
    Map<String, dynamic> content = { 'date': date, 'co2': value};
    if (fileExists(jsonFile)) {
      List<Element> els = listFromJson(jsonFile.readAsStringSync());
      els.add(Element.fromJson(content));

      String newContent = listToJson(els);
      print (newContent);

      //Map<String, dynamic> jsonFileContent = jsonDecode(jsonFile.readAsStringSync());
      //jsonFileContent.addAll(content);

      //print(new Element.fromJson(jsonFileContent).toString()); //testing fromjson
      //jsonFile.writeAsStringSync(jsonEncode(jsonFileContent));
      jsonFile.writeAsStringSync(newContent);
    } else {
      print('File does not exist');
      createFile(content, dir, filename);

      List<Element> els = new List<Element>();
      els.add(Element.fromJson(content));
      String newContent = listToJson(els);
      print (newContent);
      jsonFile.writeAsStringSync(newContent);
    }
    this.setState(() {
      List<Element> els = listFromJson(jsonFile.readAsStringSync());
      fileContent = els.toString();
      //fileContent = jsonDecode(jsonFile.readAsStringSync());
    });
  }



  Widget build (BuildContext context) {
    return new Scaffold(
      body: new Column(
        children: <Widget>[
          new Padding(padding: new EdgeInsets.only(top: 10.0)),
          new Text("Transport: ", style: new TextStyle(fontWeight: FontWeight.bold),),
          new Text(getTransportData()),
          new Padding(padding: new EdgeInsets.only(top: 10.0)),
          new Text("Add to JSON file: "),
          new TextField(
            controller: transportInputController,
          ),
          new Padding(padding: new EdgeInsets.only(top: 20.0)),
          new RaisedButton(
            child: new Text("Add transport"),
            onPressed: () => saveData(transportFile, t_filename, transportContent, transportInputController.text),
          ),

          new Padding(padding: new EdgeInsets.only(top: 10.0)),
          new Text("Shopping: ", style: new TextStyle(fontWeight: FontWeight.bold),),
          new Text(getShoppingData()),
          new Padding(padding: new EdgeInsets.only(top: 10.0)),
          new Text("Add to JSON file: "),
          new TextField(
            controller: shoppingInputController,
          ),
          new Padding(padding: new EdgeInsets.only(top: 20.0)),
          new RaisedButton(
            child: new Text("Add shopping"),
            onPressed: () => saveData(shoppingFile, s_filename, shoppingContent, shoppingInputController.text),
          ),

          new Padding(padding: new EdgeInsets.only(top: 10.0)),
          new Text("Eating: ", style: new TextStyle(fontWeight: FontWeight.bold),),
          new Text(getEatingData()),
          new Padding(padding: new EdgeInsets.only(top: 10.0)),
          new Text("Add to JSON file: "),
          new TextField(
            controller: eatingInputController,
          ),
          new Padding(padding: new EdgeInsets.only(top: 20.0)),
          new RaisedButton(
            child: new Text("Add eating"),
            onPressed: () => saveData(eatingFile, e_filename, eatingContent, eatingInputController.text),
          )
        ],
      ),
    );
  }
}



class Element {
  final String date;
  final String co2;

  Element({ this.date, this.co2 });

  factory Element.fromJson(Map<String, dynamic> json) {
    Element el = Element(date: json['date'], co2: json['co2']);
    return el;
  }

  Map<String, dynamic> toJson() => {
    'date': date, 'co2': co2
  };

   //@override
  //String toString() { return '$date, $co2'; }
}

List<Element> listFromJson(String str) =>
    List<Element>.from(
        json.decode(str).map((x) => Element.fromJson(x)));

String listToJson(List<Element> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));


bool fileExists(File jsonFile) {
  if (jsonFile == null) return false;
  return jsonFile.existsSync();
}

String getTransportData(){
  if (fileExists(transportFile)){
    List<Element> list = listFromJson(transportFile.readAsStringSync());
    print(list.toString());
    String content = listToJson(list);
    return content;
  }
  else return 'empty';
}


String getShoppingData(){
  if (fileExists(shoppingFile)){
    List<Element> list = listFromJson(shoppingFile.readAsStringSync());
    print(list.toString());
    String content = listToJson(list);
    return content;
  }
  else return 'empty';
}

String getEatingData(){
  print(fileExists(eatingFile));
  if (fileExists(eatingFile)){
    List<Element> list = listFromJson(eatingFile.readAsStringSync());
    String content = listToJson(list);
    return content;
  }
  else return 'empty';
}

List<TimeSeriesSales> getListTransportData(){
  if (fileExists(transportFile)){
    List<Element> list = listFromJson(transportFile.readAsStringSync());
    print(list.toString());
    List<TimeSeriesSales> list_ts = new List<TimeSeriesSales>();

    for (int i = 0; i < list.length; i++) {
      list_ts.add(new TimeSeriesSales(list[i].date, list[i].co2));
    }
    return list_ts;
  }
  else return [];
}
List<TimeSeriesSales> getListShoppingData(){
  if (fileExists(shoppingFile)){
    List<Element> list = listFromJson(shoppingFile.readAsStringSync());
    print(list.toString());
    List<TimeSeriesSales> list_ts = new List<TimeSeriesSales>();

    for (int i = 0; i < list.length; i++) {
      list_ts.add(new TimeSeriesSales(list[i].date, list[i].co2));
    }
    return list_ts;
  }
  else return [];
}
List<TimeSeriesSales> getListEatingData(){
  if (fileExists(eatingFile)){
    List<Element> list = listFromJson(eatingFile.readAsStringSync());
    print(list.toString());
    List<TimeSeriesSales> list_ts = new List<TimeSeriesSales>();

    for (int i = 0; i < list.length; i++) {
      list_ts.add(new TimeSeriesSales(list[i].date, list[i].co2));
    }
    return list_ts;
  }
  else return [];
}