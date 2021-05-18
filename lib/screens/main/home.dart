import 'package:firebase_demo/services/database.dart';
import 'package:flutter/material.dart';
import 'package:firebase_demo/services/auth.dart';

class Home extends StatelessWidget {
  const Home({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
    final AuthService _auth = AuthService();
    final DatabaseService _database=DatabaseService();
    void _openEndDrawer(){
      _scaffoldKey.currentState.openEndDrawer();
    }
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black87,
          title: SizedBox(
            child: TextField(
              cursorColor: Colors.white,
                textInputAction: TextInputAction.search,
                onSubmitted: (String value){

                },
                //controller: _cityTextController,
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
                  onPressed: (){
                Scaffold.of(context).openEndDrawer();
              });
            },
          ),

        ],
      ),
      body: Container(
        color: Colors.black54,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            ElevatedButton(
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all<Color>(Colors.white),
              ),
              child: Text('Sign out',
                style: TextStyle(color: Colors.black),
              ),
              onPressed: () async {
                await _auth.signOut();
              },
            ),
          ],
        ),
      ),
      drawer: Drawer(
        child: Container(
          color: Colors.black87,
          child: Column(
            children: <Widget>[
            Expanded(
              // ListView contains a group of widgets that scroll inside the drawer
              child: ListView(
                children: <Widget>[
                  DrawerHeader(child: Text('Menu',style: TextStyle(color: Colors.white,fontSize: 20.0)),
                    decoration: BoxDecoration(
                    color: Colors.black45,
                    ),
                  ),
                ],
              ),
            ),

            Container(
                child: Align(
                    alignment: FractionalOffset.bottomCenter,
                    child: Container(
                      color: Colors.black45,
                        child: Column(
                          children: <Widget>[
                            Divider(),
                            ListTile(
                                leading: Icon(Icons.add,color: Colors.white),
                                title: Text('Add new',style: TextStyle(color: Colors.white)),
                              onTap: (){
                                  _database.addNewGame('Tetris', 'I dont know', 'Puzzle', 69, true);
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
          color: Colors.black87,
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
    );

  }
}
