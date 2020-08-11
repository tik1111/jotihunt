import 'package:flutter/material.dart';
import 'package:jotihunt/screens/settings_screen/vehicle_select.dart';
import 'package:jotihunt/services/authservice.dart';
import 'package:jotihunt/services/databaseHandler.dart';

  

class SettingsScreen extends StatefulWidget {
  @override
  _SettingsScreenState createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  final AuthenticationService _auth = new AuthenticationService();

  final DatabaseHandler _databaseHandler = new DatabaseHandler();
  
  @override
  void initState() { 
    super.initState();
    _databaseHandler.checkUserProfilePresenceOrCreate();
  }

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
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 0),
              child:
                RaisedButton(
                  child: Text('Select car'),
                  onPressed: (){ 
                    showDialog(
                      context: context,
                      builder: (_)=> VehicleSelectDialog(),
                    );
                  },
                  )
                  //VehicleRadioSelect()
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 0),
              child: 
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
            ),
            ),
          ],
        ),
      ),
    );
    
  }
}
