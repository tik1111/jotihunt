import 'dart:developer';

import 'package:flutter/material.dart';

class VehicleRadioSelect extends StatefulWidget {
  VehicleRadioSelect({Key key}) : super(key: key);

  @override
  _VehicleRadioSelectState createState() => _VehicleRadioSelectState();
}


enum VehicleOptions { car, bike, skateboard }

String counter = '';
class _VehicleRadioSelectState extends State<VehicleRadioSelect> {

VehicleOptions _character = VehicleOptions.car;


  @override
  Widget build(BuildContext context) {
    
    return Container(
          child: Column(
         mainAxisAlignment: MainAxisAlignment.start,
         children: <Widget>[
           RadioListTile(
             value: 1,
             groupValue: 0,
             title: Text('Car'),
             subtitle: Text('Snelle auto'),
             activeColor: Colors.blue,
             secondary: OutlineButton(
               child: Text('Auto'),
               onPressed: (){
                 log('nog snellere auto');
                 },
              ),
             onChanged: (val){
             log('car');
            },
           )
         ],
      ),
    );  
  }
}