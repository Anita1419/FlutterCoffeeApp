import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:coffeeorders_app/models/CustomModelUser.dart';
import 'package:coffeeorders_app/services/database.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';

class AuthService {


  final FirebaseAuth _auth =  FirebaseAuth.instance ;
  //sign in anomously
  CustomModelUser? _modelUser (User? firebaseUser){
    return firebaseUser!=null ? CustomModelUser(uid: firebaseUser.uid) : null;
  }

  Stream<CustomModelUser?> get user{
    return _auth.authStateChanges().map(_modelUser);

  }

/*  Future signInAnoumosly() async{
    try{
      UserCredential result =await _auth.signInAnonymously();
      User? user = result.user;
      return _modelUser(user);
    }catch (e){
      print(e.toString());
      return null;

    }
  }*/




  //sign in with email and password
  Future SignInWithEmailAndPassword(String email , String password) async {
    try{
      UserCredential userCredential = await _auth.signInWithEmailAndPassword(email: email, password: password);
      User?  user= userCredential.user;
      return _modelUser(user);
    }catch(e){
      print(e.toString());
      return null;
    }
  }



  //register with email and password

  Future registerWithEmailAndPassword(String email , String password) async {
    try{
      UserCredential userCredential = await _auth.createUserWithEmailAndPassword(email: email, password: password);
      User?  user= userCredential.user;
      await DatabaseService(user!.uid).updateUserData("0", "new crew member", 100);
      return _modelUser(user);
    }catch(e){
      print(e.toString());
      return null;
    }
  }

  //sign out

   Future signOut() async {
    try{
      return await _auth.signOut();
    }catch (ex){
      print("Error Ocurred $ex");
      return null;

    }
   }

}