import 'package:flutter/material.dart';
import 'package:firebase_demo/services/auth.dart';


class SignIn extends StatefulWidget {
  final Function toggleView;
  SignIn({this.toggleView});
  @override
  State<StatefulWidget> createState() => new _SignInState();
}


class _SignInState extends State<SignIn>{

  final AuthService _auth = AuthService();
  final _formKey=GlobalKey<FormState>();

  String _email='';
  String _password='';
  String _error='';

  @override
  Widget build(BuildContext context) {
    return new Scaffold(

      body: new Container(
        color: Colors.black87,
        alignment: Alignment.center,
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,

            children: [
              Text('E-mail',
                style: TextStyle(color: Colors.white70),
              ),
              SizedBox(
                height: 10.0,
              ),
              Container(
                width: 250.0,
                child: TextFormField(
                  decoration: InputDecoration(
                    fillColor: Colors.white,
                    filled: true,
                    contentPadding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 10.0),

                    enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.black54,width: 2.0)
                    ),
                    focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.black54,width: 2.0)
                    ),
                  ),
                  style: TextStyle(color: Colors.black),
                  validator: (val){
                    bool validateEmail(String value) {
                      Pattern pattern =
                          r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
                      RegExp regex = new RegExp(pattern);
                      return (!regex.hasMatch(value)) ? false : true;
                    }
                    if(validateEmail(val)==false){
                      return 'Enter a proper email!';
                    }
                    else{
                      return null;
                    }
                  },
                  onChanged: (val){
                    setState(() =>_email=val);
                  },
                ),
              ),
              SizedBox(
                height: 20.0,
              ),
              Text('Password',
                style: TextStyle(color: Colors.white70),
              ),
              SizedBox(
                height: 10.0,
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
                  validator: (val)=>val.length<6?'Password be at least 6 characters!':null,
                  obscureText: true,
                  onChanged: (val){
                    setState(() =>_password=val);
                },
                ),
              ),
              SizedBox(
                height: 30.0,
              ),
              ElevatedButton(
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all<Color>(Colors.white),
                ),
                child: Text('Sign in',
                  style: TextStyle(color: Colors.black),
                ),
                onPressed: () async{
                  if(_formKey.currentState.validate()) {
                    dynamic result = await _auth.signIn(
                        _email, _password);
                    if (result == null) {
                      setState(() => _error = 'Something went wrong');
                    }
                  }
                },
              ),
              TextButton(
                onPressed: (){
                  widget.toggleView();
                },
                child: Text('Not yet registered? Click here!',
                  style: TextStyle(color: Colors.white70),
                ),
              ),
              Text(
                _error,
                style: TextStyle(color: Colors.red),
              )
            ],
          ),
        ),
      ),
    );
  }




}