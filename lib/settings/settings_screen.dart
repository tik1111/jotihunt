import 'package:flutter/material.dart';
import 'package:jotihunt/services/authservice.dart';


class SettingsScreen extends StatelessWidget {
  final AuthenticationService _auth = new AuthenticationService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      body: Container(
        child: Column(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.fromLTRB(0,20,0, 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.fromLTRB(0,0,10,0),
                    child: Container(
                      child: Icon(Icons.settings),
                    ),
                  ),
                  Container(
                    child: Text('Instellingen', style: TextStyle(fontSize: 20),),
                  )
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 0),
              child: Divider(),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                FlatButton.icon(
                    onPressed: (){
                      try{
                        _auth.signOut();
                      }catch(e){
                        print(e);
                      }

                    },
                    icon: Icon(Icons.power_settings_new),
                    label: Text('Uitloggen'))
              ],
            )
          ],
        ),
      ),
    );
    
  }
}