import 'package:flutter/material.dart';
import 'package:flutter_loggin_test/login_page.dart';
import 'package:flutter_loggin_test/auth.dart';

enum AuthStatus {
  notSignedIn,
  signedIn
}

class RootPage extends StatefulWidget {
  RootPage({this.auth});
  final BaseAuth auth;

  @override
  State<StatefulWidget> createState() => new _RootPageState();
}

class _RootPageState extends State<RootPage> {
  AuthStatus authStatus = AuthStatus.notSignedIn;

  @override
  void initState() {
    super.initState();
    //Check the current status of the user
    widget.auth.currentUser().then((userId){
      setState(() {
        // authStatus = userId == null ? AuthStatus.notSignedIn : AuthStatus.signedIn;
      });
    });
  }

  void _signedIn() {
    setState(() {
      authStatus = AuthStatus.signedIn;
    });
  } 

  @override
  Widget build(BuildContext context){
    switch (authStatus) {
      case AuthStatus.notSignedIn:
        return new LoginPage(
          auth: widget.auth,
          onSignedIn: _signedIn,
        );
      case AuthStatus.signedIn:
        return new Scaffold(
          body: new Container(
            child: new Text('Hello Govner!')
          )
        );
    }
  }
}


