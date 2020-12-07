import 'package:flutter/material.dart';

class TipsList extends StatefulWidget {
  _TipsListState createState() => _TipsListState();
}

class _TipsListState extends State<TipsList>{
  @override
  Widget build(BuildContext context) {
    final titles = ['Tip of the day', 'Switch off', 'Drive less', 'LEDs is best', 'Ask a friend', 'Support climate organizations', 'Buy better', 'Wash better', 'Plant a tree', 'Traffic is boring', 'Open the windows', 'Buy groceries in bulk', 'Bottled water no', 'Read online', 'Bring your own container'];
    final titles2 = ['Take a moment to think of all the beautful gifts this planet gives you everyday, think about what you can give back',
      'Switch lights off when you leave the room and unplug your electronic devices when they are not in use',
      'Walk, take public transportation or bike to your destination when possible, becomes healthier and helps the planet',
      'Change incandescent light bulbs to light emitting diodes (LEDs), these lights are cooler',
      'If you only need an item for one ocasion, asking a friend who already owns it to borrow theirs is the most ecofriendly choice, according to source',
      'Support climate action organizations, they need our help',
      'Buy less stuff and buy used or recycled items whenever possible, saves money and saves the world',
      'Wash your clothing in cold water, it is not feel, do not worry',
      'Plant a tree, in your house, in house of your grandparents or simply in a forest near your house ',
      'Use traffic apps like Waze to help avoid getting stuck in traffic jams, saves time and saves the world',
      'Use less air conditioning while you drive, even when the weather is hot, it costs nothing to open the windows',
      'Buy groceries in bulk when possible using your own reusable container',
      'Do not buy bottled water, instead buy a reusable water bottle made of metal or glass ',
      'Read magazines and newspapers online, you even have not to get out of bed',
      'According to source more than 100000 takeout containers end in landfil each year, by bringing your own container you can help reduce this number'];

    List<int> colors = [0xFFFFECB3, 0xFFDCEDC8, 0xFFFFFD54F, 0xFFB2EBF2, 0xFFDCEDC8, 0xFFFFFD54F, 0xFFB2EBF2, 0xFFFFECB3, 0xFFDCEDC8, 0xFFFFFD54F, 0xFFB2EBF2, 0xFFFFECB3, 0xFFFFFD54F, 0xFFB2EBF2, 0xFFDCEDC8];
    final icons = [Icons.wb_sunny_outlined,Icons.lightbulb_outline,Icons.directions_bus_outlined,Icons.lightbulb_outline,Icons.shopping_cart_outlined,Icons.public_sharp,Icons.local_grocery_store_outlined,Icons.waves,Icons.emoji_nature_outlined,Icons.traffic_outlined,Icons.directions_car_outlined,Icons.local_grocery_store_outlined,Icons.waves,Icons.book_outlined,Icons.shopping_bag_outlined];
    return Scaffold(
        body: ListView.builder(
          padding: EdgeInsets.all(15.0),
          itemCount: titles.length,
          itemBuilder: (context, index) {
            return Dismissible( //                           <-- Card widget
              key: new UniqueKey(),
              onDismissed: (direction){
                Scaffold.of(context).showSnackBar(new SnackBar(content: Text("Tip removed")));
              },
             child: Card(
               shape: RoundedRectangleBorder(
                 borderRadius: const BorderRadius.all(Radius.circular(10.0)),
               ),
               color: Color(colors[index]),
              child: ListTile(
                leading: IconButton(
                    icon: Icon(icons[index]),
                    onPressed: null
                ),
                title: Text(
                    titles[index],
                    style: TextStyle(fontFamily: 'Roboto'),),
                subtitle: Text(
                    titles2[index],
                    style: TextStyle(fontFamily: 'Roboto'),
                    textAlign: TextAlign.justify,),
              ),
              ),
            );
          },
        ),
    );
  }
}