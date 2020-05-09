import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:community_app/MyAccount.dart';
import 'package:community_app/ScheduleMaintenance.dart';
import 'package:flutter/material.dart';
import 'package:community_app/Login.dart';
import 'package:flutter/cupertino.dart';
import './payment.dart';
import 'auth.dart';
import 'package:random_string/random_string.dart';
import 'dart:math';

import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

class AdminDashboard extends StatefulWidget {
  @override
  _AdminDashboardState createState() => _AdminDashboardState();
}

class _AdminDashboardState extends State<AdminDashboard>{
  AuthService _auth = new AuthService();
  
  //MyItems method
  GestureDetector myItems(IconData icon, String heading, int color,Function onTap)
  {
    return GestureDetector(
      onTap: onTap,
      child: Material(
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

                  MaterialButton(
                    color: new Color(color),
                      shape: RoundedRectangleBorder(borderRadius: new BorderRadius.circular(30.0)),
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Icon(icon, size: 30.0,),
                    ),
                  ),

                ]
              )
    ]
          ),
        ),
      ),
    ),
    );
  }
  var communitiesDB = Firestore.instance.collection('communities');
  var tokensDB = Firestore.instance.collection('tokens');

  void generateCommunity() {
    String name; String street; String city; int zip; int capacity;
    name="omar";
    street="123 Pedro st";
    city="pomona";
    zip=12345;
    capacity=100;

    print("beginning on tap");
    communitiesDB.add({
      'capacity':capacity,
      'city':city,
      'name':name,
      'street':street,
      'tenants':[],
      'tokenIDs':[],
      'zip':zip
    });

  }

  void generateToken(String commUID) async {
    String token = randomAlphaNumeric(8);
    var  date = DateTime.now();

    await tokensDB.document(token).get().then((doc) async {
      if(doc.exists) {
        generateToken(commUID);
      }
      else {
        var tokenIDs = [];
      // get current list
      await communitiesDB.document(commUID).get().then((doc){
          if(doc.data['tokenIDs'].length > 0) {
            tokenIDs = doc.data['tokenIDs'];
          }
        });

      //push new token
      tokenIDs.add(token);

      // update community token ids
      await communitiesDB.document(commUID).updateData({
        'tokenIDs':tokenIDs
      });

      // update tokens db
      await tokensDB.document(token).setData({
        'community': commUID,
        'time': date,
        'inuse': false,
      });
      }
    });


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
      appBar: AppBar(),
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
      body: Column(
        children: <Widget>[
          
          Expanded(
            child: Container(
              color: Colors.teal[200],
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
                      generateCommunity();

                    },
              child: ClipRRect(
                borderRadius: BorderRadius.circular(8.0),
                child: Container(
                  padding: const EdgeInsets.all(2),
                  color: Colors.teal[500],
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
                      //generateToken("eIHKllJbs790GyrqDudf");
                      },

                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(8.0),
                        child: Container(
                          padding: const EdgeInsets.all(2),
                          color: Colors.teal[500],
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

                    },
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(8.0),
                      child: Container(
                        padding: const EdgeInsets.all(2),
                        color: Colors.teal[500],
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
                    onTap: () { },

                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(8.0),
                        child: Container(
                          padding: const EdgeInsets.all(2),
                          color: Colors.teal[500],
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
                    onTap: () { },

                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(8.0),
                        child: Container(
                          padding: const EdgeInsets.all(2),
                          color: Colors.teal[500],
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
                    onTap: () { },

                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(8.0),
                        child: Container(
                          padding: const EdgeInsets.all(2),
                          color: Colors.teal[500],
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
                    onTap: () { },
                    child: Container(
                      width: 100,
                      //padding: const EdgeInsets.all(2),
                      color: Colors.teal[200],
                    ),
                  ),


                  GestureDetector(
                    onTap: () { },

                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(8.0),
                      child: Container(
                        padding: const EdgeInsets.all(2),
                        color: Colors.teal[500],
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


                  GestureDetector(
                    onTap: () { },
                    child: Container(
                      padding: const EdgeInsets.all(2),
                      color: Colors.teal[200],
                    ),
                  ),



                ],
              ),
            ),
          ),
          
        ],
      ),
      
    );
  }
}