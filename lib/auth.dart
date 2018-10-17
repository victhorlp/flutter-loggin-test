import 'dart:async';
import 'package:firebase_auth/firebase_auth.dart';

abstract class BaseAuth {
  Future<String> signInWithEmailAndPassword(String email, String password);
  Future<String> createUserWithEmailAndPassword(String email, String password);
  Future<String> currentUser();
  Future<void> signOut();
}

class Auth implements BaseAuth{
  //variable
  final FirebaseAuth _fireAuth = FirebaseAuth.instance;

  Future<String> signInWithEmailAndPassword(String email, String password) async {
    FirebaseUser user = await _fireAuth.signInWithEmailAndPassword(email: email, password: password);
    print(user);
    return user.uid;
  }

  Future<String> createUserWithEmailAndPassword(String email, String password) async {
    FirebaseUser user = await _fireAuth.createUserWithEmailAndPassword(email: email, password: password);
    return user.uid;
  }

  Future<String> currentUser() async {
    FirebaseUser user = await _fireAuth.currentUser();
    if (user != null){
      return user.uid;
    } else {
      return null;
    }
  }

  Future<void> signOut() async {
    await _fireAuth.signOut();
  }
}
