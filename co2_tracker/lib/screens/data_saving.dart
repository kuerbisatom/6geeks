import 'package:flutter/material.dart';
import 'dart:io';
import 'dart:convert';
import 'package:path_provider/path_provider.dart';
import 'package:co2_tracker/screens/dashboard.dart';

/*
//
// Data file declaration
//
*/

Directory dir;

String t_filename = 'transporte.json';
File transportFile;
String transportContent;

String s_filename = 'shopping.json';
File shoppingFile;
String shoppingContent;

String e_filename = 'eating.json';
File eatingFile;
String eatingContent;

/*
//
// Functions to save data (value is an int representing the co2 emission)
//
*/

void saveTransportData(dynamic value){
  saveData(transportFile, t_filename, transportContent, value);
}

void saveShoppingData(dynamic value){
  saveData(shoppingFile, s_filename, shoppingContent, value);
}

void saveEatingData(dynamic value){
  saveData(eatingFile, e_filename, eatingContent, value);
}

/*
//
// Functions to get data for the AREA chart
//
*/

List<EmissionData> getListTransportData(){
  if (fileExists(transportFile)){
    List<Element> list = listFromJson(transportFile.readAsStringSync());
    print(list.toString());
    List<EmissionData> list_ts = new List<EmissionData>();

    for (int i = 0; i < list.length; i++) {
      list_ts.add(new EmissionData(list[i].date, list[i].co2));
    }
    return list_ts;
  }
  else return [];
}

List<EmissionData> getListShoppingData(){
  if (fileExists(shoppingFile)){
    List<Element> list = listFromJson(shoppingFile.readAsStringSync());
    print(list.toString());
    List<EmissionData> list_ts = new List<EmissionData>();

    for (int i = 0; i < list.length; i++) {
      list_ts.add(new EmissionData(list[i].date, list[i].co2));
    }
    return list_ts;
  }
  else return [];
}

List<EmissionData> getListEatingData(){
  if (fileExists(eatingFile)){
    List<Element> list = listFromJson(eatingFile.readAsStringSync());
    print(list.toString());
    List<EmissionData> list_ts = new List<EmissionData>();

    for (int i = 0; i < list.length; i++) {
      list_ts.add(new EmissionData(list[i].date, list[i].co2));
    }
    return list_ts;
  }
  else return [];
}

/*
//
// Functions to get data for the BAR chart
//
*/

int getTotalTransportValue() {
  List<EmissionData> list = getListTransportData();
  int sum = 0;

  for (int i=0; i<list.length; i++) {
    sum += list[i].getemission();
  }
  return sum;
}

int getTotalShoppingValue() {
  List<EmissionData> list = getListShoppingData();
  int sum = 0;

  for (int i=0; i<list.length; i++) {
    sum += list[i].getemission();
  }
  return sum;
}

int getTotalEatingValue() {
  List<EmissionData> list = getListEatingData();
  int sum = 0;

  for (int i=0; i<list.length; i++) {
    sum += list[i].getemission();
  }
  return sum;
}

/*
//
// Auxiliary functions
//
*/

class DataSaving extends StatefulWidget {
  @override
  State createState() => new DataSavingState();
}

class DataSavingState extends State<DataSaving> {
  TextEditingController transportInputController = new TextEditingController();
  TextEditingController shoppingInputController = new TextEditingController();
  TextEditingController eatingInputController = new TextEditingController();

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

void createFile(Map<String, dynamic> content, Directory dir, String filename) {
  print('creating file');
  print(dir.path + '/' + filename);
  File file = new File(dir.path + '/' + filename);
  file.createSync();
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
    Element last = els.last;
    Element update = Element.fromJson(content);

    if (last.date == update.date) {
      update = correctUpdate(last, update);
      els.removeLast();
    }

    els.add(update);

    String newContent = listToJson(els);
    print (newContent);
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
}

Element correctUpdate(Element last, Element update) {
  int newvalue = int.tryParse(last.getco2()) + int.tryParse(update.getco2());
  update.setco2(newvalue.toString());
  return update;
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

class Element {
  String date;
  String co2;

  Element({ this.date, this.co2 });

  factory Element.fromJson(Map<String, dynamic> json) {
    Element el = Element(date: json['date'], co2: json['co2']);
    return el;
  }

  Map<String, dynamic> toJson() => {
    'date': date, 'co2': co2
  };

  void setco2(String newco2) { this.co2=newco2; }
  void setdate(String newdate) { this.date=newdate; }

  String getco2() { return this.co2; }
  String getdate() { return this.date; }
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