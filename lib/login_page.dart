import 'package:flutter/material.dart';
import 'package:flutter_loggin_test/auth.dart';

class LoginPage extends StatefulWidget {
  LoginPage({this.auth});
  final BaseAuth auth;

  @override
  State<StatefulWidget> createState() => new _loginPageState();
}

enum FormType {
  login,
  register
}

class _loginPageState extends State<LoginPage> {
  //Variables
  final formKey = new GlobalKey<FormState>();

  String _email;
  String _password;
  FormType _formType = FormType.login;

  //Saves the info to variables and confirms it
  bool validateAndSave(){
    final form = formKey.currentState;
    if (form.validate()){
      form.save();
      return true;
      // print('form is valid. Email: $_email, Password: $_password');
    }
    return false;
  }

  //Saves the info and signs in the user
  void validateAndSubmit() async {
    if(validateAndSave()){
      try{
        if(_formType == FormType.login){
          String userId = await widget.auth.signInWithEmailAndPassword(_email, _password);
          print('Signed in: $userId');
        }
        else{
          String userId = await widget.auth.createUserWithEmailAndPassword(_email, _password);
          print('Registered user: $userId');
        }
      }
      catch (e) {
        print('Errors: $e');
      }
    }
  }

  void moveToRegister(){
    formKey.currentState.reset();
    setState(() {
      _formType = FormType.register;     
    });
  }

  void moveToLogin(){
    formKey.currentState.reset();
    setState(() {
      _formType = FormType.login;     
    });
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
            children: buildInputs() + buildSubmitButtons(),
          ),
        ),
      ),
    );
  }

  List<Widget> buildInputs() {
    return [
      new TextFormField( 
        decoration: new InputDecoration(labelText: 'Email'), 
        validator: (value) => value.isEmpty ? 'Email can\'t be empty' : null,
        onSaved: (value) => _email = value, //saves in the variable the info
      ),
      new TextFormField( 
        decoration: new InputDecoration(labelText: 'Password'), 
        validator: (value) => value.isEmpty ? 'Password can\'t be empty' : null,
        onSaved: (value) => _password = value, //saves in the variable the info
        obscureText: true,
      ),
    ];
  }

  List<Widget> buildSubmitButtons(){
    if(_formType == FormType.login) {
      return [
        new RaisedButton(
          child: new Text('Login', style: new TextStyle(fontSize: 20.0)),
          onPressed: validateAndSubmit, //Calls the class/instance
        ),
        new FlatButton(
          child: new Text('Create an Account', style: new TextStyle(fontSize: 20.0)),
          onPressed: moveToRegister,
        ),
      ];
    }else {
      return [
        new RaisedButton(
          child: new Text('Create an Account', style: new TextStyle(fontSize: 20.0)),
          onPressed: validateAndSubmit, //Calls the class/instance
        ),
        new FlatButton(
          child: new Text('Have and Account? LogIn', style: new TextStyle(fontSize: 20.0)),
          onPressed: moveToLogin,
        ),
      ];
    }
  }
}

