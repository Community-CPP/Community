import 'package:flutter/material.dart';

class AdminAccount extends StatefulWidget{
  @override
  _AdminAccount createState() => new _AdminAccount();
}

class _AdminAccount extends State<AdminAccount>{
  @override
  Widget build(BuildContext context){
    return new Scaffold(
        appBar: new AppBar(
          title: new Text('My Account'),
          backgroundColor: Colors.black54,
        ),

        body: new Stack(
          children: <Widget>[
            ClipPath(
              child: Container(color: Colors.black.withOpacity(0.20)),
              clipper: getClipper(),
            ),
            Positioned(
                width: 350.0,
                top: MediaQuery.of(context).size.height / 5,
                child: Column(
                  children: <Widget>[
                    Container(
                        width: 140.0,
                        height: 140.0,
                        decoration: BoxDecoration(
                            color: Colors.grey,
                            image: DecorationImage(
                                image: NetworkImage(''), //Profile image jpg
                                fit: BoxFit.cover),
                            borderRadius: BorderRadius.all(Radius.circular(75.0)),
                            boxShadow: [
                              BoxShadow(blurRadius: 7.0, color: Colors.black)
                            ])),
                    SizedBox(height: 40.0),
                    Text(
                      'Admin Name',
                      style: TextStyle(
                          fontSize: 30.0,
                          fontWeight: FontWeight.bold,
                          fontFamily: 'Montserrat'),
                    ),
                    SizedBox(height: 15.0),
                    Text(
                      'Company Name',
                      style: TextStyle(
                          fontSize: 17.0,
                          fontStyle: FontStyle.italic,
                          fontFamily: 'Montserrat'),
                    ),
                    SizedBox(height: 15.0),
                    Text(
                      'Location',
                      style: TextStyle(
                          fontSize: 17.0,
                          fontStyle: FontStyle.italic,
                          fontFamily: 'Montserrat'),
                    ),
                    SizedBox(height: 25.0),
                    Container(
                        height: 30.0,
                        width: 95.0,
                        child: Material(
                          borderRadius: BorderRadius.circular(20.0),
                          shadowColor: Colors.greenAccent,
                          color: Colors.green,
                          elevation: 7.0,
                          child: GestureDetector(
                            onTap: () {},
                            child: Center(
                              child: Text(
                                'Edit',
                                style: TextStyle(color: Colors.white, fontFamily: 'Montserrat'),
                              ),
                            ),
                          ),
                        )),

                  ],
                ))
          ],
        ));
  }
}

class getClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    var path = new Path();

    path.lineTo(0.0, size.height / 1.9);
    path.lineTo(size.width + 200, 0.0);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) {
    // TODO: implement shouldReclip
    return true;
  }
}