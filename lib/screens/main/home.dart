import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_demo/models/game.dart';
import 'package:firebase_demo/screens/main/game_tile.dart';
import 'package:firebase_demo/screens/main/games_list.dart';
import 'package:firebase_demo/screens/main/new_form.dart';
import 'package:firebase_demo/services/database.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:firebase_demo/services/auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Home extends StatefulWidget {
  const Home({Key key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

enum _listSelection { allGames, playedGames, unplayedGames, searchedGames }

class _HomeState extends State<Home> {
  final firebaseUser = FirebaseAuth.instance.currentUser;
  String searchValue='';
  TextEditingController _searchController = TextEditingController();
  final DatabaseService _database = DatabaseService();
  _listSelection _selection = _listSelection.allGames;
  void changeSelection(_listSelection value) {
    setState(() {
      _selection = value;
      switch (_selection) {
        case _listSelection.allGames:
          break;
        case _listSelection.playedGames:
          break;
        case _listSelection.unplayedGames:
          break;
        case _listSelection.searchedGames:
          break;
      }
    });
  }

  @override
  void initState() {
    super.initState();
    _searchController.addListener(_onSearchChanged);
  }
  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  _onSearchChanged() {
  }

  @override
  Widget build(BuildContext context) {
    final AuthService _auth = AuthService();
    void _showAddGame() {
      showDialog(
          context: context,
          builder: (context) {
            return FormNew();
          });
    }

    return Scaffold(
      backgroundColor: Color(0xff686868),
      appBar: AppBar(
        backgroundColor: Color(0xff2d2d2d),
        title: SizedBox(
          child: TextField(
            onSubmitted: (searchValue) {
              setState(() {
                if(searchValue==''){
                  _selection=_listSelection.allGames;
                }
                else {
                  _searchController.text = searchValue.toLowerCase();
                  _selection = _listSelection.searchedGames;
                }
              });
            },
            cursorColor: Colors.white,
            decoration: InputDecoration(
              hintText: "Search",
              hintStyle: TextStyle(color: Colors.white),
              prefixIcon: Icon(Icons.search, color: Colors.white),
            ),
            style: TextStyle(color: Colors.white, fontSize: 18.0),
            textAlign: TextAlign.start,
          ),
        ),
        actions: [
          Builder(
            builder: (context) {
              return IconButton(
                  icon: Icon(Icons.filter_list_alt, color: Colors.white),
                  onPressed: () {
                    setState(() {
                      _selection=_listSelection.allGames;
                    });
                    Scaffold.of(context).openEndDrawer();
                  });
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        physics: ScrollPhysics(),
        child: Column(
          children: [
            Visibility(
              visible: _selection == _listSelection.searchedGames,
              child: StreamProvider<List<Game>>.value(
                  value: _database.allGames, child: SearchList(_searchController.text)),
            ),
            Visibility(
              visible: _selection == _listSelection.allGames,
              child: StreamProvider<List<Game>>.value(
                  value: _database.allGames, child: GamesList()),
            ),
            Visibility(
              visible: _selection == _listSelection.unplayedGames,
              child: StreamProvider<List<Game>>.value(
                  value: _database.unplayedGames, child: GamesList()),
            ),
            Visibility(
              visible: _selection == _listSelection.playedGames,
              child: StreamProvider<List<Game>>.value(
                  value: _database.playedGames, child: GamesList()),
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
                    DrawerHeader(
                      child: Text('Menu',
                          style:
                              TextStyle(color: Colors.white, fontSize: 20.0)),
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
                                leading: Icon(Icons.add, color: Colors.white),
                                title: Text('Add new',
                                    style: TextStyle(color: Colors.white)),
                                onTap: () {
                                  Navigator.of(context).pop();
                                  _showAddGame();
                                },
                              ),
                              ListTile(
                                  focusColor: Colors.white10,
                                  onTap: () async {
                                    await _auth.signOut();
                                  },
                                  leading: Icon(Icons.arrow_back_outlined,
                                      color: Colors.white),
                                  title: Text('Sign Out',
                                      style: TextStyle(color: Colors.white)))
                            ],
                          ))))
            ],
          ),
        ),
      ),
      endDrawer: Drawer(
        child: Container(
          color: Color(0xff686868),
          child: Column(
            children: [
              Expanded(
                child: ListView(
                  children: <Widget>[
                    DrawerHeader(
                      child: Text('List Filters',
                          style:
                              TextStyle(color: Colors.white, fontSize: 20.0)),
                      decoration: BoxDecoration(
                        color: Color(0xff2d2d2d),
                      ),
                    ),
                    RadioListTile(
                      activeColor: Colors.white,
                      title: Text('All Games',
                          style: TextStyle(color: Colors.white)),
                      value: _listSelection.allGames,
                      groupValue: _selection,
                      onChanged: changeSelection,
                    ),
                    RadioListTile(
                      activeColor: Colors.white,
                      title: Text('Played Games',
                          style: TextStyle(color: Colors.white)),
                      value: _listSelection.playedGames,
                      groupValue: _selection,
                      onChanged: changeSelection,
                    ),
                    RadioListTile(
                      activeColor: Colors.white,
                      title: Text('Unplayed Games',
                          style: TextStyle(color: Colors.white)),
                      value: _listSelection.unplayedGames,
                      groupValue: _selection,
                      onChanged: changeSelection,
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

class SearchList extends StatefulWidget {
  final String searchController;
  SearchList(this.searchController);

  @override
  State<StatefulWidget> createState() => _SearchList();
}

class _SearchList extends State<SearchList> {
  @override
  Widget build(BuildContext context) {
    final games = Provider.of<List<Game>>(context) ?? [];

    final List<Game> games2 = [];
    games.forEach((game) {
      if (game.title.toLowerCase().contains(widget.searchController)) {
        games2.add(game);
      }
    });

    return ListView.builder(
        physics: NeverScrollableScrollPhysics(),
        scrollDirection: Axis.vertical,
        shrinkWrap: true,
        itemCount: games2.length,
        itemBuilder: (context, index) {
          return GameTile(game: games2[index]);
        });
  }
}
