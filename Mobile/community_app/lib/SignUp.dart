import 'package:community_app/main.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:community_app/Dashboard.dart';

class SignUp extends StatefulWidget {
  @override
  _SignUpState createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  String _firstName;
  String _lastName;
  String _email;
  String _password;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Sign Up"),
        backgroundColor: Colors.black54,
      ),
      body: Center(
        child: Container(
            padding: EdgeInsets.all(20.0),
            child: Form(
                child: Column(children: <Widget>[
                  SizedBox(height: 20.0),
                  Text(
                    'Create an Account',
                    style: TextStyle(fontSize: 20),
                  ),
                  SizedBox(height: 20.0),
                  TextFormField(
                      onSaved: (value) => _firstName = value,
                      keyboardType: TextInputType.text,
                      decoration: InputDecoration(labelText: "First Name")),
                    TextFormField(
                      onSaved: (value) => _lastName = value,
                      keyboardType: TextInputType.text,
                      decoration: InputDecoration(labelText: "Last Name")),
                  TextFormField(
                      onSaved: (value) => _email = value,
                      keyboardType: TextInputType.emailAddress,
                      decoration: InputDecoration(labelText: "Email Address")),
                  TextFormField(
                      onSaved: (value) => _password = value,
                      obscureText: true,
                      decoration: InputDecoration(labelText: "Password")),
                      SizedBox(height: 20.0),
                  RaisedButton(
                    child: Text("Create Account"),
                    textColor: Colors.white,
                    color: Colors.black54,
                    onPressed: () {
                    Navigator.push(context, new MaterialPageRoute(
                      builder: (BuildContext context) => Dashboard()));
                      }
                )]),
    ))));
  }
}