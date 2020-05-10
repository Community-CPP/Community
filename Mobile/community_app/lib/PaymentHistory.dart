import 'package:flutter/material.dart';

class PaymentHistory extends StatefulWidget{
  @override
  _PaymentHistory createState() => new _PaymentHistory();
}

class _PaymentHistory extends State<PaymentHistory>
{
  @override
  Widget build(BuildContext context){
    return new Scaffold(
      appBar: new AppBar(
        title: new Text('Payment History'),
        backgroundColor: Colors.black54,
      ),

      //body: ,
    );
  }
}