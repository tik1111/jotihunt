import 'package:firebase_auth/firebase_auth.dart';

class AuthenticationService{

  //Firebase auth instance declaration.
  final FirebaseAuth _auth = FirebaseAuth.instance;

  //TODO: login function


  //Logout firebase user by sign out function from firebase.
  Future signOut() async{

   try{
      return await _auth.signOut();
   }catch (error){
      print(error.toString());
  }

}



}