import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:co2_tracker/screens/home_screen.dart';
import 'package:co2_tracker/screens/survey.dart';
import 'package:co2_tracker/screens/userprofile.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:co2_tracker/screens/globals.dart' as globals;
import 'package:shared_preferences/shared_preferences.dart';

class CreateUserDialog extends StatefulWidget {
  @override
  CreateUserDialogState createState() => new CreateUserDialogState();
}

class CreateUserDialogState extends State<CreateUserDialog> {
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        leading: IconButton(
          icon: Icon(Icons.clear),

          onPressed: () =>
          {
            globals.currentOverlay = true,
            Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(builder: (context) => MyHomePage()),
                  (Route<dynamic> route) => false,
            ),
          },
        ),
        centerTitle: true,
        title: const Text('Create new user'),
      ),
      body: MyCustomForm(),
    );
  }
}

class MyCustomForm extends StatefulWidget {
  @override
  MyCustomFormState createState() {
    return MyCustomFormState();
  }
}

// Create a corresponding State class.
// This class holds data related to the form.
class MyCustomFormState extends State<MyCustomForm> {
  // Create a global key that uniquely identifies the Form widget
  // and allows validation of the form.
  //
  // Note: This is a GlobalKey<FormState>,
  // not a GlobalKey<MyCustomFormState>.
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _controller1 = TextEditingController();
  final TextEditingController _controller2 = TextEditingController();
  final TextEditingController _controller3 = TextEditingController();


  @override
  Widget build(BuildContext context) {
    // Build a Form widget using the _formKey created above.
    return  Form(
      key: _formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Container(
            margin: EdgeInsets.only(left:10, top: 20, right: 10, bottom: 10),
            child: TextFormField(
              controller: _controller1,
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'Name',
              ),
              validator: (value) {
                if (value.isEmpty) {
                  return "Please enter your name";
                }
                return null;
              },
            ),),
          Container(
            margin: EdgeInsets.all(10),
            child: TextFormField(
              controller: _controller2,
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'Age',
              ),
              inputFormatters: [FilteringTextInputFormatter.digitsOnly],
              keyboardType: TextInputType.number,
              validator: (value) {
                if (value.isEmpty) {
                  return "Please enter your age";
                }
                return null;
              },
            ),),
          Container(
            margin: EdgeInsets.all(10),
            child: TextFormField(
              controller: _controller3,
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'City',
              ),
              validator: (value) {
                if (value.isEmpty) {
                  return "Please enter your city";
                }
                return null;
              },
            ),),

          Padding(
            padding: const EdgeInsets.symmetric(vertical: 16.0),
            child: Center(
              child: ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState.validate()) {
                    var user = _controller1.text;
                    int age = int.parse(_controller2.text);
                    var city = _controller3.text;
                    _controller1.clear();
                    _controller2.clear();
                    _controller3.clear();
                    Scaffold.of(context)
                        .showSnackBar(SnackBar(content: Text('New user $user created')));
                    globals.username = user;
                    _setUser(user);
                    globals.baseline = 0;
                    DateTime now = DateTime.now();
                    DateTime dt = DateTime(now.year,now.month,now.day);
                    Map temp(){
                      return {
                        "day" : dt,
                        "emission" : 0
                      };
                    }
                    Firestore.instance.collection("users").document(user).setData(
                        {
                          "age": age,
                          "name": user,
                          "city": city,
                          "daily": temp(),
                          "baseline": 0,
                        }
                    );
                    var coll = ["food","product","transport"];
                    for (var i in coll){
                      Firestore.instance.collection("users").document(globals.username).collection(i).document().setData({
                        "date": DateTime(now.year,now.month,now.day-1),
                        "emission": 0,
                      });
                    }
                    Navigator.pushAndRemoveUntil(
                      context,
                      MaterialPageRoute(builder: (context) => Intro()),
                          (Route<dynamic> route) => false,);
                  }

                },
                child: Text('Create'),
              ),
            ),),
        ],
      ),
    );

  }
}
_setUser(user) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  await prefs.setString('username', user);
}

class AddFoodDialog extends StatefulWidget {
  @override
  AddFoodDialogState createState() => new AddFoodDialogState();
}

