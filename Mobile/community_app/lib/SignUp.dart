import 'package:community_app/main.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:community_app/Dashboard.dart';
import 'auth.dart';

class SignUp extends StatefulWidget {
  @override
  _SignUpState createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  String _firstName;
  String _lastName;
  String _email;
  String _password;
  String _category;
  List<bool> isSelected = [false,true];
  AuthService _authGetUser = new AuthService();

  @override
  Widget build(BuildContext context) {
        _authGetUser.getUser().then((value){
      //will execute after response, value is response
      //print(value);
      if(value != null){
        Navigator.pop(context);
      }});
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
                      onChanged: (value) => setState(()=>_firstName = value),
                      keyboardType: TextInputType.text,
                      decoration: InputDecoration(labelText: "First Name")),
                    TextFormField(
                      onChanged: (value) => setState(()=>_lastName = value),
                      keyboardType: TextInputType.text,
                      decoration: InputDecoration(labelText: "Last Name")),
                  TextFormField(
                      onChanged: (value) => setState(()=>_email = value),
                      keyboardType: TextInputType.emailAddress,
                      decoration: InputDecoration(labelText: "Email Address")),
                  TextFormField(
                      onChanged: (value) => setState(()=>_password = value),
                      //obscureText: true,
                      decoration: InputDecoration(labelText: "Password")),
                      SizedBox(height: 20.0),
                  ToggleButtons(
                      children: <Widget>[
                        Text("Create"),
                        Text("Join"),
                      ],
                      onPressed: (int index) {
                        setState(() {
                            for (int buttonIndex = 0; buttonIndex < isSelected.length; buttonIndex++) {
                              if (buttonIndex == index) {
                                isSelected[buttonIndex] = true;
                              } else {
                                isSelected[buttonIndex] = false;
                              }
                            }
                          });
                      },
                      isSelected: isSelected,
                    ),
                                          SizedBox(height: 20.0),
                  RaisedButton(
                    child: Text("Create Account"),
                    textColor: Colors.white,
                    color: Colors.black54,
                    onPressed: () {

                      if(isSelected[0])
                        _category = "admin";
                      else
                        _category = "tenant";
                      _authGetUser.registerWithEmail(_email, _password, _firstName, _lastName, _category);
                      Navigator.pop(context);
                    //Navigator.push(context, new MaterialPageRoute(
                      //builder: (BuildContext context) => Dashboard()));
                      }
                )]),
    ))));
  }
}