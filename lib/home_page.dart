import 'package:flutter/material.dart';
import 'package:flutter_loggin_test/auth.dart';
import 'fire_posts/simple_post.dart';

//==========================| The APP |========================================|
class HomePage extends StatelessWidget {
  HomePage({this.auth, this.onSignedOut});
  final BaseAuth auth;
  final VoidCallback onSignedOut;

  void _signOut() async {
    try{
      await auth.signOut();
      onSignedOut();
    }catch (e){
      print(e);
    }
  }

//======================| Body |==================================|
  @override
  Widget build(BuildContext context){
    return new Scaffold(
      appBar: new AppBar(
        title: new Text('Welcome'),
        actions: <Widget>[
          new FlatButton(
            child: new Text('Logout', style: new TextStyle(fontSize: 17.0, color: Colors.white)),
            onPressed: _signOut,
          )
        ],
      ),
      body: new Container(
        padding: new EdgeInsets.all(30.0),
        child: new ListView(
          children: <Widget>[
            // |================================> Simple Post / realtime
            new RaisedButton(
              padding: new EdgeInsets.all(20.0),
              color: Colors.yellow[800],
              splashColor: Colors.yellow[300],
              child: Text('Simple Post with realtime db',
                      style: TextStyle(fontSize: 20.0),),
              onPressed: () {Navigator.push(context, 
                new MaterialPageRoute(builder: (context) => new SimplePost()));
              },
            ),
            new Opacity(
              opacity: 0.0,
              child: new Text('Empty here'),
            ),
            // |================================> CRUD Post / Cloud Firestore
            new RaisedButton(
              padding: new EdgeInsets.all(20.0),
              color: Colors.red[800],
              splashColor: Colors.yellow[300],
              child: Text('Cloud Firestore db CRUD',style: TextStyle(
                fontSize: 20.0, 
                color: Colors.white),),
              onPressed: () {  },
            ),
            new Opacity(
              opacity: 0.0,
              child: new Text('Empty here'),
            ),
            // |================================> Image Post / Cloud FireStore
            new RaisedButton(
              padding: new EdgeInsets.all(20.0),
              color: Colors.red[800],
              splashColor: Colors.red[300],
              child: Text('Image Upload',style: TextStyle(
                fontSize: 20.0, 
                color: Colors.white
                ),),
              onPressed: () {},
            ),
            new Opacity(
              opacity: 0.0,
              child: new Text('Empty here'),
            ),
            // |================================> chat?
            new Opacity(
              opacity: 0.2,
              child: new RaisedButton(
                padding: new EdgeInsets.all(20.0),
                color: Colors.black87,
                splashColor: Colors.red[300],
                child: Text('Chat? (undecided)',style: TextStyle(
                  fontSize: 20.0, 
                  color: Colors.white
                  ),),
                onPressed: () {},
              ),
            ),
            new Opacity(
              opacity: 0.0,
              child: new Text('Empty here'),
            ),
            // |================================> Yet to decide / unused
            new Opacity(
              opacity: 0.2,
              child: new RaisedButton(
                padding: new EdgeInsets.all(20.0),
                color: Colors.black87,
                splashColor: Colors.red[300],
                child: Text('Upcomming page',style: TextStyle(
                  fontSize: 20.0, 
                  color: Colors.white
                  ),),
                onPressed: () {},
              ),
            ),
          ],
        ),
      ),
    );
  }
//======================| END body |==================================|
}
//========================| END The APP |=====================================|

      // body: new Container(
      //   child: new Container(
      //     child: new Center(
      //       child: new Text('Welcome', style: new TextStyle(fontSize: 32.0))
      //     ),
      //   )
      // ),
