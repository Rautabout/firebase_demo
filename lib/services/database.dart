import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';


class DatabaseService{

  final firebaseUser=FirebaseAuth.instance.currentUser;

  final CollectionReference _gamesCollection=FirebaseFirestore.instance.collection('games');

  Future addNewGame(String title, String description,String genre, String grade,double timePlayed,bool wasPlayed)async{
    try{
      await _gamesCollection.doc(firebaseUser.uid).collection('gameID').add({
        'title':title.trim(),
        'description':description.trim(),
        'genre':genre.trim(),
        'grade':grade.trim(),
        'timePlayed':timePlayed.toString().trim(),
        'wasPlayed':false,
      });
    } catch(e){
      print(e.toString());
      return null;
    }
  }
  // Future updateGame(String title, String description,String genre, String grade,double timePlayed,bool wasPlayed)async{
  //   try{
  //     await _gamesCollection.doc(firebaseUser.uid).collection('gameID').doc({
  //       'title':title.trim(),
  //       'description':description.trim(),
  //       'genre':genre.trim(),
  //       'grade':grade.trim(),
  //       'timePlayed':timePlayed.toString().trim(),
  //       'wasPlayed':false,
  //     });
  //   } catch(e){
  //     print(e.toString());
  //     return null;
  //   }
  // }

}