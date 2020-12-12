library globals.dart;
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';

import 'dashboard.dart';

bool currentOverlay = true;
String username;



List<EmissionData> create_chart_data (DocumentSnapshot document){
  var data = [document["food"],document["transport"], document["product"]];
  var dates = new Map();
  List<EmissionData> temp = new List<EmissionData>();
  for (var i = 0; i < data.length; i++){
    for (var j = 0; j < data[i].length; j++){
      if (dates.containsKey(data[i][j]["date"].seconds * 1000)) {
        dates[data[i][j]["date"].seconds * 1000] += data[i][j]["emission"];
      } else {
        dates[data[i][j]["date"].seconds * 1000] = data[i][j]["emission"];
      }
     }
   }
   dates.forEach((key, value) {
     temp.add(new EmissionData(
         DateTime.fromMillisecondsSinceEpoch(key),
         value
     ));
   });
  return temp;
}


addProduct(QuerySnapshot document,String type, List<int> items, bool plastic, bool secondHand ) {
  print(document);
  var value = 0;
  DateTime now = new DateTime.now();
  DateTime date = new DateTime(now.year, now.month, now.day);


  Firestore.instance.collection('products').getDocuments().then(
          (QuerySnapshot snapshot) {
        for (var i in items) {
          value += snapshot.documents[i]["value"];
        }

        //
        print(document.documents);
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
          Firestore.instance.collection("users").document(username).collection(type).document().setData({
            "date": FieldValue.serverTimestamp(),
            "emission": value,
          });
        }
      }
  );
}


addNewProduct(List<int> items, bool plastic, bool secondHand ){

  CollectionReference product = Firestore.instance.collection('products');

  // Future<void> addUser() {
  //     // Call the user's CollectionReference to add a new user
  //     return users
  //         .add({
  //       'full_name': fullName, // John Doe
  //       'company': company, // Stokes and Sons
  //       'age': age // 42
  //     })
  //         .then((value) => print("User Added"))
  //         .catchError((error) => print("Failed to add user: $error"));
  //   }

}
