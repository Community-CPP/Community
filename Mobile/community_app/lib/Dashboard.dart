import 'package:community_app/MyAccount.dart';
import 'package:community_app/ScheduleMaintenance.dart';
import 'package:flutter/material.dart';
import 'package:community_app/Notifications.dart';
import 'package:community_app/ApartmentInfo.dart';
import 'package:community_app/Balance.dart';
import 'package:community_app/PaymentHistory.dart';
import 'package:community_app/RepairHistory.dart';
import 'package:community_app/Message.dart';
import 'package:community_app/Events.dart';
import 'package:community_app/Settings.dart';
import 'package:community_app/Login.dart';
import 'package:flutter/cupertino.dart';
import './payment.dart';
import 'auth.dart';

import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

class Dashboard extends StatefulWidget {
  @override
  _DashboardState createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard>{
  AuthService _auth = new AuthService();

  @override
  Widget build(BuildContext context) {
    _auth.getUser().then((value){
      //will execute after response, value is response
      //print(value);
      if(value == null){
        Navigator.pop(context);
      }
    });
    return Scaffold(
        appBar: AppBar(
          // Here we take the value from the MyHomePage object that was created by
          // the App.build method, and use it to set our appbar title.
          title: Text('Dashboard'),
          backgroundColor: Colors.black54,
        ),

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
                    onTap: (){
                      _auth.signOut();
                      Navigator.popUntil(context, (Route<dynamic> route) => route.isFirst);
                      //Navigator.of(context).pop();
                      //Navigator.push(context, new MaterialPageRoute(
                      //builder: (BuildContext context) => new Login()));
                    },
                  ),
                ]
            )
        ),
        body: //_buildBody(context), //build dashboard
        Column(
          children: <Widget>[

            Expanded(
              child: Container(
                //color: Colors.teal[200],
                color: Colors.grey,
                height: MediaQuery.of(context).size.height/1.5,
                child: GridView.count(
                  primary: false,
                  padding: EdgeInsets.all(10),
                  crossAxisSpacing: 5,
                  mainAxisSpacing: 5,
                  crossAxisCount: 3,
                  children: <Widget>[
                    GestureDetector(
                        onTap: () {
                          Navigator.push(context, new MaterialPageRoute(
                              builder: (BuildContext context) => new Notifications()));
                        },
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(8.0),
                          child: Container(
                            padding: const EdgeInsets.all(2),
                            //color: Colors.teal[500],
                            color: Colors.blueGrey[800],
                            alignment: Alignment.center,
                            child: Container(
                              //color: Colors.brown,
                              child: Column(

                                  mainAxisAlignment: MainAxisAlignment.center,
                                  // mainAxisSize: MainAxisSize.min,

                                  children: <Widget>[
                                    Container(child: Icon(Icons.notifications, color: Colors.white), alignment: Alignment.center,),
                                    Container(child: Text("Notifications", style: TextStyle(color: new Color(0xFFFFFFFF),fontSize: 15.0),)),

                                  ]),
                            ),
                          ),
                        )
                    ),

                    GestureDetector(
                        onTap: ()
                        {
                          Navigator.push(context, new MaterialPageRoute(
                              builder: (BuildContext context) => new MyAccount()));
                        },

                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(8.0),
                          child: Container(
                            padding: const EdgeInsets.all(2),
                            color: Colors.blueGrey[800],
                            alignment: Alignment.center,
                            child: Container(
                              //color: Colors.brown,
                              child: Column(

                                  mainAxisAlignment: MainAxisAlignment.center,
                                  // mainAxisSize: MainAxisSize.min,

                                  children: <Widget>[
                                    Container(child: Icon(Icons.account_circle, color: Colors.white), alignment: Alignment.center,),
                                    Container(child: Text("Profile", style: TextStyle(color: new Color(0xFFFFFFFF),fontSize: 15.0),)),

                                  ]),
                            ),
                          ),
                        )
                    ),


                    GestureDetector(
                        onTap: ()
                        {
                          Navigator.push(context, new MaterialPageRoute(
                              builder: (BuildContext context) => new ApartmentInfo()));
                        },
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(8.0),
                          child: Container(
                            padding: const EdgeInsets.all(2),
                            color: Colors.blueGrey[800],
                            alignment: Alignment.center,
                            child: Container(
                              //color: Colors.brown,
                              child: Column(

                                  mainAxisAlignment: MainAxisAlignment.center,
                                  // mainAxisSize: MainAxisSize.min,

                                  children: <Widget>[
                                    Container(child: Icon(Icons.info, color: Colors.white), alignment: Alignment.center,),
                                    Container(child: Text("Apartment Info", style: TextStyle(color: new Color(0xFFFFFFFF),fontSize: 15.0),)),
                                  ]),
                            ),
                          ),
                        )
                    ),
                    GestureDetector(
                      onTap: () {
                        Navigator.push(context, new MaterialPageRoute(
                            builder: (BuildContext context) => new Balance()));
                      },

                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(8.0),
                        child: Container(
                          padding: const EdgeInsets.all(2),
                          color: Colors.blueGrey[800],
                          alignment: Alignment.center,
                          child: Container(
                            //color: Colors.brown,
                            child: Column(

                                mainAxisAlignment: MainAxisAlignment.center,
                                // mainAxisSize: MainAxisSize.min,

                                children: <Widget>[
                                  Container(child: Icon(Icons.account_balance, color: Colors.white), alignment: Alignment.center,),
                                  Container(child: Text("Balance", style: TextStyle(color: new Color(0xFFFFFFFF),fontSize: 15.0),)),

                                ]),
                          ),
                        ),
                      ),

                    ),
                    GestureDetector(
                      onTap: () {
                        Navigator.push(context, new MaterialPageRoute(
                            builder: (BuildContext context) => new RepairHistory()));
                      },

                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(8.0),
                        child: Container(
                          padding: const EdgeInsets.all(2),
                          color: Colors.blueGrey[800],
                          alignment: Alignment.center,
                          child: Container(
                            //color: Colors.brown,
                            child: Column(

                                mainAxisAlignment: MainAxisAlignment.center,
                                // mainAxisSize: MainAxisSize.min,

                                children: <Widget>[
                                  Container(child: Icon(Icons.history, color: Colors.white), alignment: Alignment.center,),
                                  Container(child: Text("Repair History", style: TextStyle(color: new Color(0xFFFFFFFF),fontSize: 15.0),)),

                                ]),
                          ),
                        ),
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        Navigator.push(context, new MaterialPageRoute(
                            builder: (BuildContext context) => new PaymentHistory()));
                      },

                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(8.0),
                        child: Container(
                          padding: const EdgeInsets.all(2),
                          color: Colors.blueGrey[800],
                          alignment: Alignment.center,
                          child: Container(
                            //color: Colors.brown,
                            child: Column(

                                mainAxisAlignment: MainAxisAlignment.center,
                                // mainAxisSize: MainAxisSize.min,

                                children: <Widget>[
                                  Container(child: Icon(Icons.receipt, color: Colors.white), alignment: Alignment.center,),
                                  Container(child: Text("Payment History", style: TextStyle(color: new Color(0xFFFFFFFF),fontSize: 15.0),)),

                                ]),
                          ),
                        ),
                      ),
                    ),


                    GestureDetector(
                      onTap: () {
                        Navigator.push(context, new MaterialPageRoute(
                            builder: (BuildContext context) => new Message()));
                      },
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(8.0),
                        child: Container(
                          padding: const EdgeInsets.all(2),
                          color: Colors.blueGrey[800],
                          alignment: Alignment.center,

                          child: Container(
                            //color: Colors.brown,
                            child: Column(

                                mainAxisAlignment: MainAxisAlignment.center,
                                // mainAxisSize: MainAxisSize.min,

                                children: <Widget>[
                                  Container(child: Icon(Icons.message, color: Colors.white), alignment: Alignment.center,),
                                  Container(child: Text("Message", style: TextStyle(color: new Color(0xFFFFFFFF),fontSize: 15.0),)),

                                ]),
                          ),
                        ),
                      ),
                    ),


                    GestureDetector(
                      onTap: () {
                        Navigator.push(context, new MaterialPageRoute(
                            builder: (BuildContext context) => new Events()));
                      },

                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(8.0),
                        child: Container(
                          padding: const EdgeInsets.all(2),
                          color: Colors.blueGrey[800],
                          alignment: Alignment.center,

                          child: Container(
                            //color: Colors.brown,
                            child: Column(

                                mainAxisAlignment: MainAxisAlignment.center,
                                // mainAxisSize: MainAxisSize.min,

                                children: <Widget>[
                                  Container(child: Icon(Icons.event, color: Colors.white), alignment: Alignment.center,),
                                  Container(child: Text("Events", style: TextStyle(color: new Color(0xFFFFFFFF),fontSize: 15.0),)),

                                ]),
                          ),
                        ),
                      ),
                    ),


                    GestureDetector(
                      onTap: ()
                      {
                        Navigator.push(context, new MaterialPageRoute(
                            builder: (BuildContext context) => new Settings()));
                      },

                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(8.0),
                        child: Container(
                          padding: const EdgeInsets.all(2),
                          color: Colors.blueGrey[800],
                          alignment: Alignment.center,

                          child: Container(
                            //color: Colors.brown,
                            child: Column(

                                mainAxisAlignment: MainAxisAlignment.center,
                                // mainAxisSize: MainAxisSize.min,

                                children: <Widget>[
                                  Container(child: Icon(Icons.settings, color: Colors.white), alignment: Alignment.center,),
                                  Container(child: Text("Settings", style: TextStyle(color: new Color(0xFFFFFFFF),fontSize: 15.0),)),

                                ]),
                          ),
                        ),
                      ),
                    ),
                    /*
                  GestureDetector(
                    onTap: () { },
                    child: Container(
                      padding: const EdgeInsets.all(2),
                      color: Colors.teal[200],
                    ),
                  ),
*/


                  ],
                ),
              ),
            ),

          ],
        ),
    );
  }
}


