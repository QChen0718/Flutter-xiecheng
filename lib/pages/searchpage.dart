import 'package:flutter/material.dart';
import 'package:flutter_xiecheng/widget/search_bar.dart';

class SearchPage extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      body: Column(
        children: <Widget>[
          SearchBar(searchBarType: SearchBarType.normal,)
        ],
      ),
    );
  }

}