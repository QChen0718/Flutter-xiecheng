import 'package:flutter/material.dart';

class Mepage extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        title: new Text("我的"),
      ),
      body: ListView.builder(
        itemCount: 20,
          itemBuilder: (BuildContext context, int index){
            return Text('测试列表');
          }
      ),
    );
  }

}