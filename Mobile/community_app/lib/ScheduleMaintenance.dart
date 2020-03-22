import 'package:flutter/material.dart';

class ScheduleMaintenance extends StatefulWidget{
  @override
  _ScheduleMaintenance createState() => new _ScheduleMaintenance();
}

class _ScheduleMaintenance extends State<ScheduleMaintenance>{
  int selectedRadio;
  int selectedRadioTile;

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
        ]
      )

    );
  }
}