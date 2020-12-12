import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:charts_flutter/flutter.dart' as charts;
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:co2_tracker/screens/globals.dart' as globals;
import 'package:rxdart/rxdart.dart';


class DashboardWidget extends StatefulWidget {
  @override
  _DashboardWidgetState createState() => _DashboardWidgetState();
}

class _DashboardWidgetState extends State<DashboardWidget>{

  void initState() {
    super.initState();
    _selections[0] = true;
  }


  static List<charts.Series<EmissionData, DateTime>> _createSampleData(document) {
      // final eatingData = create_bar_data(document[0]);
      // final transportData = create_bar_data(document[1]);
      // final shoppingData = create_bar_data(document[2]);
    final allData = create_chart_data(document);

    // final allData = [
    //   new EmissionData(new DateTime(2017, 9, 19), 20),
    //   new EmissionData(new DateTime(2017, 9, 19), 20),
    //   new EmissionData(new DateTime(2017, 10, 3), 40),
    //   new EmissionData(new DateTime(2017, 10, 10), 75),
    // ];

    return [
      new charts.Series<EmissionData, DateTime>(
        id: 'Food',
// colorFn specifies that the line will be blue.
        colorFn: (_, __) => charts.ColorUtil.fromDartColor(Color(0xFFDCEDC8)),
// areaColorFn specifies that the area skirt will be light blue.
        areaColorFn: (_, __) =>
            charts.ColorUtil.fromDartColor(brighten(Color(0xFFDCEDC8),50)),
        domainFn: (EmissionData emission, _) => emission.time,
        measureFn: (EmissionData emission, _) => emission.emission,
        data: allData,
      ),
    ];
  }

  static List<charts.Series<OrdinalEmission, String>> _createBarData(document) {
    final eatingData = create_bar_data(document[0]);
    final transportData = create_bar_data(document[1]);
    final shoppingData = create_bar_data(document[2]);

    return [
      new charts.Series<OrdinalEmission, String>(
        id: 'Transport',
        colorFn: (_, __) => charts.ColorUtil.fromDartColor(Color(0xFFDCEDC8)),

        domainFn: (OrdinalEmission emission, _) => emission.type,
        measureFn: (OrdinalEmission emission, _) => emission.emission,
        data: transportData,
      ),
      new charts.Series<OrdinalEmission, String>(
        id: 'Grocery',
        colorFn: (_, __) => charts.ColorUtil.fromDartColor(Color(0xFFB2EBF2)),
        domainFn: (OrdinalEmission emission, _) => emission.type,
        measureFn: (OrdinalEmission emission, _) => emission.emission,
        data: shoppingData,
      ),
      new charts.Series<OrdinalEmission, String>(
        id: 'Food',
        colorFn: (_, __) => charts.ColorUtil.fromDartColor(Color(0xFFFFECB3)),
        domainFn: (OrdinalEmission emission, _) => emission.type,
        measureFn: (OrdinalEmission emission, _) => emission.emission,
        data: eatingData,
      ),
    ];
  }

  List<String> days = ["Monday", "Tuesday", "Wednesday", "Thursday", "Friday", "Saturday", "Sunday"];
  List<bool> _selections = List.generate(3, (_) => false);

