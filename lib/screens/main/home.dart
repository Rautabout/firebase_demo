import 'package:firebase_demo/models/game.dart';
import 'package:firebase_demo/screens/main/games_list.dart';
import 'package:firebase_demo/screens/main/new_form.dart';
import 'package:firebase_demo/services/database.dart';
import 'package:flutter/material.dart';
import 'package:firebase_demo/services/auth.dart';
import 'package:provider/provider.dart';


class Home extends StatelessWidget {
  const Home({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
    final AuthService _auth = AuthService();
    final DatabaseService _database=DatabaseService();
    void _showAddGame(){
      showDialog(context: context, builder: (context){
        return FormNew();
      });
    }

    return StreamProvider<List<Game>>.value(
      value: DatabaseService().allGames,
      child: Scaffold(
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
                children: <Widget>[
                  GamesList(),
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
            color: Color(0xff2d2d2d),
            child: Center(
              child: Text(
                "Profile",
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 30
                ),
              ),
            ),
          ),
        ),
      ),
    );

  }
}
