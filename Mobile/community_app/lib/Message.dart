import 'package:flutter/material.dart';

class Message extends StatefulWidget{
  @override
  _Message createState() => new _Message();
}

class _Message extends State<Message>
{
  @override
  Widget build(BuildContext context){
    return new Scaffold(
      appBar: new AppBar(
        title: new Text('Message'),
        backgroundColor: Colors.black54,
      ),

      //body: ,
    );
  }
}