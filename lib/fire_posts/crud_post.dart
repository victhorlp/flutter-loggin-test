// import 'dart:async';
import 'package:flutter/material.dart';
// import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'crud_add.dart';

//==========================| The APP |========================================|

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
}

class SimplePostThenView extends StatelessWidget {
  final List<DocumentSnapshot> documents;

  SimplePostThenView({this.documents});

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
                border: Border.all(color: Colors.white),
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
                              Firestore.instance
                                  .runTransaction((transaction) async {
                                DocumentSnapshot snapshot = await transaction
                                    .get(documents[index].reference);

                                await transaction.update(
                                    snapshot.reference, {'title': item});

                                await transaction.update(snapshot.reference,
                                    {"editing": !snapshot['editing']});
                              });
                            },
                          ),
                  ),
                  Text("$score"),
                  Column(
                    children: <Widget>[
                      IconButton(
                        onPressed: () {
                          Firestore.instance
                              .runTransaction((Transaction transaction) async {
                            DocumentSnapshot snapshot = await transaction
                                .get(documents[index].reference);
                            await transaction.update(snapshot.reference,
                                {'score': snapshot['score'] + 1});
                          });
                        },
                        icon: Icon(Icons.arrow_upward),
                      ),
                      IconButton(
                        onPressed: () {
                          Firestore.instance
                              .runTransaction((Transaction transaction) async {
                            DocumentSnapshot snapshot = await transaction
                                .get(documents[index].reference);
                            await transaction.update(snapshot.reference,
                                {'score': snapshot['score'] - 1});
                          });
                        },
                        icon: Icon(Icons.arrow_downward),
                      ),
                    ],
                  ),
                  IconButton(
                    icon: Icon(Icons.delete),
                    onPressed: () {
                      Firestore.instance.runTransaction((transaction) async {
                        DocumentSnapshot snapshot =
                            await transaction.get(documents[index].reference);
                        await transaction.delete(snapshot.reference);
                      });
                    },
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
}

//======================| END body |==================================|

//======================| BD items |==================================|


//======================| END BD items |=============================|
//========================| END The APP |=====================================|