class AddFoodDialogState extends State<AddFoodDialog> {
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        centerTitle: true,
        title: const Text('Add new Food'),
      ),
      body: FoodForm(),
    );
  }
}

class FoodForm extends StatefulWidget {
  @override
  FoodFormSate createState() {
    return FoodFormSate();
  }
}

// Create a corresponding State class.
// This class holds data related to the form.
class FoodFormSate extends State<FoodForm> {
  // Create a global key that uniquely identifies the Form widget
  // and allows validation of the form.
  //
  // Note: This is a GlobalKey<FormState>,
  // not a GlobalKey<MyCustomFormState>.
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _controller1 = TextEditingController();
  final TextEditingController _controller2 = TextEditingController();


  @override
  Widget build(BuildContext context) {
    // Build a Form widget using the _formKey created above.
    return  Form(
      key: _formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Container(
            margin: EdgeInsets.only(left:10, top: 20, right: 10, bottom: 10),
            child: TextFormField(
            decoration: InputDecoration(
              border: OutlineInputBorder(),
              labelText: 'Food',
            ),
            controller: _controller1,
            validator: (value) {
              if (value.isEmpty) {
                return "Please enter your item";
              }
              return null;
            },
          ),),
          Container(
            margin: EdgeInsets.all(10),
            child: TextFormField(
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'kg',
                hintText: 'CO2-Emission',
              ),
              inputFormatters: [FilteringTextInputFormatter.digitsOnly],
              keyboardType: TextInputType.number,
              controller: _controller2,
              validator: (value) {
                if (value.isEmpty) {
                  return "Please enter CO2 emission of the product";
                }
                return null;
              },
            ),),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 16.0),
            child: Center(
              child: ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState.validate()) {
                    Scaffold.of(context)
                        .showSnackBar(SnackBar(content: Text('Item was added')));
                    Firestore.instance.collection("food").document(_controller1.text).setData(
                        {"emission": int.parse(_controller2.text)}
                    );
                    _controller2.clear();
                    _controller1.clear();
                    Navigator.of(context).pop();
                  }},
                child: Text('Add Item'),
              ),
            ),
          ),
        ],
      ),
    );

  }
}

class AddProductDialog extends StatefulWidget {
  @override
  AddProductDialogState createState() => new AddProductDialogState();
}

class AddProductDialogState extends State<AddProductDialog> {
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        centerTitle: true,
        title: const Text('Add new Product'),
      ),
      body: FoodForm(),
    );
  }
}

class ProductForm extends StatefulWidget {
  @override
  ProductFormSate createState() {
    return ProductFormSate();
  }
}

// Create a corresponding State class.
// This class holds data related to the form.
class ProductFormSate extends State<ProductForm> {
  // Create a global key that uniquely identifies the Form widget
  // and allows validation of the form.
  //
  // Note: This is a GlobalKey<FormState>,
  // not a GlobalKey<MyCustomFormState>.
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _controller1 = TextEditingController();
  final TextEditingController _controller2 = TextEditingController();


  @override
  Widget build(BuildContext context) {
    // Build a Form widget using the _formKey created above.
    return  Form(
      key: _formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Container(
            margin: EdgeInsets.only(left:10, top: 20, right: 10, bottom: 10),
            child: TextFormField(
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'Product',
              ),
              controller: _controller1,
              validator: (value) {
                if (value.isEmpty) {
                  return "Please enter your item";
                }
                return null;
              },
            ),),
          Container(
            margin: EdgeInsets.all(10),
            child: TextFormField(
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'kg',
                hintText: 'CO2-Emission',
              ),
              inputFormatters: [FilteringTextInputFormatter.digitsOnly],
              keyboardType: TextInputType.number,
              controller: _controller2,
              validator: (value) {
                if (value.isEmpty) {
                  return "Please enter CO2 emission of the product";
                }
                return null;
              },
            ),),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 16.0),
            child: Center(
              child: ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState.validate()) {
                    Firestore.instance.collection("product").document(_controller1.text).setData(
                        {"emission": int.parse(_controller2.text)}
                    );
                    _controller2.clear();
                    _controller1.clear();
                    Navigator.of(context).pop();
                  }},
                child: Text('Add Item'),
              ),
            ),
          ),
        ],
      ),
    );

  }
}
