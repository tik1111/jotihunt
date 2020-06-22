import 'package:flutter/material.dart';
import 'package:jotihunt/services/authservice.dart';
import 'package:jotihunt/services/markerHandler.dart';
import 'package:jotihunt/services/locationservice.dart';


class SettingsScreen extends StatelessWidget {
  final AuthenticationService _auth = new AuthenticationService();
  final MarkerHandler _write = new MarkerHandler();
  final LocationService _locationService =  new LocationService();
  
  

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
                    _write.createLocationRecord();
                  }, 
                  icon: Icon(Icons.restaurant), 
                  label: Text('Write database')
                  )
            ],
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 0),
              child: 
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                FlatButton.icon(
                  onPressed: (){
                     print(_locationService.getGeoLocation());
                  }, 
                  icon: Icon(Icons.my_location), 
                  label: Text('Get LatLng')
                  )
            ],
            ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 0),
              child: Row(
                
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Container(
                    child: new Image.asset(
                      'assets/car_icon.png',
                      height: 40,
                      width: 40,
                    ),
                  ),
                  Container(
                    child: new Image.asset(
                      'assets/car_icon.png',
                      height: 40,
                      width: 40,
                    ),
                  ),
                  Container(
                    child: new Image.asset(
                      'assets/car_icon.png',
                      height: 40,
                      width: 40,
                    ),
                  ),
                  Container(
                    child: new Image.asset(
                      'assets/car_icon.png',
                      height: 40,
                      width: 40,
                    ),
                  ),
                  
              ],
              ),
              
            ),
            Row(mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Text('hi')
                    ],
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