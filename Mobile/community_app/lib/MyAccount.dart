import 'package:flutter/material.dart';

class MyAccount extends StatefulWidget{
  @override
  _MyAccount createState() => new _MyAccount();
}

class _MyAccount extends State<MyAccount>{
  @override
  Widget build(BuildContext context){
    return new Scaffold(
      appBar: new AppBar(
        title: new Text('My Account'),
        backgroundColor: Colors.black54,
      ),
    );
  }
}