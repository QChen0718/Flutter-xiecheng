import 'package:flutter/material.dart';
import 'package:flutter_xiecheng/widget/search_bar.dart';
import 'package:flutter_xiecheng/widget/search_list.dart';

class Circlepage extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        title: new Text("圈子"),
      ),
      body: new Column(
        children: <Widget>[
          SearchBar(),
          new Flexible(
              child: SearchList()
          )
        ],
      ),
    );
  }
}