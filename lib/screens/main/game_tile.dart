import 'package:firebase_demo/screens/main/edit_form.dart';
import 'package:flutter/material.dart';
import 'package:firebase_demo/models/game.dart';

class GameTile extends StatelessWidget {
  const GameTile({Key key, this.game}) : super(key: key);
  final Game game;

  @override
  Widget build(BuildContext context) {
    void _showGameSetting(){
      
      showModalBottomSheet(context: context, builder: (context){
        return Container(
          color: Colors.black87,
          child: FormEdit(),
        );
      });
    }

    if(game.timePlayed>0){
      game.wasPlayed=true;
    }
    else{
      game.wasPlayed=false;
    }
    return Padding(
      padding: EdgeInsets.only(top: 8.0),
      child: Card(
        color: Colors.black54,
        margin: EdgeInsets.fromLTRB(5.0, 6.0, 5.0, 0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  game.title,
                  style: TextStyle(
                    fontSize: 25.0,
                    color: Colors.white,
                  ),
                ),
                IconButton(
                    icon: Icon(
                      Icons.edit,
                      size: 30.0,
                      color: Colors.white,
                  ), onPressed: ()=>_showGameSetting())
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Text(
                  game.producer,
                  style: TextStyle(
                    fontSize: 20.0,
                    color: Colors.white,
                  ),
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(game.genre,
                  style: TextStyle(
                    fontSize: 15.0,
                    color: Colors.white,
                  ),
                ),
                if(game.timePlayed>0)
                  Text('Time played: '+game.timePlayed.toString()+'h',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 15.0
                    ),
                  ),
                if(game.timePlayed==0)
                  Text('Not yet played',
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 15.0
                    ),
                  ),
                IconButton(icon: Icon(
                    Icons.delete_forever,
                  size: 30.0,
                  color: Colors.white,
                ), onPressed: (){})
              ],
            ),

          ],
        ),
        // child: ListTile(
        //   leading: Text(game.timePlayed.toString()),
        //   title: Text(game.title),
        //   subtitle: Text(game.producer),
        //   trailing: Icon(Icons.edit),
        // ),
      ),
    );
  }
}
