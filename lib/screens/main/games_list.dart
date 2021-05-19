import 'package:firebase_demo/models/game.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:firebase_demo/screens/main/game_tile.dart';

class GamesList extends StatefulWidget {
  const GamesList({Key key}) : super(key: key);

  @override
  _GamesListState createState() => _GamesListState();
}

class _GamesListState extends State<GamesList> {
  @override
  Widget build(BuildContext context) {

    final games=Provider.of<List<Game>>(context)??[];
    games.forEach((game) {
      print(game.title);
      print(game.producer);
      print(game.genre);
      print(game.timePlayed);
      print(game.wasPlayed);
    });

    return ListView.builder(

        scrollDirection: Axis.vertical,
        shrinkWrap: true,
        itemCount: games.length,
        itemBuilder: (context,index){
        return GameTile(game:games[index]);
      });
  }
}



