import 'package:flutter/material.dart';
import 'package:jotihunt/googleMaps/jotiMap_copy.dart';
import 'package:jotihunt/googleMaps/jotiMap.dart';
import 'package:jotihunt/screens/settings_screen.dart';



class HomeScreen extends StatefulWidget {

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {

  int _selectedIndex = 0;
  //static const TextStyle optionStyle =
  //TextStyle(fontSize: 30, fontWeight: FontWeight.bold);
  static List<Widget> _widgetOptions = <Widget>[
    JotiMap_test(),
    JotiMap(),
    SettingsScreen(),
    SettingsScreen(),
  ];


  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Jotihunt'),
      ),
      body: Center(
        
        child: _widgetOptions.elementAt(_selectedIndex),
      ),
      bottomNavigationBar: BottomNavigationBar(
          type: BottomNavigationBarType.fixed,
          items: const <BottomNavigationBarItem>[
           BottomNavigationBarItem(
               icon: Icon(Icons.map,),
                title: Text('Map')
              ),
            BottomNavigationBarItem(
              icon: Icon(Icons.create),
              title: Text('Opdrachten'),
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.score),
              title: Text('Score'),
            ),
           BottomNavigationBarItem(
             icon: Icon(Icons.settings),
             title: Text('Instellingen'),
           ),
          ],
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.blue,
        onTap: _onItemTapped,
      ),
    );
  }

}