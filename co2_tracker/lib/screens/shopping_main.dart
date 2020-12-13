import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:searchable_dropdown/searchable_dropdown.dart';
import 'package:country_list_pick/country_list_pick.dart';
import 'package:co2_tracker/screens/home_screen.dart';
import 'package:co2_tracker/screens/globals.dart' as globals;
import "package:cloud_firestore/cloud_firestore.dart";



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
  TextEditingController _controller1;
  TextEditingController _controller2;

  @override
  List<int> selectedItems = [];
  bool isSwitched = false;
  bool isSwitched2 = false;

  void initState() {
    super.initState();
    _controller1 = TextEditingController();
    _controller2 = TextEditingController();
  }

  void dispose() {
    _controller1.dispose();
    _controller2.dispose();
    super.dispose();
  }

  List<listItem> items;

  @override
  Widget build(BuildContext context) {
    return new WillPopScope(
        onWillPop: _requestPop,
        child: Scaffold(
          resizeToAvoidBottomInset: false,
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
                      child: StreamBuilder(
                          stream: Firestore.instance.collection("products").snapshots(),
                          builder: (context, snapshot) {
                            if (!snapshot.hasData) return const Text('Loading');
                            return SearchableDropdown.multiple(
                              items: product_list(snapshot.data.documents),
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
                            );
                          }
                      )

                  ),
                  Container(
                    child: Column(
                      children: [
                        Text("Your Product is not in the List?"),
                        OutlineButton(
                            onPressed: () {
                              showDialog(
                                context: context,
                                builder: (context) => AlertDialog(
                                  title: Text("Add new Item"),
                                  content: SingleChildScrollView(
                                    child: ListBody(
                                      children: <Widget>[
                                        TextField(
                                          decoration: InputDecoration(
                                            border: OutlineInputBorder(),
                                            labelText: 'Product',
                                          ),
                                          controller: _controller1,
                                        ),
                                        Container(
                                          margin: EdgeInsets.only(top: 10),
                                          child: TextField(
                                          decoration: InputDecoration(
                                            border: OutlineInputBorder(),
                                            labelText: 'kg',
                                            hintText: 'CO2-Emission',
                                          ),
                                          inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                                          keyboardType: TextInputType.number,
                                          controller: _controller2,
                                        ),)
                                      ],
                                    ),
                                  ),
                                  actions: <Widget>[
                                    TextButton(
                                      child: Text('Cancel'),
                                      onPressed: () {
                                        Navigator.of(context).pop();
                                      },
                                    ),
                                    TextButton(
                                      child: Text('Add'),
                                      onPressed: () {
                                        Firestore.instance.collection("products").document(_controller1.text).setData(
                                            {"emission": int.parse(_controller2.text)}
                                            );
                                        _controller2.clear();
                                        _controller1.clear();
                                        Navigator.of(context).pop();
                                      },
                                    ),
                                  ],),
                              );
                            },
                            child: Text("Add new Item", style: new TextStyle(color: Colors.green),))
                      ],
                    )

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
                        });
                      },
                      activeTrackColor: Colors.lightGreenAccent,
                      activeColor: Colors.green,
                    ),
                  ),
                  new Container(
                      margin: EdgeInsets.only(top: 20.0),
                      child: StreamBuilder(
                          stream: Firestore.instance.collection("users").document(globals.username).collection("product").snapshots(),
                          builder: (context, snapshot) {
                            if (!snapshot.hasData) return const Text('Loading');
                            return FlatButton(
                              height: 40,
                              child: Text('Add All',
                                  textScaleFactor: 1.4,
                                  style: TextStyle(color: Colors.white)),
                              padding: EdgeInsets.only(top: 13.0, bottom: 13, right:40, left:40),
                              color: Color(0xFF66BB64),
                              onPressed: () {
                                globals.addProduct(snapshot.data, selectedItems, isSwitched, isSwitched2);
                                globals.currentOverlay = true;
                                Navigator.pushAndRemoveUntil(
                                  context,
                                  MaterialPageRoute(builder: (context) => MyHomePage()),
                                      (Route <dynamic> route) => false,
                                );
                              },
                              shape: RoundedRectangleBorder(
                                  borderRadius: const BorderRadius.all(Radius.circular(25.0))
                              ),
                            );
                          }
                      )


                  ),
                ]),
          ),
        ));
  }

  Future <bool> _requestPop() {
    globals.currentOverlay = true;
    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(builder: (context) => MyHomePage()),
          (Route<dynamic> route) => false,);
    return new Future.value(true);
  }
}

product_list(List<dynamic> documents) {
  List <DropdownMenuItem> temp = new List<DropdownMenuItem>();
  for (var i = 0; i < documents.length; i++) {
    temp.add(DropdownMenuItem<listItem>(
      child: Text(documents[i].documentID), value: new listItem(documents[i].documentID, i),
    ));
  }
  return temp;
}

