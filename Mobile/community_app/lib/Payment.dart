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
        backgroundColor: Colors.black54,
      ),
        body: ListView(
            children: <Widget>[
              ListTile(
                leading: Icon(Icons.map),
                title: Text('One-time payment'),
              ),
              new Divider(
                color: Colors.black,
                height: 5.0,
              ),
              ListTile(
                  leading: Icon(Icons.map),
                  title: Text('use my card')
              ),
              new Divider(
                color: Colors.black,
                height: 5.0,
              ),
              ListTile(
                  leading: Icon(Icons.map),
                  title: Text('in-progress...API')
              )
            ])
    );
  }
}