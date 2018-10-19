import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';
// import 'package:firebase_core/firebase_core.dart';

class SimplePost extends StatefulWidget {
  @override
  _PostItem createState() => _PostItem();
}

//==========================| The APP |========================================|
class _PostItem extends State<SimplePost> {
  List<Item> items = List();
  Item item;
  DatabaseReference itemRef;

  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    item = Item("", "");
    final FirebaseDatabase database = FirebaseDatabase.instance; //Rather then just writing FirebaseDatabase(), get the instance.  
    itemRef = database.reference().child('items');
    itemRef.onChildAdded.listen(_onEntryAdded);
    itemRef.onChildChanged.listen(_onEntryChanged);
  }

  _onEntryAdded(Event event) {
    setState(() {
      items.add(Item.fromSnapshot(event.snapshot));
    });
  }

  _onEntryChanged(Event event) {
    var old = items.singleWhere((entry) {
      return entry.key == event.snapshot.key;
    });
    setState(() {
      items[items.indexOf(old)] = Item.fromSnapshot(event.snapshot);
    });
  }

  void handleSubmit() {
    final FormState form = formKey.currentState;

    if (form.validate()) {
      form.save();
      form.reset();
      itemRef.push().set(item.toJson());
    }
  }

//======================| Body |==================================|
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: new AppBar( title: new Text('Firebase / Simple post Demo'), ),
      resizeToAvoidBottomPadding: false,
      body: Column(
        children: <Widget>[
          Flexible(
            flex: 0,
            child: Center(
              child: Form(
                key: formKey,
                child: Flex(
                  direction: Axis.vertical,
                  children: <Widget>[
                    ListTile(
                      leading: Icon(Icons.info),
                      title: TextFormField(
                        decoration: new InputDecoration(labelText: 'User name'),
                        initialValue: "",
                        onSaved: (val) => item.title = val,
                        validator: (val) {
                          if(val.isEmpty){return 'It shouldn\'t be empty';}
                          else if (val.contains(' ')) {return 'There Shouldn\'t be any spaces';}
                          else if (val.contains('@')) {return 'This is not a email';}
                          else{}
                        }
                      ),
                    ),
                    ListTile(
                      leading: Icon(Icons.info),
                      title: TextFormField(
                        decoration: new InputDecoration(labelText: 'subject'),
                        initialValue: '',
                        onSaved: (val) => item.body = val,
                        // validator: (val) => val == "" ? val : null,
                        validator: (val) {
                          if(val.isEmpty){return 'It shouldn\'t be empty';}
                          else if (val.contains('@')) {return 'This is not a email';}
                          else{}
                        }
                      ),
                    ),
                    IconButton(
                      icon: Icon(Icons.send),
                      onPressed: () {
                        handleSubmit();
                      },
                    ),
                  ],
                ),
              ),
            ),
          ),
          Flexible(
            child: FirebaseAnimatedList(
              query: itemRef,
              itemBuilder: (BuildContext context, DataSnapshot snapshot,
                  Animation<double> animation, int index) {
                return new ListTile(
                  leading: Icon(Icons.message),
                  title: Text(items[index].title),
                  subtitle: Text(items[index].body),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
//======================| END body |==================================|

//======================| BD items |==================================|
class Item {
  String key;
  String title;
  String body;

  Item(this.title, this.body);

  Item.fromSnapshot(DataSnapshot snapshot)
      : key = snapshot.key,
        title = snapshot.value["title"],
        body = snapshot.value["body"];

  toJson() {
    return {
      "title": title,
      "body": body,
    };
  }
}
//======================| END BD items |=============================|
//========================| END The APP |=====================================|

