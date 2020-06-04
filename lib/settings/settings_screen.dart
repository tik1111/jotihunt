import 'package:flutter/material.dart';


class settingsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Instellingen"),
      ),
      body: Center(
        child: Text('Settings'),
      )
    );
  }
}