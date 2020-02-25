import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import './payment.dart';

class Dashboard extends StatefulWidget {
  @override
  _DashboardState createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard>
{
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          // Here we take the value from the MyHomePage object that was created by
          // the App.build method, and use it to set our appbar title.
          title: Text('Community: Dashboard'),
        ),
        drawer: new Drawer(
            child: ListView(
                children: <Widget>[
                  new UserAccountsDrawerHeader(
                    accountName: new Text('Jon'),
                    accountEmail: new Text('testemail@test.com'),
                    currentAccountPicture: new CircleAvatar(
                      backgroundImage: new NetworkImage(''), //insert image link
                    ),
                  ),
                  new ListTile(
                    title: new Text('Make a payment'),
                    onTap: () {
                      Navigator.of(context).pop();
                      Navigator.push(context, new MaterialPageRoute(
                          builder: (BuildContext context) => new Payment()));
                    },
                  ),
                ]
            )
        )
    );
  }
}

