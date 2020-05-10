import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:community_app/SignUp.dart';
import 'package:community_app/auth.dart';
import 'package:community_app/main.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:community_app/Dashboard.dart';
import 'AdminDashboard.dart';

class Login extends StatefulWidget {
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  String _password;
  String _email;
  AuthService _auth = new AuthService();
  bool _isSignedIn = false;
  var _userdb = Firestore.instance.collection("users");
  String _userType = "";

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _auth.getUser().then((value){
      //will execute after response, value is response
      //print(value);
      if(value != null){
        _userdb.document(value.uid).get().then((doc){
          if(doc.exists){
            setState(() => _userType = doc.data["category"]);
            if(_userType == "tenant"){
              Navigator.push(context, new MaterialPageRoute(
              builder: (BuildContext context) => Dashboard()));
            }
            if(_userType == "admin"){
              Navigator.push(context, new MaterialPageRoute(
              builder: (BuildContext context) => AdminDashboard()));
            }
          }
        });
        print(_userType);
      }});

  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        title: Text("Community"),
        backgroundColor: Colors.grey[850],
      ),
      body: Center(
        child: Container(
          decoration: BoxDecoration(

            image: DecorationImage(
              image: AssetImage("images/cityView.jpg"),
              fit: BoxFit.fill, //BoxFit.cover

            )

          ),
            padding: EdgeInsets.all(20.0),
            child: Form(
                child: Column(children: <Widget>[
                  SizedBox(height: 20.0),
                  Text(
                    'Welcome',
                    style: TextStyle(fontSize: 20),
                  ),
                  SizedBox(height: 20.0),
                  TextFormField(
                    onChanged: (value) => setState(()=>_email = value),
                    keyboardType: TextInputType.emailAddress,
                    decoration: InputDecoration(labelText: "Email Address")),
                  TextFormField(
                    onChanged: (value) => setState(()=>_password = value),
                    //obscureText: true,
                    decoration: InputDecoration(labelText: "Password")),
                    SizedBox(height: 20.0),
                  RaisedButton(
                    child: Text("LOGIN"),
                    textColor: Colors.white,
                    color: Colors.black54,
                    onPressed: () async {
                    await _auth.signInWithEmail(_email, _password).then((value){
                      _auth.getUser().then((value){
                      //will execute after response, value is response
                      //print(value);
                          if(value != null){
                            _userdb.document(value.uid).get().then((doc){
                              if(doc.exists){
                                setState(() => _userType = doc.data["category"]);
                                if(_userType == "tenant"){
                                  Navigator.push(context, new MaterialPageRoute(
                                  builder: (BuildContext context) => Dashboard()));
                                }
                                if(_userType == "admin"){
                                  Navigator.push(context, new MaterialPageRoute(
                                  builder: (BuildContext context) => AdminDashboard()));
                                }
                              }
                            });

                            print(_userType);
                          }
                        }
                      );
                      });
                    }),
                  RaisedButton(
                    child: Text("No account? Sign up!"),
                    textColor: Colors.blue,
                    color: Colors.white54,
                    onPressed: () {
                    Navigator.push(context, new MaterialPageRoute(
                        builder: (BuildContext context) => SignUp()));
                      },

                )]),
    ))));
  }
}