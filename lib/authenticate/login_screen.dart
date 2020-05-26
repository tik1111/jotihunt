import 'package:flutter/material.dart';
import 'package:jotihunt/shared/constants.dart';

class LoginWidget extends StatefulWidget {
  @override
  _LoginWidgetState createState() => _LoginWidgetState();
}

class _LoginWidgetState extends State<LoginWidget> {

  final _formKeySignIn = GlobalKey<FormState>();
  
  String email = '';
  String password = '';
  
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Jotihunt'),
      ),
      body: Container(
        padding: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
        child: Column(
          children: <Widget>[
            SizedBox(height: 15,),
            TextFormField(
              decoration: textInputLoginDecoration.copyWith(hintText: 'Email'),
              validator: (val) => val.isEmpty ? 'Vul je email in' : null,
              onChanged: (val){
                setState(() {
                  email = val;
                });
              },
            ),
            SizedBox(height: 15,),
            TextFormField(
              decoration: textInputLoginDecoration.copyWith(hintText: 'Wachtwoord'),
              obscureText: true,
              validator: (val) => val.isEmpty ? 'Vul je wachtwoord in' : null,
              onChanged: (val){
                setState(() {
                  password = val;
                });
              },
            ),
            SizedBox(height: 15,),
            RaisedButton.icon(
              label: Text(''),
               icon: Icon(Icons.navigate_next),
                onPressed: (){

                },
            )
          ],
        ),
      ),
    );
  }
}
