import 'package:community_app/MyAccount.dart';
import 'package:community_app/ScheduleMaintenance.dart';
import 'package:flutter/material.dart';
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

  //MyItems method
  Material myItems(IconData icon, String heading, int color)
  {
    return Material(
      color: Colors.white,
      elevation: 14.0,
      shadowColor: Color(0xFF757575),//Color(0x802196F3),
      borderRadius: BorderRadius.circular(24.0),
      child: Center(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[

                      //text
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(heading,
                          style: TextStyle(
                            color: new Color(color),
                            fontSize: 15.0,
                          ),
                        ),
                      ),

                      //Icon
/*
                  new IconButton(
                    color: new Color(color),
                    padding: const EdgeInsets.all(16.0),
                    icon: Icon(icon, size: 30.0,),

                    onPressed: () {
                      // Interactivity or events codes here
                      Navigator.of(context).pop();
                      Navigator.push(context, new MaterialPageRoute(
                          builder: (BuildContext context) => Payment()));
                      print("hello");
                    },

                  ),
*/

                      Material(
                        color: new Color(color),
                        borderRadius: BorderRadius.circular(24.0),
                        child: Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: Icon(icon, color: Colors.white, size: 30.0,),
                        ),
                      ),

/*
                  MaterialButton(
                    color: new Color(color),
                      shape: RoundedRectangleBorder(borderRadius: new BorderRadius.circular(30.0)),
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Icon(icon, size: 30.0,),
                    ),
                    onPressed: ()
                    {
                        print("helloooooooooooooooooo");
                        // Interactivity or events codes here
                        Navigator.of(context).pop();
                        Navigator.push(context, new MaterialPageRoute(
                            builder: (BuildContext context) => Payment()));
                    },
                  ),
*/
                    ]
                )
              ]
          ),
        ),
      ),
    );
  }

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
        body: //_buildBody(context), //build dashboard

        StaggeredGridView.count(
          crossAxisCount: 2,
          crossAxisSpacing: 12.0,

          mainAxisSpacing: 12.0,
          padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
          children: <Widget>[

            myItems(Icons.account_circle, "Profile", 0xffed622b),
            myItems(Icons.notifications, "Notification", 0xffff3266, ),
            myItems(Icons.bookmark, "Appartment Info", 0xff26cb3c, ),
            myItems(Icons.attach_money, "Balance", 0xff3399fe, ),
            myItems(Icons.message, "Repair History", 0xff7297ff, ),
            myItems(Icons.payment, "Payment History", 0xff622F74, ),
            myItems(Icons.settings, "Settings", 0xfff4c83f,),
          ],

          staggeredTiles: [
            StaggeredTile.extent(2, 130.0),
            StaggeredTile.extent(1, 130.0),
            StaggeredTile.extent(1, 130.0),
            StaggeredTile.extent(1, 130.0),
            StaggeredTile.extent(1, 130.0),
            StaggeredTile.extent(1, 130.0),
            StaggeredTile.extent(1, 130.0),
          ],
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
        )
    );
  }
}

/*
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
  */


