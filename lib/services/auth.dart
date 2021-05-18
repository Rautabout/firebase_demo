import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_demo/models/user.dart';
import 'package:flutter/material.dart';

class AuthService{
  final FirebaseAuth _auth=FirebaseAuth.instance;

  UserModel _user(User user){
    return user!=null?UserModel(uid: user.uid,email: user.email):null;
  }

  //auth change
  Stream<UserModel> get user{
    return _auth.authStateChanges()
        .map(_user);
  }


  //sign in
  Future signIn(String email,String password) async{
    try {
      UserCredential result = await _auth.signInWithEmailAndPassword(email: email, password: password);
      User user = result.user;
      return _user(user);
    } catch(e){
      print(e.toString());
      return null;
    }
  }
  //sign up
  Future signUp(String email,String password) async{
    try{
      UserCredential result=await _auth.createUserWithEmailAndPassword(email: email, password: password);
      User user=result.user;
      return _user(user);
    }catch(e){
      print(e.toString());
      return null;
    }
  }
  //sign out
  Future signOut() async{
    try{
      return await _auth.signOut();
    }catch(e){
      print(e.toString());
      return null;
    }
  }


}