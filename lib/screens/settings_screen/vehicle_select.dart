import 'dart:developer';

import 'package:flutter/material.dart';

class VehicleSelectDialog extends StatefulWidget {
  const VehicleSelectDialog({Key key}) : super(key: key);

  @override
  _VehicleSelectDialogState createState() => _VehicleSelectDialogState();
}
String currentVehicleSelected = 'Skateboard';
class _VehicleSelectDialogState extends State<VehicleSelectDialog> {
  

  String currectVehicle(){
    switch(currentVehicleSelected){
      case 'Car':{
        log('Car');
        return 'assets/vehicles/gifs/car.gif';
      }
      break;
      case 'Bike':{
        log('Bike');
        return 'assets/vehicles/gifs/bike.gif';
      }
      break;
      case 'Skateboard':{
        log('Skateboard');
        return 'assets/vehicles/gifs/skateboard.gif';
      }
      break;

    }
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      elevation: 50,
      backgroundColor: Colors.white,
      child: Container(
        
        child: Column(crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            ClipRRect(
              borderRadius: BorderRadius.only(topLeft: Radius.circular(14), topRight: Radius.circular(14)),
              child: Image.asset(
                currectVehicle(),
                fit: BoxFit.fill, 
                ), 
            ),
            Padding(padding: EdgeInsets.fromLTRB(10, 20, 10, 5),
            ),
            Container(
              color: Colors.white,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  RaisedButton(
                    child: Text('Auto'),
                    onPressed: (){
                      setState(() {
                        currentVehicleSelected = 'Car';
                      });
                        
                    },
                    color: Color(0xFFCE796B),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
                    textColor: Colors.grey[200],
                    elevation: 4,
                  ),
                 
                  SizedBox(width: 15,),
                  RaisedButton(
                    child: Text('Fiets'),
                    onPressed: (){
                      setState(() {
                        currentVehicleSelected = 'Bike';
                      });
                        
                    },
                    color: Color(0xFFC18C5D),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
                    textColor: Colors.grey[200],
                    elevation: 4,
                  ),
                ],
              ),
            ),
            Container(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  SizedBox(width: 5,),
                  RaisedButton(
                    child: Text('Skateboard'),
                    onPressed: (){
                      setState(() {
                        currentVehicleSelected = 'Skateboard';
                      });
                        
                    },
                    color: Color(0xFF495867),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
                    textColor: Colors.grey[200],
                    elevation: 4,
                  ),
                ],
              ),
            )
          ],
        ),
      ),
      );
  }
}

Widget flatButtonForVehicleDialog(String name,String image, int color){
  return RaisedButton(
    child: Text(name),
    onPressed: (){

    },
    color: Color(color),
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
    textColor: Colors.grey[200],
    elevation: 4,
  );
}