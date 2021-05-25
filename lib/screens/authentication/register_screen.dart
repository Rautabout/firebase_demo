import 'package:firebase_demo/services/auth.dart';
import 'package:flutter/material.dart';

class SignUp extends StatefulWidget {
  final Function toggleView;
  SignUp({this.toggleView});
  @override
  State<StatefulWidget> createState() => new _SignUpState();
}


class _SignUpState extends State<SignUp>{

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
                  keyboardType: TextInputType.emailAddress,
                  style: TextStyle(color: Colors.black),
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
              SizedBox(
                width: 250.0,
                child: TextFormField(

                  keyboardType: TextInputType.visiblePassword,
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
                onPressed: () async{
                  if(_formKey.currentState.validate()) {
                    dynamic result = await _auth.signUp(
                        _email, _password);
                    if (result == 1) {
                      setState(() => _error = 'User already exists!');
                    }
                    else if(result==2){
                      setState(() => _error = 'Something went wrong');
                    }
                  }
                },
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all<Color>(Colors.white),
                ),
                child: Text('Sign up',
                  style: TextStyle(color: Colors.black),
                ),
              ),
              TextButton(
                onPressed: (){
                  widget.toggleView();
                },
                child: Text('Already registered? Click here!',
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