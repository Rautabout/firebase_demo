import 'package:flutter/material.dart';
class FormEdit extends StatefulWidget {
  const FormEdit({Key key}) : super(key: key);

  @override
  _FormEditState createState() => _FormEditState();
}

class _FormEditState extends State<FormEdit> {
  final _formKey=GlobalKey<FormState>();
  String _currentTitle;
  String _currentProducer;
  String _currentGenre;
  int _currentPlayedTime;
  bool _currentWasPlayed;


  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Text('Edit Game',
          style: TextStyle(
            color: Colors.white,
            fontSize: 30.0,
          ),),
          SizedBox(
            height: 10.0,
          ),
          Text('Title',
            style: TextStyle(color: Colors.white70,
                fontSize: 20.0),
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
              validator: (val)=>val.length==0?'Cannot be empty!':null,
              obscureText: true,
              onChanged: (val){ },
            ),
          ),
          SizedBox(
            height: 10.0,
          ),
          Text('Producer',
            style: TextStyle(color: Colors.white70,
                fontSize: 20.0),
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
              validator: (val)=>val.length==0?'Cannot be empty!':null,
              obscureText: true,
              onChanged: (val){ },
            ),
          ),
          SizedBox(
            height: 10.0,
          ),
          Text('Genre',
            style: TextStyle(color: Colors.white70,
                fontSize: 20.0),
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
              validator: (val)=>val.length==0?'Cannot be empty!':null,
              obscureText: true,
              onChanged: (val){ },
            ),
          ),
          SizedBox(
            height: 10.0,
          ),

          Text('Time played',
            style: TextStyle(color: Colors.white70,
                fontSize: 20.0),
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
              validator: (val)=>val.length==0?'Cannot be empty!':null,
              obscureText: true,
              onChanged: (val){ },
            ),
          ),
          SizedBox(
            height: 10.0,
          ),
          ElevatedButton(
            style: ButtonStyle(
              backgroundColor: MaterialStateProperty.all<Color>(Colors.white),
            ),
            child: Text('Submit',
              style: TextStyle(color: Colors.black),
            ),
            onPressed: () async{
              Navigator.of(context).pop();
            },
          ),
        ],
      ),
    );
  }
}
