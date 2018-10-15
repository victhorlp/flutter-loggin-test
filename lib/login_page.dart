import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

class LoginPage extends StatefulWidget {

  @override
  State<StatefulWidget> createState() => new _loginPageState();
}

class _loginPageState extends State<LoginPage> {
  //Variables
  final formKey = new GlobalKey<FormState>();

  String _email;
  String _password;

  bool validateAndSave(){
    final form = formKey.currentState;
    if (form.validate()){
      form.save();
      return true;
      // print('form is valid. Email: $_email, Password: $_password');
    }
    return false;
  }

  void validateAndSubmit() {
    if(validateAndSave()){

    }
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(title: new Text('Flutter login demo'), ),
      body: new Container(
        padding: EdgeInsets.all(16.0),
        child: new Form(
          key: formKey,
          child: new Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              new TextFormField( 
                decoration: new InputDecoration(labelText: 'Email'), 
                validator: (value) => value.isEmpty ? 'Email can\'t be empty' : null,
                onSaved: (value) => _email = value,
              ),
              new TextFormField( 
                decoration: new InputDecoration(labelText: 'Password'), 
                validator: (value) => value.isEmpty ? 'Password can\'t be empty' : null,
                onSaved: (value) => _password = value,
                obscureText: true,
              ),
              new RaisedButton(
                child: new Text('Login', style: new TextStyle(fontSize: 20.0)),
                onPressed: validateAndSubmit,
              ),
            ],
          ),
        ),
      ),
    );
  }  
}

