import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:co2_tracker/screens/home_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:searchable_dropdown/searchable_dropdown.dart';
import 'package:co2_tracker/screens/data_saving.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:flutter/services.dart';
import 'package:co2_tracker/screens/globals.dart' as globals;

class FoodMain extends StatefulWidget {
  final int index;
    FoodMain({Key key, @required this.index}) : super(key: key);
  State<FoodMain> createState() => _FoodMainState();
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
  String _scanBarcode = 'Unknown';
  TextEditingController _controller1;
  TextEditingController _controller2;

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


  startBarcodeScanStream() async {
    FlutterBarcodeScanner.getBarcodeStreamReceiver(
        "#ff6666", "Cancel", true, ScanMode.BARCODE)
        .listen((barcode) => print(barcode));
  }

  List<listItem> items;

  Widget build(BuildContext context) {
    return new WillPopScope(
        onWillPop: _requestPop,
        child: Scaffold(
          resizeToAvoidBottomInset: false,
          appBar: AppBar(
            leading: IconButton(
              icon: Icon(Icons.arrow_back),

              onPressed: () =>
              {
                globals.currentOverlay = true,
                Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(builder: (context) => MyHomePage()),
                      (Route<dynamic> route) => false,
                ),
              },
            ),
            centerTitle: true,
            title: Text("Food"),
            automaticallyImplyLeading: false,
          ),
          body: Center(
              child: Column(
                children: [
                  Row(
                    children: [Container(
                      child: Text("Search Item",
                          style: TextStyle(
                              fontSize: 24, fontWeight: FontWeight.bold)),
                      margin: EdgeInsets.only(left: 20, top: 20),)
                    ],
                  ),
                  Container(
                    padding: EdgeInsets.only(left: 20, right: 20),
                    child: StreamBuilder(
                      stream: Firestore.instance.collection("food").snapshots(),
                      builder: (context, snapshot) {
                        if (!snapshot.hasData) return CircularProgressIndicator();
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
                    ),
                  ),
                  Container(
                      child: Column(
                        children: [
                          Text("Your Food is not in the List?"),
                          OutlineButton(
                              onPressed: () {
                                var product;
                                var emission;
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
                                              labelText: 'Food',
                                            ),
                                            controller: _controller1,
                                            onSubmitted: (String value){
                                              product = value;
                                            },
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
                                          Firestore.instance.collection("food").document(_controller1.text).setData(
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
                    children: [
                      Container(
                        child: Text("Scan Item",
                            style: TextStyle(
                                fontSize: 24, fontWeight: FontWeight.bold)),
                        margin: EdgeInsets.only(left: 20, top: 20),),
                      Text('Scan result : $_scanBarcode\n',
                          style: TextStyle(fontSize: 20))
                    ],
                  ),
                  Container(
                    child: ElevatedButton(
                      onPressed: () => startBarcodeScanStream(),
                      child: Icon(Icons.qr_code_scanner,
                        size: 60,
                      ),
                    ),
                    width: 90,
                    height: 90,
                    margin: EdgeInsets.all(20),

                  ),
                  new Container(
                    margin: EdgeInsets.only(top: 20.0),
                    child: StreamBuilder(
                      stream: Firestore.instance.collection("users").document(globals.username).collection("food").snapshots(),
                      builder: (context, snapshot){
                        if (!snapshot.hasData) return CircularProgressIndicator();
                       return  FlatButton(
                         height: 40,
                         child: Text('Add All',
                             textScaleFactor: 1.4,
                             style: TextStyle(color: Colors.white)),
                         padding: EdgeInsets.only(
                             top: 13.0, bottom: 13, right: 40, left: 40),
                         color: Color(0xFF66BB64),
                         onPressed: () {
                           globals.addFood(snapshot.data, selectedItems);
                           globals.currentOverlay = true;
                           Navigator.pushAndRemoveUntil(
                             context,
                             MaterialPageRoute(builder: (context) => MyHomePage()),
                                 (Route <dynamic> route) => false,
                           );
                         },
                         shape: RoundedRectangleBorder(
                             borderRadius: const BorderRadius.all(
                                 Radius.circular(25.0))
                         ),
                       );
                      }
                    ),

                  ),
                ],

              )),
        )
    );
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

