import 'package:flutter/material.dart';
import 'dart:async';

class ScheduleMaintenance extends StatefulWidget{
  @override
  _ScheduleMaintenance createState() => new _ScheduleMaintenance();
}

class _ScheduleMaintenance extends State<ScheduleMaintenance>{
  int selectedRadio;
  int selectedRadioTile;

  DateTime _dateTime;
  TimeOfDay _time = new TimeOfDay.now();

  Future<Null> selectTime(BuildContext context) async{
    final TimeOfDay picked = await showTimePicker(
      context: context,
      initialTime: _time,
    );

    if(picked != null && picked != _time){
      print('Time selected: ${_time.toString()}');
      setState(() {
        _time = picked;
      });
    }
  }


  @override
  void initState(){
    super.initState();
    selectedRadio = 0;
    selectedRadioTile = 0;
  }
  setSelectedRadio(int val){
    setState(() {
      selectedRadio = val;
    });
  }
  setSelectedRadioTile(int val){
    setState(() {
      selectedRadioTile = val;
    });
  }
  @override
  Widget build(BuildContext context){
    return new Scaffold(
      appBar: new AppBar(
        title: new Text('Schedule Maintenance'),
        backgroundColor: Colors.black54,
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          RadioListTile(
            value: 1,
            groupValue: selectedRadioTile,
            title: Text("Electricity"),
            onChanged: (val){
              print("Electricity selected $val");
              setSelectedRadioTile(val);
            },
          selected: false,
            activeColor: Colors.black,
          ),
          RadioListTile(
            value: 2,
            groupValue: selectedRadioTile,
            title: Text("Plumbing"),
            onChanged: (val){
              print("Plumbing Selected $val");
              setSelectedRadioTile(val);
            },
            selected: false,
            activeColor: Colors.black,
          ),
          RadioListTile(
            value: 3,
            groupValue: selectedRadioTile,
            title: Text("Heater/Air Conditioner"),
            onChanged: (val){
              print("Heater/Air Conditioner selected $val");
              setSelectedRadioTile(val);
            },
            selected: false,
            activeColor: Colors.black,
          ),
          RadioListTile(
            value: 4,
            groupValue: selectedRadioTile,
            title: Text("Flooring"),
            onChanged: (val){
              print("Flooring pressed $val");
              setSelectedRadioTile(val);
            },
            selected: false,
            activeColor: Colors.black,
          ),
          RadioListTile(
            value: 5,
            groupValue: selectedRadioTile,
            title: Text("Other"),
            onChanged: (val){
              print("other selected $val");
              setSelectedRadioTile(val);
            },
            selected: false,
            activeColor: Colors.black,
          ),
          TextField(
            decoration: new InputDecoration(
              hintText: "Comment",
              hintStyle: TextStyle(fontSize: 12.0, color: Colors.black54),
            ),
          ),
          Text(_dateTime == null ? 'Nothing has been picked yet': _dateTime.toString()),
          RaisedButton(
            child: Text('Pick a date'),
            onPressed: (){
              showDatePicker(
                  context: context,
                  initialDate: DateTime.now(),
                  firstDate: DateTime(2016),
                  lastDate: DateTime(2022)
              ).then((date){
                    setState((){
                      _dateTime = date;
                    });
              }
              );
            },
          ),
          new Text(''),
          new Text('Time selected: ${_time.toString()}'),
          new RaisedButton(
            child: new Text('Select Time'),
            onPressed: (){selectTime(context);},
          ),
          new Text(''),
          new RaisedButton(
              child: new Text('Submit'),
            onPressed: (){},
          )
        ]
      )

    );
  }
}