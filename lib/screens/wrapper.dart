import 'package:firebase_demo/models/user.dart';
import 'package:flutter/material.dart';
import 'package:firebase_demo/screens/authentication/authentication.dart';
import 'package:firebase_demo/screens/main/home.dart';
import 'package:provider/provider.dart';


class Wrapper extends StatelessWidget {
  const Wrapper({Key key}) : super(key: key);


  @override
  Widget build(BuildContext context) {
    final user=Provider.of<UserModel>(context);

    if(user==null) {
      return Authentication();
    }
    else{
      return Home();
    }
  }
}
