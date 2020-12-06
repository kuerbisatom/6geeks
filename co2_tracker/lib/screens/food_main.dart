import 'package:co2_tracker/screens/dashboard.dart';
import 'package:co2_tracker/screens/home_screen.dart';
import 'package:flutter/material.dart';


class FoodMain extends StatefulWidget {
  _FoodMainState createState() => new _FoodMainState();
}

class _FoodMainState extends State<FoodMain> {
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      body: Center(
        child: Column(
        children: [Icon(Icons.local_dining_outlined),
                  Text('Food'),
                  Text('Search Item'),
                  TextField(
                    decoration: InputDecoration(
                    border: InputBorder.none,
                    hintText: 'Insert item name...'
                    ),),
                  Text('Scan Item'),
                  ElevatedButton(
                    onPressed: () {
                      // TODO: Navigate to Item scanning mock
                    },
                    child: Icon(Icons.qr_code_scanner),
                  ),
                  Text('Itens Selected'),
                  Container(), //TODO: make added itens go here
                  ElevatedButton(
                    onPressed: () {
                      Navigator.push(context, MaterialPageRoute(builder: (context) => MyHomePage()));
                      // TODO Navigate home screen and add itens to emissions
                    },
                    child: Text('Add All'),
                  )
        ],

      ))
      );
  }
}
