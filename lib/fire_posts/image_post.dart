import 'package:flutter/material.dart';

class ImagePost extends StatefulWidget {
  @override
  _ImagePost createState() => _ImagePost();
}

//==========================| The APP |========================================|
class _ImagePost extends State<ImagePost> {

//======================| Body |==================================|
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: new AppBar( title: new Text('F_Storage / Img Upload')),
      body: new Center( 
        child: new Text('Welcome to Image Upload'),
      ),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add, size: 48.0,),
        backgroundColor: Colors.red,
        onPressed: () { showDialog(
                    context: context, 
                    builder: (BuildContext context) {return  AlertDialog(
                      title: new Text('Under Construction', style: new TextStyle(color: Colors.red),));
                    }); },
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
//======================| END body |==================================|

//======================| BD items |==================================|


//======================| END BD items |=============================|
//========================| END The APP |=====================================|

