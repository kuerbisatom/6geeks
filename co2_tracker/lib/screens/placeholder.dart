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