  List<FaIcon> category = [FaIcon(FontAwesomeIcons.crow,size: 60), FaIcon(FontAwesomeIcons.cat,size: 60,),
    FaIcon(FontAwesomeIcons.dog,size: 60,), FaIcon(FontAwesomeIcons.horse,size: 60,)];
  // crow = 0.5 - 2kg; cat = 3 - 5kg ; dog = 6-40; 1500 hippo; 380-1000
  List<String> animals = ["Crow", "Cat","Dog","Horse"];
  Widget build(BuildContext context) {
    return Container(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Container(
              child: Column(
              children:
              [
                Text("Welcome",style: TextStyle(fontWeight: FontWeight.bold, fontSize: 25)),
                Text(days[DateTime.now().weekday - 1] + " " + DateTime.now().day.toString() + "/" + DateTime.now().month.toString() + "/" + DateTime.now().year.toString()),
              ]),
            ),
            StreamBuilder(
              stream: Firestore.instance.collection("users").document(globals.username).snapshots(),
              builder: (context, snapshot) {
                if (!snapshot.hasData) return CircularProgressIndicator();
                int value = (snapshot.data["baseline"] + snapshot.data["daily"]["emission"]);
                var index = 0;
                if (value < 3){index = 0;}
                else if (value < 6){index = 1;}
                else if (value <50){index = 2;}
                else {index = 3;}
                return Container(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Container(
                          height: 80,
                          width: 80,
                          child: category[index],
                        ),
                        Container(
                            width: 200,
                            child: Column(
                                children: <Widget>[
                                  Text("Your daily CO2-Emission is about as the same weight as a " + animals[index]),
                                  Text(value.toString() + " kg", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 17),)
                                ]
                            )
                        )

                      ],
                      )
                    );
              },

            ),

            Divider(color: Colors.black12),
            Container(
              height: 100,
              child: Column(
                children: [
                  Text("Distribution",style: TextStyle(fontWeight: FontWeight.bold),),
                  Padding(
                    padding: const EdgeInsets.only(left: 5.0,right: 5.0),
                      child: Container(
                          height: 75,
                          child: StreamBuilder(
                              stream: Rx.combineLatest3(
                                  Firestore.instance.collection("users").document(globals.username).collection("food").snapshots(),
                                  Firestore.instance.collection("users").document(globals.username).collection("transport").snapshots(),
                                  Firestore.instance.collection("users").document(globals.username).collection("product").snapshots(),
                                      (value1, value2, value3) =>  [value1.documents,value2.documents,value3.documents]
                              ),
                              builder: (context, snapshot) {
                                if (!snapshot.hasData) return Text("Waiting");
                                return StackedHorizontalBarChart(
                                  _createBarData(snapshot.data),
                                  animate: false,);
                              }
                          )
                      )
                  )
                ]
              )),
            Divider(color: Colors.black12),
            Container(
                height: 300,
                child: Column(
                    children: [
                      Text("Progress",style: TextStyle(fontWeight: FontWeight.bold),),
                      Padding(
                        padding: const EdgeInsets.only(left: 8.0,right: 8.0),
                        child: Container(
                            height: 200,
                            child: StreamBuilder(
                                stream: Rx.combineLatest3(
                                  Firestore.instance.collection("users").document("test").collection("food").snapshots(),
                                  Firestore.instance.collection("users").document("test").collection("transport").snapshots(),
                                  Firestore.instance.collection("users").document("test").collection("product").snapshots(),
                                    (value1, value2, value3) =>  [value1.documents,value2.documents,value3.documents]
                                ),
                                builder: (context, snapshot) {
                                  if (!snapshot.hasData) return Text("Waiting");
                                  return StackedAreaCustomColorLineChart(
                                      _createSampleData(snapshot.data),
                                      animate: false,);
                                }
                              )
                          )
                      ),
                      ToggleButtons(
                        children: [Text("Week"),Text("Month"),Text("Year")],
                        isSelected: _selections,
                        onPressed: (int index) {
                          setState(() {
                            for (int buttonIndex = 0; buttonIndex < _selections.length; buttonIndex++) {
                              if (buttonIndex == index) {
                                _selections[buttonIndex] = true;
                              } else {
                                _selections[buttonIndex] = false;
                              }
                            }
                            switch (index){
                              case 0: globals.days = 7; break;
                              case 1: globals.days = 30; break;
                              case 2: globals.days = 365; break;
                            }
                          });
                        },
                        renderBorder: true,
                        borderRadius: BorderRadius.circular(30),
                      ),
                    ]
              )
            ),
          ],
        )
    );
  }
}



class EmissionData {
  DateTime time;
  int emission;

  EmissionData(this.time, this.emission);
}

class OrdinalEmission {
  final String type;
  final int emission;

  OrdinalEmission(this.type, this.emission);
}

