import 'package:flutter/material.dart';
import 'NewsDetailPage.dart';

class NewsListPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new Center(
      child: new RaisedButton(
        child: new Text("to detail page"),
        onPressed: (){
          Navigator.of(context).push(new MaterialPageRoute(builder: (ctx){
            return new NewDetailPage();
          }));
        },
      )
    );
  }
}
