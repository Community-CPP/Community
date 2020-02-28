import 'package:flutter/material.dart';

class ScheduleMaintenance extends StatefulWidget{
  @override
  _ScheduleMaintenance createState() => new _ScheduleMaintenance();
}

class _ScheduleMaintenance extends State<ScheduleMaintenance>{
  @override
  Widget build(BuildContext context){
    return new Scaffold(
      appBar: new AppBar(
        title: new Text('Schedule Maintenance'),
        backgroundColor: Colors.black54,
      ),
    );
  }
}