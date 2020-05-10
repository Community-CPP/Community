import 'package:flutter/material.dart';

class Notifications extends StatefulWidget{
  @override
  _Notifications createState() => new _Notifications();
}

class _Notifications extends State<Notifications>
{
  @override
  Widget build(BuildContext context){
    return new Scaffold(
        appBar: new AppBar(
          title: new Text('Notifications'),
          backgroundColor: Colors.black54,
        ),

        //body: ,
        );
  }
}