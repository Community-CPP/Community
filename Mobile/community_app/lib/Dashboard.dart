import 'package:community_app/MyAccount.dart';
import 'package:community_app/ScheduleMaintenance.dart';
import 'package:flutter/material.dart';
import 'package:community_app/Login.dart';
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
          title: Text('Community Dashboard'),
          backgroundColor: Colors.black54,
        ),
        body: _buildBody(context), //build dashboard
        drawer: new Drawer(
            child: ListView(
                children: <Widget>[
                  new UserAccountsDrawerHeader(
                    accountName: new Text('Jon'),
                    accountEmail: new Text('testemail@test.com'),
                    currentAccountPicture: new CircleAvatar(
                      backgroundImage: new NetworkImage(''), //insert image line
                    ),
                  ),
                  new ListTile(
                    title: new Text('Make a Payment'),
                    onTap: () {
                      Navigator.of(context).pop();
                      Navigator.push(context, new MaterialPageRoute(
                          builder: (BuildContext context) => new Payment()));
                    },
                  ),
                  new Divider(
                    color: Colors.black,
                    height: 5.0,
                  ),
                  new ListTile(
                    title: new Text('Schedule Maintenance'),
                    onTap: () {
                      Navigator.of(context).pop();
                      Navigator.push(context, new MaterialPageRoute(
                          builder: (BuildContext context) => new ScheduleMaintenance()));
                    },
                    ),
                  new Divider(
                    color: Colors.black,
                    height: 5.0,
                  ),
                  new ListTile(
                    title: new Text('My Account'),
                    onTap: () {
                      Navigator.of(context).pop();
                      Navigator.push(context, new MaterialPageRoute(
                          builder: (BuildContext context) => new MyAccount()));
                    },
                  ),
                  new Divider(
                    color: Colors.black,
                    height: 5.0,
                  ),
                  new ListTile(
                    title: new Text('Sign Out'),
                    onTap: () {
                      Navigator.of(context).pop();
                      Navigator.push(context, new MaterialPageRoute(
                          builder: (BuildContext context) => new Login()));
                    },
                  ),
                ]
            )
        )
    );
  }
}

  Widget _buildBody(BuildContext context)
  {
      return SingleChildScrollView(
        child: Column(
          children: <Widget>[
            const SizedBox(height: 30.0),
            Row(
              children: <Widget>[
                const SizedBox(width: 10.0),
                Expanded(
                  child: Column(
                    children: <Widget>[
                      Container(
                        height: 190,
                        color: Colors.blue,
                        child: Column(
                          crossAxisAlignment:
                            CrossAxisAlignment.start,
                          children: <Widget>[
                            ListTile(
                              title: Text("Notifications",),
                            ),
                            /*
                            Padding(
                              padding: const EdgeInsets.only(left:
                              16.0),
                              child: Text('Steps'),
                            ) */
                          ]
                        )
                      ),
                      const SizedBox(height: 10.0),
                      Container(
                          height: 120,
                          color: Colors.yellow,
                          child: Column(
                              crossAxisAlignment:
                              CrossAxisAlignment.start,
                              children: <Widget>[
                                ListTile(
                                  title: Text("Schedule History",),
                                ),
                              ]
                          )
                      ),
                    ]
                  )
                ),
                const SizedBox(width: 10.0),
                Expanded(
                    child: Column(
                        children: <Widget>[
                          Container(
                              height: 120,
                              margin: const EdgeInsets.only(right: 10.0),
                              color: Colors.green,
                              child: Column(
                                  crossAxisAlignment:
                                  CrossAxisAlignment.start,
                                  children: <Widget>[
                                    ListTile(
                                      title: Text("Payment History",),
                                    ),
                                  ]
                              )
                          ),
                          const SizedBox(height: 10.0),
                          Container(
                              height: 190,
                              margin: const EdgeInsets.only(right: 10.0),
                              color: Colors.red,
                              child: Column(
                                  crossAxisAlignment:
                                  CrossAxisAlignment.start,
                                  children: <Widget>[
                                    ListTile(
                                      title: Text("Apartment Info",),
                                    ),
                                  ]
                              )
                          ),
                        ]
                    )
                )
              ]
            )
          ]
        )
      );
  }