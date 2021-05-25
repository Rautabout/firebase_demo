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
    final List<Game> games = Provider.of<List<Game>>(context) ?? [];

    // final List<Game> games2 = [];
    // games.forEach((game) {
    //   if (game.title.contains('Mass Effect')) {
    //     games2.add(game);
    //   }
    // });

    return ListView.builder(
        physics: NeverScrollableScrollPhysics(),
        scrollDirection: Axis.vertical,
        shrinkWrap: true,
        itemCount: games.length,
        itemBuilder: (context, index) {
          return GameTile(game: games[index]);
        });
  }
}
