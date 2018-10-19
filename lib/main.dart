import 'package:flutter/material.dart';
import 'package:flutter_loggin_test/login_page.dart';
import 'package:flutter_loggin_test/auth.dart';
import 'package:flutter_loggin_test/root_page.dart';

void main() {
  runApp(new MyApp());
}

class MyApp extends StatelessWidget {

  @override
  Widget build(BuildContext context){
    return new MaterialApp(
      debugShowCheckedModeBanner: false,
      title: "Flutter log in demo",
      theme: new ThemeData(
        primarySwatch: Colors.red,
      ),
      home: new RootPage(auth: new Auth())
    );
  }
}


