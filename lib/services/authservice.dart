import 'package:firebase_auth/firebase_auth.dart';

class AuthenticationService{

  //Firebase auth instance declaration.
  final FirebaseAuth _auth = FirebaseAuth.instance;

  //TODO: login function
  Future signIn(String email, String password) async{

    try{
      print('loggin in');
      return await _auth.signInWithEmailAndPassword(email: email, password: password);
    }catch (error){
      print(error.toString());
    }

  }



  //Logout firebase user by sign out function from firebase.
  Future signOut() async{

    try{
      return await _auth.signOut();
    }catch (error){
      print(error.toString());
    }
  }

}