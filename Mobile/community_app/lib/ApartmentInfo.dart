import 'package:flutter/material.dart';

class ApartmentInfo extends StatefulWidget{
  @override
  _ApartmentInfo createState() => new _ApartmentInfo();
}

class _ApartmentInfo extends State<ApartmentInfo>
{
  @override
  Widget build(BuildContext context){
    return new Scaffold(
      appBar: new AppBar(
        title: new Text('Apartment Information'),
        backgroundColor: Colors.black54,
      ),

      //body: ,
    );
  }
}