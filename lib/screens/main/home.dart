import 'package:firebase_demo/models/game.dart';
import 'package:firebase_demo/screens/main/games_list.dart';
import 'package:firebase_demo/screens/main/new_form.dart';
import 'package:firebase_demo/services/database.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:firebase_demo/services/auth.dart';
import 'package:provider/provider.dart';


class Home extends StatefulWidget {
  const Home({Key key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

enum _listSelection{allGames,playedGames,unplayedGames}


class _HomeState extends State<Home> {


  @override
  Widget build(BuildContext context) {
    final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
    final AuthService _auth = AuthService();
    final DatabaseService _database=DatabaseService();
    _listSelection _selection=_listSelection.allGames;

    void _showAddGame(){
      showDialog(context: context, builder: (context){
        return FormNew();
      });
    }



    return Scaffold(
      backgroundColor: Color(0xff686868),
      appBar: AppBar(
        backgroundColor: Color(0xff2d2d2d),
          title: SizedBox(
            child: TextField(
              cursorColor: Colors.white,
                textInputAction: TextInputAction.search,
                onSubmitted: (String value){

                },
                decoration: InputDecoration(
                  hintText: "Search",
                  hintStyle: TextStyle(
                    color: Colors.white,
                  ),
                ),
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 18.0,
                ),
                textAlign: TextAlign.center),
          ),
            actions: [
              IconButton(icon: Icon(Icons.search,color: Colors.white),onPressed: (){},),
              Builder(
                builder: (context){
                  return IconButton(icon: Icon(
                    Icons.filter_list_alt,
                    color: Colors.white
                    ),
                    onPressed: ()
                      {
                        print(_selection);
                        Scaffold.of(context).openEndDrawer();
                      }
                    );
                  },
                ),
        ],
      ),
      body: SingleChildScrollView(
        physics: ScrollPhysics(),
        child: Column(
          children: [
            StreamProvider<List<Game>>.value(
                value: _database.allGames,
                child: GamesList()
            ),
            StreamProvider<List<Game>>.value(
                value: _database.playedGames,
                child: GamesList()
            ),
            StreamProvider<List<Game>>.value(
                value: _database.unplayedGames,
                child: GamesList()
            ),


          ],
        ),
      ),
      drawer: Drawer(
        child: Container(
          color: Color(0xff686868),
          child: Column(
            children: <Widget>[
            Expanded(
              // ListView contains a group of widgets that scroll inside the drawer
              child: ListView(
                children: <Widget>[
                  DrawerHeader(child: Text('Menu',style: TextStyle(color: Colors.white,fontSize: 20.0)),
                    decoration: BoxDecoration(
                    color: Color(0xff2d2d2d),
                    ),
                  ),
                ],
              ),
            ),

            Container(
                child: Align(
                    alignment: FractionalOffset.bottomCenter,
                    child: Container(
                      color: Color(0xff2d2d2d),
                        child: Column(
                          children: <Widget>[
                            Divider(),
                            ListTile(
                              leading: Icon(Icons.add,color: Colors.white),
                              title: Text('all',style: TextStyle(color: Colors.white)),
                              onTap: (){
                                _selection=_listSelection.allGames;
                                //_changeList();
                                Navigator.of(context).pop();
                              },

                            ),ListTile(
                              leading: Icon(Icons.add,color: Colors.white),
                              title: Text('played',style: TextStyle(color: Colors.white)),
                              onTap: (){
                                _selection=_listSelection.playedGames;
                                //_changeList();
                                Navigator.of(context).pop();
                              },

                            ),ListTile(
                              leading: Icon(Icons.add,color: Colors.white),
                              title: Text('unplayed',style: TextStyle(color: Colors.white)),
                              onTap: (){
                                _selection=_listSelection.unplayedGames;
                                //_changeList();
                                Navigator.of(context).pop();
                              },

                            ),
                            ListTile(
                                leading: Icon(Icons.add,color: Colors.white),
                                title: Text('Add new',style: TextStyle(color: Colors.white)),
                              onTap: (){
                                  Navigator.of(context).pop();
                                  _showAddGame();
                              },

                            ),

                            ListTile(
                              focusColor: Colors.white10,
                              onTap: () async{
                                await _auth.signOut();
                                },
                                leading: Icon(Icons.arrow_back_outlined,color: Colors.white),
                                title: Text('Sign Out',style: TextStyle(color: Colors.white)))
                          ],
                        )
                    )
                )
            )
          ],
        ),
        ),
      ),
      endDrawer: Drawer(
        child: Container(
          color: Color(0xff686868),
          child: Column(
            children: [
              Expanded(child: ListView(
                children: <Widget>[
                  DrawerHeader(
                    child: Text('List filters',style: TextStyle(color: Colors.white,fontSize: 20.0)),
                    decoration: BoxDecoration(
                      color: Color(0xff2d2d2d),
                    ),
                  ),
                  RadioListTile(
                    title: Text('All Games'),
                    value: _listSelection.allGames,
                    groupValue: _selection,
                    onChanged: (_listSelection value) {
                      setState(() {
                        _selection = value;
                      });
                      },
                  ),
                  RadioListTile(
                    title: Text('Played Games'),
                    value: _listSelection.playedGames,
                    groupValue: _selection,
                    onChanged: (_listSelection value) {
                      setState(() {
                        _selection = value;
                      });
                      },
                  ),
                  RadioListTile(
                    title: Text('Unplayed Games'),
                    value: _listSelection.unplayedGames,
                    groupValue: _selection,
                    onChanged: (_listSelection value) {
                      setState(() {
                        _selection = value;
                      });
                      },
                  ),
                ],
              ),
              ),
            ],
          ),
        ),
    ),
    );
  }
}
