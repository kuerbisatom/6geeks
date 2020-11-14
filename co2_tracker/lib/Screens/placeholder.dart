import 'package:flutter/material.dart';

class PlaceholderWidget extends StatelessWidget{
  final String text;


  PlaceholderWidget(this.text);

  Widget build(BuildContext context) {
    return Center(
      child: Text(text),
    );
  }
}

class DashboardWidget extends StatefulWidget {
  @override
  _DashboardWidgetState createState() => _DashboardWidgetState();
}

class _DashboardWidgetState extends State<DashboardWidget>{
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Text("Row1"),
              Text("Row2"),
            ],
          ),
          Text("Column2"),
        ],
      )
    );
  }
}

class TrackingList extends StatefulWidget {
  _TrackingListState createState() => _TrackingListState();
}

class _TrackingListState extends State<TrackingList>{
  @override
  Widget build(BuildContext context) {
    final titles = ['Food', 'Shopping', 'Transportation'];

    final icons = [Icons.local_dining_outlined,Icons.local_grocery_store_outlined,Icons.commute_outlined];
    return Container(
      child: ListView.builder(
      itemCount: titles.length,
      itemBuilder: (context, index) {
        return Card( //                           <-- Card widget
          child: ListTile(
            leading: Icon(icons[index]),
            title: Text(titles[index]),
            trailing: Icon(Icons.keyboard_arrow_right),
          ),
        );
      },
    )
    );
  }
}





