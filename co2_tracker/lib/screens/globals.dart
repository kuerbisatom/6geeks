library globals.dart;

import 'dart:convert';
import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';


bool currentOverlay = true;
String username;
int days = 7;
int baseline;

addFood(QuerySnapshot document, List<int> items,){
  var value = 0;
  DateTime now = new DateTime.now();
  DateTime date = new DateTime(now.year, now.month, now.day);


  Firestore.instance.collection("food").getDocuments().then(
          (QuerySnapshot snapshot) {
        for (var i in items) {
          value += snapshot.documents[i]["value"];
        }

        bool flag = true;
        for (var elem in document.documents) {
          DateTime dt = new DateTime.fromMillisecondsSinceEpoch(elem["date"].seconds * 1000);
          dt = new DateTime(dt.year, dt.month, dt.day);
          if (dt == date) {
            flag = false;
            elem.reference.updateData({
              "emission": elem["emission"] + value,
            });
          }

        }
        if (flag) {
          Firestore.instance.collection("users").document(username).collection("food").document().setData({
            "date": date,
            "emission": value,
          });
        }

        Firestore.instance.collection("users").document(username).get().then((document) {
          DateTime dt = new DateTime.fromMillisecondsSinceEpoch(
              document.data["daily"]["day"].seconds * 1000);
          int number = document.data["daily"]["emission"];
          if (dt == date) {
            document.reference.updateData({
              "daily.emission": document.data["daily"]["emission"] + value,
            });
          } else {
            document.reference.updateData({
              "daily.date": date,
              "daily.emission": document.data["daily"]["emission"] + value,
            });
          }
        });

      });

}

addProduct(QuerySnapshot document, List<int> items, bool plastic, bool secondHand, country) {
  var value = 0;
  DateTime now = new DateTime.now();
  DateTime date = new DateTime(now.year, now.month, now.day);


  Firestore.instance.collection("products").getDocuments().then(
          (QuerySnapshot snapshot) {
        for (var i in items) {
          value += snapshot.documents[i]["value"];
        }
        if (plastic) value = value + 2;
        if (secondHand) value = (value/10).round();
        Random gen = new Random();
        value = value + gen.nextInt(20);
        print(value);
        bool flag = true;
        for (var elem in document.documents) {
          DateTime dt = new DateTime.fromMillisecondsSinceEpoch(elem["date"].seconds * 1000);
          dt = new DateTime(dt.year, dt.month, dt.day);
          if (dt == date) {
            flag = false;
            elem.reference.updateData({
              "emission": elem["emission"] + value,
            });
          }

        }
        if (flag) {
          Firestore.instance.collection("users").document(username).collection("product").document().setData({
            "date": date,
            "emission": value,
          });
        }

        Firestore.instance.collection("users").document(username).get().then((document) {
          DateTime dt = new DateTime.fromMillisecondsSinceEpoch(
              document.data["daily"]["day"].seconds * 1000);
          int number = document.data["daily"]["emission"];
          if (dt == date) {
            document.reference.updateData({
              "daily.emission": document.data["daily"]["emission"] + value,
            });
          } else {
            document.reference.updateData({
              "daily.day": date,
              "daily.emission": document.data["daily"]["emission"] + value,
            });
          }
        });
      });
}

addPath(vehicle,distance){
  DateTime now = new DateTime.now();
  DateTime date = new DateTime(now.year, now.month, now.day);

  int value;
  switch (vehicle){
    case "  Car":
      value = (distance/10).ceil();
      break;
    case "  Train":
      value = ((50*distance)/1000).ceil();
      break;
    case "  Bus":
      value = (distance/5).ceil();
      break;
    case "  Metro":
      value = ((13*distance)/500).ceil();
      break;
  }

  Firestore.instance.collection("users").document(username).get().then((document) {
    DateTime dt = new DateTime.fromMillisecondsSinceEpoch(
        document.data["daily"]["day"].seconds * 1000);
    int number = document.data["daily"]["emission"];
    if (dt == date) {
      document.reference.updateData({
        "daily.emission": document.data["daily"]["emission"] + value,
      });
    } else {
      document.reference.updateData({
        "daily.day": date,
        "daily.emission": document.data["daily"]["emission"] + value,
      });
    }
  });

  Firestore.instance.collection("users").document(username).collection("transport").getDocuments().then(
          (documents) {
        bool flag = true;
        for (var elem in documents.documents){
          print (elem["date"]);
          DateTime dt = new DateTime.fromMillisecondsSinceEpoch(
              elem["date"].seconds * 1000);
          if (dt == date) {
            flag = false;
            elem.reference.updateData({
              "emission": elem["emission"] + value,
            });
          }
        }
        if (flag) {
          Firestore.instance.collection("users").document(username).collection("transport").document().setData({
            "date": date,
            "emission": value,
          });
        }

      }) ;
}
