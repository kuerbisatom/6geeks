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

class _FoodMainState extends State<FoodMain>{
  @override
  List<int> selectedItems = [];
  String _scanBarcode = 'Unknown';

  void initState() {
    super.initState();
  }

  startBarcodeScanStream() async {
    FlutterBarcodeScanner.getBarcodeStreamReceiver(
        "#ff6666", "Cancel", true, ScanMode.BARCODE)
        .listen((barcode) => print(barcode));
  }

  final List<listItem> items = [
    listItem("apple",1),listItem("beef",2),listItem("margarita",3),listItem("brie cheese",4)];
  Widget build(BuildContext context) {
    return new WillPopScope(
        onWillPop: _requestPop,
        child: Scaffold(
        appBar: AppBar(
          leading: IconButton(
            icon: Icon(Icons.arrow_back),

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
          title: Text("Food"),
          automaticallyImplyLeading: false,
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
                    child: Text("Scan Item",
                        style: TextStyle(fontSize: 24,fontWeight: FontWeight.bold)),
                    margin: EdgeInsets.only(left:20, top:20),),Text('Scan result : $_scanBarcode\n',
                      style: TextStyle(fontSize: 20))],
                ),
                Container(
                  child: ElevatedButton(
                    onPressed: () => startBarcodeScanStream(),
                    child: Icon(Icons.qr_code_scanner,
                      size:60,
                    ),
                  ),
                  width: 90,
                  height: 90,
                  margin: EdgeInsets.all(20),

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
              ],

            )),
        )
    );
  }

  Future <bool> _requestPop() {
    print ("Something");
    globals.currentOverlay = true;
    return new Future.value(true);
  }
}
