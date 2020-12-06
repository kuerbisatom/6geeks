import 'package:co2_tracker/screens/food_main.dart';
import 'package:co2_tracker/screens/placeholder.dart';
import 'package:co2_tracker/screens/tips.dart';
import 'package:co2_tracker/screens/tracking.dart';
import 'package:co2_tracker/screens/dashboard.dart';
import 'package:co2_tracker/screens/fab_with_icon.dart';
import 'package:co2_tracker/screens/fab_bottom.dart';
import 'package:co2_tracker/screens/layout.dart';
import 'package:co2_tracker/screens/userprofile.dart';
import 'package:flutter/material.dart';

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _index_tab = 0;
  //int _index_fab = 0;

  void _selectedTab(int index) {
    setState(() {
      _index_tab = index;
    });
  }

  void _selectedFab(int index) {
    setState(() {
      _index_tab = index + 4;
    });
  }

  static List<Widget> _title = [
    Text('Home'),Text('Tips'), Text('Profile'), Text('Community'),Text("Transportation"),Text("Shopping"),Text("Food")
  ];
  static List<Widget> _children= [
    DashboardWidget(),
    TipsList(),
    UserProfile(),
    PlaceholderWidget("Community"),
    PlaceholderWidget("Transportation"),
    PlaceholderWidget("Shopping"),
    FoodMain(),
  ];

  Widget _buildFab(BuildContext context) {
    final icons = [
      Icons.commute_outlined,
      Icons.local_grocery_store_outlined,
      Icons.local_dining_outlined
    ];

    return AnchoredOverlay(
      showOverlay: true,
      overlayBuilder: (context, offset) {
        return CenterAbout(
          position: Offset(offset.dx, offset.dy - icons.length * 35.0),
          child: FabWithIcons(
            icons: icons,
            onIconTapped: _selectedFab,
          ),
        );
      },
      child: FloatingActionButton(
        onPressed: () {},
        //tooltip: 'Increment',
        child: Icon(Icons.add),
        elevation: 2.0,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: _title[_index_tab],
      ),
      body: Center(
        child: _children[_index_tab]
      ),
      bottomNavigationBar: FABBottomAppBar(
        color: Colors.grey,
        selectedColor: Colors.green,
        notchedShape: CircularNotchedRectangle(),
        onTabSelected: _selectedTab,
        items: [
          FABBottomAppBarItem(iconData: Icons.home_outlined, text: 'Home'),
          FABBottomAppBarItem(iconData: Icons.lightbulb_outline, text: 'Tips'),
          FABBottomAppBarItem(iconData: Icons.perm_identity_outlined, text: 'Profile'),
          FABBottomAppBarItem(iconData: Icons.supervised_user_circle_outlined, text: 'Community'),
        ],
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: _buildFab(
          context), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }

}