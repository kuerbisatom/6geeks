import 'package:flutter/material.dart';

class TrackingList extends StatefulWidget {
  _TrackingListState createState() => _TrackingListState();
}

class _TrackingListState extends State<TrackingList>{
  @override
  Widget build(BuildContext context) {
    final titles = ['Food', 'Shopping', 'Transportation'];

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
                    onPressed: null
                ),
              ),
            );
          },
        )
    );
  }
}
