import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_demo/models/game.dart';
import 'package:flutter/material.dart';


class DatabaseService{

  final firebaseUser=FirebaseAuth.instance.currentUser;

  final CollectionReference _gamesCollection=FirebaseFirestore.instance.collection('games');

  //games list
  List<Game> _game(QuerySnapshot snapshot){
    return snapshot.docs.map((doc){
      return Game(
        title: doc.data()['title']??'',
        producer: doc.data()['producer']??'',
        genre: doc.data()['genre']??'',
        timePlayed: doc.data()['timePlayed']??0,
        wasPlayed: doc.data()['wasPlayed']??false
      );
    }).toList();
  }

  Future addNewGame(String title, String producer,String genre, int timePlayed, bool wasPlayed)async{
    try{
      if(timePlayed>0) {
        await _gamesCollection.doc(firebaseUser.uid).collection('gameID').add({
          'title': title.trim(),
          'producer': producer.trim(),
          'genre': genre.trim(),
          'timePlayed': timePlayed,
          'wasPlayed': true,
        });
      }else{
        await _gamesCollection.doc(firebaseUser.uid).collection('gameID').add({
          'title': title.trim(),
          'producer': producer.trim(),
          'genre': genre.trim(),
          'timePlayed': timePlayed,
          'wasPlayed': false,
        });
      }
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


  //
  // Stream<QuerySnapshot> get games{
  //   return _gamesCollection.doc(firebaseUser.uid).collection('gameID').snapshots();
  // }
  Stream<List<Game>> get games{
    return _gamesCollection.doc(firebaseUser.uid).collection('gameID').snapshots().map(_game);
  }
}