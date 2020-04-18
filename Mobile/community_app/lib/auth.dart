import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'user.dart';

class AuthService {

  final FirebaseAuth _auth = FirebaseAuth.instance;

  Future<User> getUser() async {
    var user = await _auth.currentUser();
    return _userFromFirebase(user);
  }

  // create user from firebase user
  User _userFromFirebase(FirebaseUser user) {
    return user != null ? User(uid:user.uid) : null;
  }
  // sign in /w email and pass
  Future signInWithEmail(String email, String password) async {
    print(email);
    print(password);
    try {
      AuthResult result = await _auth.signInWithEmailAndPassword(email: email, password: password);
      FirebaseUser user = result.user;
      return _userFromFirebase(user);
    }
    catch(e) {
      print(e.toString());
      return null;
    }
  }
// register w/ email and pass
  Future registerWithEmail(String email, String password, String fname, String lname, String category) async {
    print(email);
    print(password);
    print(fname);
    print(lname);
    print(category);
    try {
      AuthResult result = await _auth.createUserWithEmailAndPassword(email: email, password: password);
      FirebaseUser user = result.user;
      //await  DatabaseService(uid: user.uid).setUserData(fname, lname,user.email,0);
      Firestore.instance.collection('users').document(user.uid).setData({
      'category' : category,
      'first' : fname,
      'last' : lname,
      'email' : email,
      //'favoriteSpots' : <String>[],
      //'mySpots' : <String>[],
    });
      return _userFromFirebase(user);
    }
    catch(e) {
      print(e.toString());
      return null;
    }
  }

  // sign out
  Future signOut() async {
    print("check sign out");
    try {
      return await _auth.signOut();
    }
    catch(e) {
      print(e.toString());
      return null;
    }
  }

}



