import 'package:co2_tracker/screens/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:searchable_dropdown/searchable_dropdown.dart';

class FoodMain extends StatefulWidget {
  _FoodMainState createState() => new _FoodMainState();
}
class listItem{
  String name;
  int _value;
  listItem(this.name,this._value);

  @override
  String toString() {
    return this.name;
  }

  int value(){
    return _value;
  }
}
class _FoodMainState extends State<FoodMain> {
  @override
  List<int> selectedItems = [];

  final List<listItem> items = [
    listItem("apple",1),listItem("beef",2),listItem("margarita",3),listItem("brie cheese",4)];
  Widget build(BuildContext context) {
    return new Scaffold(
      body: Center(
        child: Column(
        children: [Icon(Icons.local_dining_outlined),
                  Text('Food'),
                  Text('Search Item'),
                  SearchableDropdown.multiple(
                    items: items.map((item) {
                      return new DropdownMenuItem<listItem>(
                          child: Text(item.name), value: item);
                    }).toList(),
                    selectedItems: selectedItems,
                    hint: Padding(
                      padding: const EdgeInsets.all(12.0),
                      child: Text("Select any"),
                    ),
                    searchHint: "Select any",
                    onChanged: (value) {
                      setState(() {
                        selectedItems = value;
                      });
                    },
                    closeButton: (selectedItems) {
                      return (selectedItems.isNotEmpty
                          ? "Save ${selectedItems.length == 1 ? '"' + items[selectedItems.first].value.toString() + '"' : '(' + selectedItems.length.toString() + ')'}"
                          : "Save without selection");
                    },
                    isExpanded: true,
                  ),

                  Text('Scan Item'),
                  ElevatedButton(
                    onPressed: () {
                      // TODO: Navigate to Item scanning mock
                    },
                    child: Icon(Icons.qr_code_scanner),
                  ),
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
