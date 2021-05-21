import 'package:firebase_demo/models/game.dart';
import 'package:firebase_demo/services/database.dart';
import 'package:flutter/material.dart';
class FormEdit extends StatefulWidget {
  const FormEdit({Key key, this.game}) : super(key: key);
  final Game game;
  @override
  _FormEditState createState() => _FormEditState();
}

class _FormEditState extends State<FormEdit> {
  final _formKey=GlobalKey<FormState>();
  final DatabaseService _database=DatabaseService();

  String _currentTitle;
  String _currentProducer;
  String _currentGenre;
  int _currentPlayedTime;



  @override
  Widget build(BuildContext context) {

    return AlertDialog(
      backgroundColor: Color(0xff2d2d2d),

      content: Container(
        height: 400.0,
        child: Form(
          key: _formKey,
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Text('Edit Game',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 25.0,
                  ),),
                SizedBox(
                  height: 25.0,
                ),
                Text('Title',
                  style: TextStyle(color: Colors.white70,
                      fontSize: 15.0),
                ),
                SizedBox(
                  height: 1.0,
                ),
                Container(
                  width: 250.0,
                  child: TextFormField(
                    initialValue: widget.game.title,
                    decoration: InputDecoration(
                      contentPadding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 10.0),
                      fillColor: Colors.white,
                      filled: true,
                      enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.black54,width: 2.0)
                      ),
                      focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.black54,width: 2.0)
                      ),
                    ),
                    style: TextStyle(color: Colors.black),
                    validator: (val){
                      if(val.length==0){
                        return 'Cannot be empty!';
                      }
                      else return null;
                    },
                    onChanged: (val){
                      setState(() =>_currentTitle=val);
                    },
                  ),
                ),
                SizedBox(
                  height: 5.0,
                ),
                Text('Producer',
                  style: TextStyle(color: Colors.white70,
                      fontSize: 15.0),
                ),
                SizedBox(
                  height: 1.0,
                ),
                Container(
                  width: 250.0,
                  child: TextFormField(
                    initialValue: widget.game.producer,
                    decoration: InputDecoration(
                      contentPadding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 10.0),
                      fillColor: Colors.white,
                      filled: true,
                      enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.black54,width: 2.0)
                      ),
                      focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.black54,width: 2.0)
                      ),
                    ),
                    style: TextStyle(color: Colors.black),
                    validator: (val){
                      if(val.length==0){
                        return 'Cannot be empty!';
                      }
                      else return null;
                    },
                    onChanged: (val){
                      setState(() =>_currentProducer=val);
                    },
                  ),
                ),
                SizedBox(
                  height: 5.0,
                ),
                Text('Genre',
                  style: TextStyle(color: Colors.white70,
                      fontSize: 15.0),
                ),
                SizedBox(
                  height: 1.0,
                ),
                Container(
                  width: 250.0,
                  child: TextFormField(
                    initialValue: widget.game.genre,
                    decoration: InputDecoration(
                      contentPadding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 10.0),
                      fillColor: Colors.white,
                      filled: true,
                      enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.black54,width: 2.0)
                      ),
                      focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.black54,width: 2.0)
                      ),
                    ),
                    style: TextStyle(color: Colors.black),
                    validator: (val){
                      if(val.length==0){
                        return 'Cannot be empty!';
                      }
                      else return null;
                    },
                    onChanged: (val){
                      setState(() =>_currentGenre=val);
                    },
                  ),
                ),
                SizedBox(
                  height: 5.0,
                ),

                Text('Time played',
                  style: TextStyle(color: Colors.white70,
                      fontSize: 15.0),
                ),
                SizedBox(
                  height: 1.0,
                ),
                Container(
                  width: 250.0,
                  child: TextFormField(
                    initialValue: widget.game.timePlayed.toString(),
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                      contentPadding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 10.0),
                      fillColor: Colors.white,
                      filled: true,
                      enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.black54,width: 2.0)
                      ),
                      focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.black54,width: 2.0)
                      ),
                    ),
                    style: TextStyle(color: Colors.black),
                    validator: (val){
                      if(val.length==0){
                        return 'Cannot be empty!';
                      }
                      else if(int.tryParse(val)==null){
                        return 'Not a number!';
                      }
                      else if(int.tryParse(val)<0){
                        return 'Cannot be less than 0!';
                      }
                      else return null;
                    },
                    onChanged:  (val){ setState(() {
                      _currentPlayedTime=int.tryParse(val);
                    });
                    },
                  ),
                ),
                SizedBox(
                  height: 5.0,
                ),
                ElevatedButton(
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all<Color>(Colors.white),
                  ),
                  child: Text('Submit',
                    style: TextStyle(color: Colors.black),
                  ),
                  onPressed: () async{
                    if(_currentTitle==null){
                      _currentTitle=widget.game.title;
                    }
                    if(_currentProducer==null){
                      _currentProducer=widget.game.producer;
                    }
                    if(_currentGenre==null){
                      _currentGenre=widget.game.genre;
                    }
                    if(_currentPlayedTime==null){
                      _currentPlayedTime=widget.game.timePlayed;
                    }
                    if(_formKey.currentState.validate()){
                      _database.updateGame(widget.game.gameID,_currentTitle, _currentProducer, _currentGenre, _currentPlayedTime);
                      Navigator.of(context).pop();
                    }
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
