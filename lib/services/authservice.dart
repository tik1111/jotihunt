import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:jotihunt/services/databaseHandler.dart';

class AuthenticationService{

  //Firebase auth instance declaration.
  final FirebaseAuth _auth = FirebaseAuth.instance;
  
  Future signIn(String email, String password) async{

    try{
      return await _auth.signInWithEmailAndPassword(email: email, password: password);
    }catch (error){
      print(error.toString());
    }

  }

   getCurrentUser() async{
      var user = await _auth.currentUser();
      
      return (user);

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