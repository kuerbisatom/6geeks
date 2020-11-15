import 'package:flutter/material.dart';

class TipsList extends StatefulWidget {
  _TipsListState createState() => _TipsListState();
}

class _TipsListState extends State<TipsList>{
  @override
  Widget build(BuildContext context) {
    final titles = ['Tip', 'Tip', 'Tip', 'Tip', 'Tip', 'Tip', 'Tip', 'Tip', 'Tip', 'Tip', 'Tip', 'Tip', 'Tip', 'Tip', 'Tip', 'Tip', 'Tip', 'Tip', 'Tip', 'Tip'];

    // final icons = [Icons.lightbulb_outline,Icons.lightbulb_outline,Icons.lightbulb_outline];
    return Container(
        child: ListView.builder(
          itemCount: titles.length,
          itemBuilder: (context, index) {
            return Card( //                           <-- Card widget
              child: ListTile(
                leading:
                IconButton(
                    icon: Icon(Icons.lightbulb_outline),
                    onPressed: null
                ),
                title: Text(titles[index] + ' $index'),
              ),
            );
          },
        )
    );
  }
}