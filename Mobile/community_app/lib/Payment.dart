import 'package:flutter/material.dart';

class Payment extends StatefulWidget{
  @override
  _Payment createState() => new _Payment();
}

class _Payment extends State<Payment>{
  @override
  Widget build(BuildContext context){
    return new Scaffold(
      appBar: new AppBar(
        title: new Text('Make a payment'),
      ),
    );
  }
}