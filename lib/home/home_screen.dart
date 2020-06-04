import 'package:flutter/material.dart';
import 'package:jotihunt/settings/settings_screen.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Jotihunt'),
        actions: <Widget>[

          IconButton(
            icon: Icon(Icons.settings),
            tooltip: 'Settings',
            onPressed: (){
              Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => settingsScreen()));
            })
        ],
      ),
      body: Text('Homescreen'),
    );
  }





void handleClick(String value) {
  switch (value) {
    case 'Instellingen':
      break;
    case 'Uitloggen':
      break;
  }
}

}