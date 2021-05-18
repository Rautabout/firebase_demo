import 'package:firebase_demo/screens/authentication/login_screen.dart';
import 'package:firebase_demo/screens/authentication/register_screen.dart';
import 'package:flutter/material.dart';

class Authentication extends StatefulWidget {
  const Authentication({Key key}) : super(key: key);

  @override
  _AuthenticationState createState() => _AuthenticationState();
}

class _AuthenticationState extends State<Authentication> {
  bool showSignIn=true;
  void toggleView(){
    setState(() =>showSignIn=!showSignIn);
  }

  @override
  Widget build(BuildContext context) {
    if(showSignIn==true){
      return SignIn(toggleView:toggleView);
    }
    else{
      return SignUp(toggleView:toggleView);
    }

  }
}
