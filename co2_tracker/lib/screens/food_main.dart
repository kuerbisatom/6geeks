import 'package:co2_tracker/screens/home_screen.dart';
import 'package:flutter/cupertino.dart';
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
        children: [
                  Container(
                    padding: EdgeInsets.all(30.0),
                    child:  SearchableDropdown.multiple(
                      items: items.map((item) {
                        return new DropdownMenuItem<listItem>(
                            child: Text(item.name), value: item);
                            }).toList(),
                            selectedItems: selectedItems,
                            hint: Padding(
                              padding: const EdgeInsets.all(12.0),
                              child: Text("Select items",
                                style: TextStyle(fontSize: 20),),
                            ),
                            searchHint: "Select items",
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
                  ),
                  Text('Scan Item',
                  style: TextStyle(fontSize: 20),),
                  Container(
                    child: ElevatedButton(
                      onPressed: () {
                        // TODO: Navigate to Item scanning mock
                      },
                      child: Icon(Icons.qr_code_scanner,
                      size:60,
                        ),
                    ),
                    width: 100,
                    height: 100,
                    margin: EdgeInsets.all(20),
                  ),
                  Container(
                      child: ElevatedButton(
                        onPressed: () {
                          Navigator.push(context, MaterialPageRoute(builder: (context) => MyHomePage()));
                          // TODO Navigate home screen and add itens to emissions
                        },
                        child: Text('Add All',
                          style: TextStyle(fontSize: 30),),
                      ),
                    padding: EdgeInsets.all(20),
                    margin: EdgeInsets.only(top:20),
                  ),
        ],

      ))
      );
  }
}
