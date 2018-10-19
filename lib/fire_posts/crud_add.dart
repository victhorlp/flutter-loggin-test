import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'crud_post.dart';
// import 'dart:convert';

// Define a Custom Form Widget
class AddScore extends StatefulWidget {
  @override
  _AddScore createState() => _AddScore();
}


class _AddScore extends State<AddScore>{
  //Variables
  final GlobalKey<FormState> addCrudKey = GlobalKey<FormState>();
  final List<DocumentSnapshot> documents;
  _AddScore({this.documents});
  final _title_text = TextEditingController();
  final _num_value = TextEditingController();

  @override
  void dispose(){
    _title_text.dispose();
    _num_value.dispose();
    super.dispose();
  }

  void handleValidation() {
    final FormState form = addCrudKey.currentState;

    if (form.validate()) {
      Firestore.instance
        .runTransaction((Transaction transaction) async {
                  CollectionReference reference =
            Firestore.instance.collection('flutter_data');

        await reference
            .add({"title": _title_text.text.toString(), 
                  "editing": false, 
                  "score": int.parse(_num_value.text)});

        Navigator.pop(context);
      });
    }
  }

  Widget build(BuildContext context){
    return new Scaffold(
      appBar: AppBar( title: new Text('C-Firestore / CRUD ADD' ),),
      body: new Container(
        padding: new EdgeInsets.all(20.0),
        child: new Form(
         key: addCrudKey,
          child: ListTile(
            title: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(5.0),
                border: Border.all(color: Colors.white),
              ),
              padding: EdgeInsets.all(5.0),
              child: Column(
                children: <Widget>[
                    TextFormField(
                    decoration: new InputDecoration(labelText: 'Name'), 
                    controller: _title_text,
                    onSaved: (val) => _title_text.text = val,
                    // validator: (val) => val == "" ? val : null,
                    validator: (val) {
                      if(val.isEmpty){return 'It shouldn\'t be empty';}
                      else if (val.contains(' ')) {return 'There Shouldn\'t be any spaces';}
                      else{}
                    }
                  ),
                  TextFormField(
                    decoration: new InputDecoration(labelText: 'Score 0 out a 10'), 
                    controller: _num_value,
                    onSaved: (val) => _num_value.text = val,
                    // validator: (val) => val == "" ? val : null,
                    validator: (val) {
                      if(val.isEmpty){ return 'It can\'t stay blank'; }
                      else if (val.contains(' ')) {
                        return 'There Shouldn\'t be any spaces';
                      }
                      else if (int.parse(val) < 0 ||  int.parse(val) > 10) {
                        return 'Score can only be from 0 to 10'; 
                      }
                      else{}
                    }
                  ),
                  Container(
                    padding: new EdgeInsets.only(left:50.0, right: 50.0),
                    child: new RaisedButton(
                      child: Text('submit'),
                      onPressed: () { handleValidation(); })
                  ),
                ],
              ),
            ),
          ), 
        ),
      ),
    );
  }
}
