// import 'dart:async';
import 'package:flutter/material.dart';
// import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'crud_add.dart';

//==========================| The APP Part1|========================================|

class CrudItem extends StatelessWidget {
  //======================| Body |==================================|
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar( title: new Text('C-Firestore / CRUD Demo'), ), 
      body: StreamBuilder(
        stream: Firestore.instance.collection('flutter_data').snapshots(),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (!snapshot.hasData) return CircularProgressIndicator();
          return SimplePostThenView(documents: snapshot.data.documents);
        },
      ),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add, size: 48.0,),
        backgroundColor: Colors.red,
        onPressed: () { Navigator.push(context, 
              new MaterialPageRoute(builder: (context) => new AddScore())); },
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: BottomAppBar(
        color: Colors.black87,
        child: new Row(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            new Opacity(
              opacity: 0.0,
              child: new IconButton(
                icon: new Icon(Icons.add_alert),
                iconSize: 36.0,
                color: Colors.red,
                onPressed: () {},
              ),
            ),
          ],
        ),
      ),
    );
  }
  //======================| End Body |==================================|

}

//==========================| The APP Part2|========================================|
class SimplePostThenView extends StatelessWidget {
  final List<DocumentSnapshot> documents;

  SimplePostThenView({this.documents});

//======================| Body |==================================|
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: documents.length,
      itemExtent: 110.0,
      itemBuilder: (BuildContext context, int index) {
        String title = documents[index].data['title'].toString();
        int score = documents[index].data['score'];
        return ListTile(
            title: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(5.0),
                border: Border.all(color: Colors.black45),
              ),
              padding: EdgeInsets.all(5.0),
              child: Row(
                children: <Widget>[
                  Expanded(
                    child: !documents[index].data['editing']
                        ? Text(title)
                        : TextFormField(
                            initialValue: title,
                            onFieldSubmitted: (String item) { 
                              handleTextEditingValidation(index, item); },
                          ),
                  ),
                  Text("$score"),
                  Column(
                    children: <Widget>[
                      IconButton(
                        onPressed: () { handleAddScoreValidation(index); },
                        icon: Icon(Icons.arrow_upward),
                      ),
                      IconButton(
                        onPressed: () { handleRemoveScoreValidation(index); },
                        icon: Icon(Icons.arrow_downward),
                      ),
                    ],
                  ),
                  IconButton(
                    icon: Icon(Icons.delete),
                    onPressed: () { handleDeleteAlert(index, context); },
                  )
                ],
              ),
            ),
            onTap: () => Firestore.instance
                    .runTransaction((Transaction transaction) async {
                  DocumentSnapshot snapshot =
                      await transaction.get(documents[index].reference);

                  await transaction.update(
                      snapshot.reference, {"editing": !snapshot["editing"]});
                }));
      },
    );
  }
//======================| END Body |==================================|

//==================| Body PARTS / Validations|=======================|
  // Text editing
  void handleTextEditingValidation(var index, String item){
    Firestore.instance.runTransaction((transaction) async {
      DocumentSnapshot snapshot = await transaction.get(documents[index].reference);
      await transaction.update( snapshot.reference, {'title': item});
      await transaction.update(snapshot.reference, {"editing": !snapshot['editing']});
    });
  }
  // Add Score
  void handleAddScoreValidation( var index){
    Firestore.instance.runTransaction((Transaction transaction) async {
      DocumentSnapshot snapshot = await transaction.get(documents[index].reference);
      if(snapshot['score'] == 10){
        await transaction.update(snapshot.reference,
          {'score': snapshot['score'] + 0});
      }else{
        await transaction.update(snapshot.reference,
          {'score': snapshot['score'] + 1});
      }
    });
  }
  // Remove Score
  void handleRemoveScoreValidation( var index){
    Firestore.instance.runTransaction((Transaction transaction) async {
      DocumentSnapshot snapshot = await transaction.get(documents[index].reference);
      if(snapshot['score'] == 0){
        await transaction.update(snapshot.reference, {'score': snapshot['score'] - 0});
      }else{
        await transaction.update(snapshot.reference, {'score': snapshot['score'] - 1});
      }
    });
  }
  // Delete Content
  void handleDeleteAlert(var index, var c){
    showDialog(
      context: c,
      builder: (BuildContext context){
        return AlertDialog(
          title: new Text('Delete Data'),
          content: new Text('Are you sure you want to do this?'),
          actions: <Widget>[
            new FlatButton(
              child: new Text('Cancel'),
              onPressed: (){ Navigator.of(context).pop(); }
            ),
            new FlatButton(
              child: new Text('Delete'),
              onPressed: (){
                Firestore.instance.runTransaction((transaction) async {
                  DocumentSnapshot snapshot = await transaction.get(documents[index].reference);
                  await transaction.delete(snapshot.reference);
                  Navigator.of(context).pop();
                });
              },
            ),
          ],
        );
      }
    );
  }
//==================| END Body PARTS / Validations|=======================|
}
//========================| END The APP |=====================================|


