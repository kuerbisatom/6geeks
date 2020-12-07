import 'package:co2_tracker/screens/data_saving.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:charts_flutter/flutter.dart' as charts;
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:path_provider/path_provider.dart';
import 'dart:io';
import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

class DashboardWidget extends StatefulWidget {
  @override
  _DashboardWidgetState createState() => _DashboardWidgetState();
}

class _DashboardWidgetState extends State<DashboardWidget>{

  void initState() {
    super.initState();
    getApplicationDocumentsDirectory().then((Directory directory) {
      dir = directory;
      transportFile = new File(dir.path + '/' + t_filename);
      if (fileExists(transportFile)) this.setState(() {
        transportContent = jsonDecode(transportFile.readAsStringSync()).toString();
      });
      shoppingFile = new File(dir.path + '/' + s_filename);
      if (fileExists(shoppingFile)) this.setState(() {
        shoppingContent = jsonDecode(shoppingFile.readAsStringSync()).toString();
      });
      eatingFile = new File(dir.path + '/' + e_filename);
      if (fileExists(eatingFile)) this.setState(() {
        eatingContent = jsonDecode(eatingFile.readAsStringSync()).toString();
      });
    });
  }


  static List<charts.Series<EmissionData, DateTime>> _createSampleData() {
    List<EmissionData> transportData = getListTransportData();/*[
      new EmissionData(new DateTime(2017, 9, 19), 5),
      new EmissionData(new DateTime(2017, 9, 26), 25),
      new EmissionData(new DateTime(2017, 10, 3), 100),
      new EmissionData(new DateTime(2017, 10, 10), 75),
    ];*/

    List<EmissionData> shoppingData = getListShoppingData();/*[
      new EmissionData(new DateTime(2017, 9, 19), 5),
      new EmissionData(new DateTime(2017, 9, 26), 25),
      new EmissionData(new DateTime(2017, 10, 3), 100),
      new EmissionData(new DateTime(2017, 10, 10), 75),
    ];*/

    List<EmissionData> eatingData = getListEatingData();/*[
      new EmissionData(new DateTime(2017, 9, 19), 5),
      new EmissionData(new DateTime(2017, 9, 26), 25),
      new EmissionData(new DateTime(2017, 10, 3), 100),
      new EmissionData(new DateTime(2017, 10, 10), 75),
    ];*/

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
        data: transportData,
      ),
      new charts.Series<EmissionData, DateTime>(
        id: 'Grocery',
        // colorFn specifies that the line will be red.
        colorFn: (_, __) => charts.ColorUtil.fromDartColor(Color(0xFFB2EBF2)),
        // areaColorFn specifies that the area skirt will be light red.
        areaColorFn: (_, __) => charts.ColorUtil.fromDartColor(brighten(Color(0xFFB2EBF2),50)),
        domainFn: (EmissionData emission, _) => emission.time,
        measureFn: (EmissionData emission, _) => emission.emission,
        data: shoppingData,
      ),
      new charts.Series<EmissionData, DateTime>(
        id: 'Transport',
        // colorFn specifies that the line will be green.
        colorFn: (_, __) => charts.ColorUtil.fromDartColor(Color(0xFFFFECB3)),
        // areaColorFn specifies that the area skirt will be light green.
        areaColorFn: (_, __) =>
            charts.ColorUtil.fromDartColor(brighten(Color(0xFFFFECB3),50)),
        domainFn: (EmissionData emission, _) => emission.time,
        measureFn: (EmissionData emission, _) => emission.emission,
        data: eatingData,
      ),
    ];
  }
  /// Create series list with multiple series
  static List<charts.Series<OrdinalSales, String>> _createSampleData_Stacked() {
    final transportOrdinalData = [
      new OrdinalSales('2017', getTotalTransportValue()),
    ];

    final shoppingOrdinalData = [
      new OrdinalSales('2017', getTotalShoppingValue()),
    ];

    final eatingOrdinalData = [
      new OrdinalSales('2017', getTotalEatingValue()),
    ];

    return [
      new charts.Series<OrdinalSales, String>(
        id: 'Food',
        colorFn: (_, __) => charts.ColorUtil.fromDartColor(Color(0xFFDCEDC8)),

        domainFn: (OrdinalSales emission, _) => emission.year,
        measureFn: (OrdinalSales emission, _) => emission.emission,
        data: transportOrdinalData,
      ),
      new charts.Series<OrdinalSales, String>(
        id: 'Grocery',
        colorFn: (_, __) => charts.ColorUtil.fromDartColor(Color(0xFFB2EBF2)),
        domainFn: (OrdinalSales emission, _) => emission.year,
        measureFn: (OrdinalSales emission, _) => emission.emission,
        data: shoppingOrdinalData,
      ),
      new charts.Series<OrdinalSales, String>(
        id: 'Transport',
        colorFn: (_, __) => charts.ColorUtil.fromDartColor(Color(0xFFFFECB3)),
        domainFn: (OrdinalSales emission, _) => emission.year,
        measureFn: (OrdinalSales emission, _) => emission.emission,
        data: eatingOrdinalData,
      ),
    ];
  }
  List<String> days = ["Monday", "Tuesday", "Wednesday", "Thursday", "Friday", "Saturday", "Sunday"];
  List<bool> _selections = List.generate(3, (_) => false);

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
            Container(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Container(
                    height: 100,
                    width: 100,

                    child: FaIcon(FontAwesomeIcons.cat,size: 80,),
                  ),
                  Container(
                    width: 200,
                    child: Column(
                        children: <Widget>[
                          Text("Your daily CO2-Emission is about as the same weight as a cat:"),
                          Text("5kg", style: TextStyle(fontWeight: FontWeight.bold),)
                        ] 
                  )
                  )
                ],

              )
            ),
            Divider(color: Colors.black12),
            Container(
              height: 100,
              child: Column(
                children: [
                  Text("Distribution",style: TextStyle(fontWeight: FontWeight.bold),),
                  Padding(
                    padding: const EdgeInsets.only(left: 5.0,right: 5.0),
                      child: Container(height: 75,child: StackedHorizontalBarChart(
                          _createSampleData_Stacked(),
                          animate: false,
                      )
                  )
                ),
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
                        child: Container(height: 200,child: StackedAreaCustomColorLineChart(_createSampleData(), animate: false,))
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

  EmissionData(String dt, String co2) {
    time = DateTime.parse(dt);
    emission = int.tryParse(co2);

    print('$time, $emission');
  }
  void settime(DateTime newtime) { this.time=newtime; }
  void setemission(int newemission) { this.emission=newemission; }

  DateTime gettime() { return this.time; }
  int getemission() { return this.emission; }
}

class OrdinalSales {
  final String year;
  final int emission;

  OrdinalSales(this.year, this.emission);
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
