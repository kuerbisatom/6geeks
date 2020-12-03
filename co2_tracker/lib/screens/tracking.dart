import 'package:co2_tracker/screens/placeholder.dart';
import 'package:flutter/material.dart';
import 'package:co2_tracker/screens/food_main.dart';

class TrackingList extends StatefulWidget {
  _TrackingListState createState() => _TrackingListState();
}

class _TrackingListState extends State<TrackingList>{
  @override
  Widget build(BuildContext context) {
    final titles = ['Food', 'Shopping', 'Transportation'];
    List<Widget> _children= [
      FoodMain(),
      PlaceholderWidget('Shopping'),
      PlaceholderWidget('Transportation')
    ];

    final icons = [Icons.local_dining_outlined,
      Icons.local_grocery_store_outlined,
      Icons.commute_outlined];
    return Container(
        child: ListView.builder(
          itemCount: titles.length,
          itemBuilder: (context, index) {
            return Card( //                           <-- Card widget
              child: ListTile(
                leading: Icon(icons[index]),
                title: Text(titles[index]),
                trailing: IconButton(
                    icon: Icon(Icons.keyboard_arrow_right),
                    onPressed: () //TODO: make navigation to tracking pages work
                    {
                    Navigator.push(context,
                    MaterialPageRoute(builder: (context) => _children[index])); }
                ),
              ),
            );
          },
        )
    );
  }
}
