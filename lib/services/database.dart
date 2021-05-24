import 'dart:math';

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
        gameID:doc.id,
        title: doc.data()['title']??'',
        producer: doc.data()['producer']??'',
        genre: doc.data()['genre']??'',
        timePlayed: doc.data()['timePlayed']??0,
        wasPlayed: doc.data()['wasPlayed']??false
      );
    }).toList();
  }

  Future addNewGame(String title, String producer,String genre, int timePlayed)async{
    const _chars = 'AaBbCcDdEeFfGgHhIiJjKkLlMmNnOoPpQqRrSsTtUuVvWwXxYyZz1234567890';
    Random _rnd = Random();

    String getRandomString(int length) => String.fromCharCodes(Iterable.generate(
        length, (_) => _chars.codeUnitAt(_rnd.nextInt(_chars.length))));
    String gameID=getRandomString(20);
    try{
      if(timePlayed>0) {
        await _gamesCollection.doc(firebaseUser.uid).collection('gameID').doc(gameID).set({
          'gameID': gameID,
          'title': title.trim(),
          'producer': producer.trim(),
          'genre': genre.trim(),
          'timePlayed': timePlayed,
          'wasPlayed': true,
        });
      }else{
        await _gamesCollection.doc(firebaseUser.uid).collection('gameID').doc(gameID).set({
          'gameID': gameID,
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


  Future updateGame(String gameID,String title, String producer,String genre, int timePlayed)async{

    try{
      if(timePlayed>0) {
        await _gamesCollection.doc(firebaseUser.uid).collection('gameID').doc(gameID).set({
          'title': title.trim(),
          'producer': producer.trim(),
          'genre': genre.trim(),
          'timePlayed': timePlayed,
          'wasPlayed': true,
        });
      }else{
        await _gamesCollection.doc(firebaseUser.uid).collection('gameID').doc(gameID).set({
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


  Stream<List<Game>> get allGames{
    return _gamesCollection.doc(firebaseUser.uid).collection('gameID').snapshots().map(_game);
  }
  Stream<List<Game>> get playedGames{
    final CollectionReference playedCollection=_gamesCollection.doc(firebaseUser.uid).collection('gameID');
    final Query played=playedCollection.where("wasPlayed",isEqualTo: true);
    return played.snapshots().map(_game);
  }
  Stream<List<Game>> get unplayedGames{
    final CollectionReference unplayedCollection=_gamesCollection.doc(firebaseUser.uid).collection('gameID');
    final Query unplayed=unplayedCollection.where("wasPlayed",isEqualTo: false);
    return unplayed.snapshots().map(_game);
  }





}