class StackedAreaCustomColorLineChart extends StatelessWidget {
  final List<charts.Series> seriesList;
  final bool animate;

  StackedAreaCustomColorLineChart(this.seriesList, {this.animate});

  @override
  Widget build(BuildContext context) {
    return new charts.TimeSeriesChart(seriesList,
        defaultRenderer:
        new charts.LineRendererConfig(includeArea: true, stacked: true),
        animate: animate,
       //behaviors: [new charts.SeriesLegend()],
        dateTimeFactory: const charts.LocalDateTimeFactory()
    );
  }
}

class StackedHorizontalBarChart extends StatelessWidget {
  final List<charts.Series> seriesList;
  final bool animate;

  StackedHorizontalBarChart(this.seriesList, {this.animate});

  @override
  Widget build(BuildContext context) {
    // For horizontal bar charts, set the [vertical] flag to false.
    return new charts.BarChart(
      seriesList,
      animate: animate,
      vertical: false,
      domainAxis: new charts.OrdinalAxisSpec(renderSpec: new charts.NoneRenderSpec()),
      defaultRenderer: new charts.BarRendererConfig(
        //cornerStrategy: const charts.ConstCornerStrategy(30),
        groupingType: charts.BarGroupingType.stacked,
      ),
      behaviors: [
        new charts.PercentInjector(
            totalType: charts.PercentInjectorTotalType.domain),
        new charts.SeriesLegend(),
      ],
      primaryMeasureAxis: new charts.PercentAxisSpec(),
      barRendererDecorator: new charts.BarLabelDecorator<String>(),
    );
  }
}

Color brighten(Color c, [int percent = 10]) {
  assert(1 <= percent && percent <= 100);
  var p = percent / 100;
  return Color.fromARGB(
      c.alpha,
      c.red + ((255 - c.red) * p).round(),
      c.green + ((255 - c.green) * p).round(),
      c.blue + ((255 - c.blue) * p).round()
  );
}


List<OrdinalEmission> create_bar_data(data) {

  List<OrdinalEmission> temp = [];
  DateTime now = new DateTime.now();
  DateTime date = new DateTime(now.year, now.month, now.day);

  for (var i = 0; i < data.length; i++) {
    DateTime dt = new DateTime.fromMillisecondsSinceEpoch(
        data[i]["date"].seconds * 1000);
    dt = new DateTime(dt.year, dt.month, dt.day);
    if (date == dt) {
      temp.add(
          new OrdinalEmission("1", data[i]["emission"]));
    }
  }
  return temp;
}

List<EmissionData> create_chart_data (document){
  var data = [document[0],document[1], document[2]];
  var dates = new Map();
  DateTime now = new DateTime.now();
  DateTime date;
  switch (globals.days){
    case 7: date = new DateTime(now.year, now.month, now.day-7);break;
    case 30: date = new DateTime(now.year, now.month-1, now.day);break;
    case 365: date = new DateTime(now.year-1, now.month, now.day);break;
  }
  List<EmissionData> temp = new List<EmissionData>();
  for (var i = 0; i < data.length; i++){
    for (var j = 0; j < data[i].length; j++){
      DateTime dt = new DateTime.fromMillisecondsSinceEpoch(
          data[i][j]["date"].seconds * 1000);
      if (dt == null){
          print(data[i][j]);
          dt = new DateTime(now.year,now.month,now.day);
      }
      if (date.isBefore(dt)){
        if (dates.containsKey(data[i][j]["date"].seconds * 1000)) {
          dates[data[i][j]["date"].seconds * 1000] += data[i][j]["emission"];
        } else {
          dates[data[i][j]["date"].seconds * 1000] = data[i][j]["emission"];
        }
      }
    }
  }

  var sorted = dates.keys.toList()..sort();
  for (var elem in sorted) {
    temp.add(new EmissionData(
        DateTime.fromMillisecondsSinceEpoch(elem),
        dates[elem] + globals.baseline,
    ));
  }
  return temp;
}
