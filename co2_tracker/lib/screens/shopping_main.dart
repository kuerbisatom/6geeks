import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:searchable_dropdown/searchable_dropdown.dart';
import 'package:country_list_pick/country_list_pick.dart';
import 'package:co2_tracker/screens/home_screen.dart';
import 'package:co2_tracker/screens/globals.dart' as globals;


class ShoppingMain extends StatefulWidget {
  final int index;
    ShoppingMain({Key key, @required this.index}) : super(key: key);
  State<ShoppingMain> createState() => _ShoppingMainState();
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

class _ShoppingMainState extends State<ShoppingMain>{
  @override
  List<int> selectedItems = [];
  bool isSwitched = false;
  bool isSwitched2 = false;

  void initState() {
    super.initState();
  }

  final List<listItem> items = [
    listItem("dress",1),listItem("headphones",2),listItem("candle",3),listItem("notebook",4),listItem("dress",5),
  listItem("notebook",5),
  listItem("notebook",6),
    listItem("notebook",7),
    listItem("notebook",8),
    listItem("notebook",9),
    listItem("notebook",10),
    listItem("notebook",11),
    listItem("notebook",12),
    listItem("notebook",13),
    listItem("notebook",14),
    listItem("notebook",15),



  ];

 @override
  Widget build(BuildContext context) {
     return new WillPopScope(
          onWillPop: _requestPop,
          child: Scaffold(
              appBar: AppBar(
                leading: IconButton(
                  icon: Icon(Icons.arrow_back,),
                  onPressed: () => {
                    globals.currentOverlay = true,
                    Navigator.pushAndRemoveUntil(
                      context,
                      MaterialPageRoute(builder: (context) => MyHomePage()),
                          (Route<dynamic> route) => false,
                    ),
                  },
                ),
                centerTitle: true,
                title: Text("Shopping"),
                backgroundColor: Colors.green ,
              ),
              body: Center(
                 child: Column(
                  children: [
                    Row(
                      children: [Container(
                        child: Text("Search Item",
                            style: TextStyle(fontSize: 24,fontWeight: FontWeight.bold)),
                        margin: EdgeInsets.only(left:20, top:20),)],
                    ),
                    Container(
                      padding: EdgeInsets.only(left:20, right:20),
                      child:  SearchableDropdown.multiple(
                        items: items.map((item) {
                          return new DropdownMenuItem<listItem>(
                              child: Text(item.name), value: item);
                        }).toList(),
                        selectedItems: selectedItems,
                        hint: Padding(
                          padding: const EdgeInsets.all(12.0),
                          child: Text("Insert item name...",
                            style: TextStyle(fontSize: 20),),
                        ),
                        searchHint: "Insert item name...",
                        onChanged: (value) {
                          setState(() {
                            selectedItems = value;
                          });
                        },
                        closeButton: (selectedItems) {
                          return (selectedItems.isNotEmpty
                              ? 'Save (' + selectedItems.length.toString() + ')'
                              : "Save without selection");
                        },
                        isExpanded: true,
                      ),
                    ),
                    Row(
                      children: [Container(
                        child: Text("Made In",
                            style: TextStyle(fontSize: 24,fontWeight: FontWeight.bold)),
                        margin: EdgeInsets.only(left:20, top:20))]
                    ),
                    Container(
                      child: CountryListPick(
                        appBar: AppBar(
                          title: Text('Choose country'),
                          backgroundColor: Colors.green,
                        ),
                        initialSelection: '+351',
                        onChanged: (CountryCode code) {
                          print(code.name);
                          print(code.code);
                          print(code.dialCode);
                          print(code.flagUri);
                        },
                      ),
                    ),
                   Row(
                      children: [Container(
                        child: Text("Plastic Packing",
                            style: TextStyle(fontSize: 24,fontWeight: FontWeight.bold)),
                        margin: EdgeInsets.only(left:20, top:20))]
                    ),
                    Container(
                      child: Switch(
                          value: isSwitched,
                          onChanged: (value){
                            setState(() {
                              isSwitched=value;
                              print(isSwitched);
                            });
                          },
                          activeTrackColor: Colors.lightGreenAccent,
                          activeColor: Colors.green,
                        ),
                    ),
                  Row(
                      children: [Container(
                        child: Text("Second Hand?",
                            style: TextStyle(fontSize: 24,fontWeight: FontWeight.bold)),
                        margin: EdgeInsets.only(left:20, top:20))]
                    ),
                    Container(
                      child: Switch(
                          value: isSwitched2,
                          onChanged: (value){
                            setState(() {
                              isSwitched2=value;
                              print(isSwitched2);
                            });
                          },
                          activeTrackColor: Colors.lightGreenAccent,
                          activeColor: Colors.green,
                      ),
                    ),
                  new Container(
                      margin: EdgeInsets.only(top: 20.0),
                      child: FlatButton(
                        height: 40,
                        child: Text('Add All',
                            textScaleFactor: 1.4,
                            style: TextStyle(color: Colors.white)),
                        padding: EdgeInsets.only(top: 13.0, bottom: 13, right:40, left:40),
                        color: Color(0xFF66BB64),
                        onPressed: () {
                          globals.currentOverlay = true;
                          Navigator.pushAndRemoveUntil(
                              context,
                              MaterialPageRoute(builder: (context) => MyHomePage()),
                              (Route <dynamic> route) => false,
                          );
                        },
                        shape: RoundedRectangleBorder(
                            borderRadius: const BorderRadius.all(Radius.circular(25.0))),),),
                  ]),
      ),
    ));
  }

  Future <bool> _requestPop() {
    print("Something");
    globals.currentOverlay = true;
    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(builder: (context) => MyHomePage()),
          (Route<dynamic> route) => false,);
    return new Future.value(true);
  }
}
