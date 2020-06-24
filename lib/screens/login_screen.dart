import 'package:flutter/material.dart';
import 'package:jotihunt/services/authservice.dart';
import 'package:jotihunt/shared/constants.dart';

class LoginWidget extends StatefulWidget {

  final Function toggleView;
  LoginWidget({ this.toggleView });

  @override
  _LoginWidgetState createState() => _LoginWidgetState();
}

class _LoginWidgetState extends State<LoginWidget> {

  final _formKeySignIn = GlobalKey<FormState>();
  final AuthenticationService _auth = new AuthenticationService();

  bool loading = false;

  String email = '';
  String password = '';
  String error = '';
  
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Jotihunt'),
      ),
      body: Form(
        key: _formKeySignIn,
        child: Container(
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
                  onPressed: () async{
                    if(_formKeySignIn.currentState.validate()){
                      setState(() {
                        loading = true;
                      });
                    }
                    dynamic result = await _auth.signIn(email, password);
                    if(result == null){
                      setState(() {
                        error = "Vul een geldige email in";
                        loading = false;
                      });
                    }
                  },
              )
            ],
          ),
        ),
      ),
    );
  }
}
