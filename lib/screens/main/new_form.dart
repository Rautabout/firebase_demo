import 'package:firebase_demo/services/database.dart';
import 'package:flutter/material.dart';


class FormNew extends StatefulWidget {
  const FormNew({Key key}) : super(key: key);

  @override
  _FormNewState createState() => _FormNewState();
}

class _FormNewState extends State<FormNew> {
  final _formKey=GlobalKey<FormState>();
  final DatabaseService _database=DatabaseService();

  String _title;
  String _producer;
  String _genre;
  int _timePlayed;
  bool _wasPlayed;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: Color(0xff1c1c1c),

      content: Container(
        height: 400.0,
        child: Form(
          key: _formKey,
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Text('New Game',
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
                      setState(() =>_title=val);
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
                      setState(() =>_producer=val);
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
                      setState(() =>_genre=val);
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
                    onChanged: (val){ setState(() {
                      _timePlayed=int.parse(val);
                      if(_timePlayed==0){
                        _wasPlayed=false;
                      }
                      else{
                        _wasPlayed=true;
                      }
                    });},
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
                    if(_formKey.currentState.validate()){
                      _database.addNewGame(_title, _producer, _genre, _timePlayed, _wasPlayed);
                      Navigator.of(context).pop();
                    }
                    //_database.addNewGame('Tetris', 'Dont I', 'Puzzle', 69, true);
                    //Navigator.of(context).pop();

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
