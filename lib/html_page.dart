import 'package:flutter/material.dart';
import 'package:flutter_html_view/flutter_html_view.dart';

void main() => runApp(new HtmlContent());

class HtmlContent extends StatefulWidget {
  _HtmlContent createState() => new _HtmlContent();
}

class _HtmlContent extends State<HtmlContent> {
  @override
  void initState() { super.initState(); }

  @override
  Widget build(BuildContext context){
    String html = '''
      <h1>Text H1 here</h1>
      <h2>Text H2 here</h2>
      <h3>Text H3 here</h3>
      <h4>Text H4 here</h4>
      <h5>Text H5 here</h5>
      <h6>Text H6 here</h6>
      <img src="https://www.freelogodesign.org/Content/img/logo-ex-7.png">
      <p>There is a paragrath here.</p>
      <h1 class="edit"> A edited H1 here </h1>

      <style>
        .edit {fontsize: 25px; color: red;}
      </style>
    ''';
    return new Scaffold(
      appBar: new AppBar(
        title: new Text('HTML code used here'),
      ),
      body: new SingleChildScrollView(
        child: new Center(
          child: new HtmlView(data: html),
        ),
      ),
    );
  }
}


