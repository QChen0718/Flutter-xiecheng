import 'package:flutter/material.dart';

class SearchList extends StatefulWidget{
  @override
  _SearchListState createState() => _SearchListState();

}
class _SearchListState extends State<SearchList>{
  List<String> imagelist = ["images/Knowledge_Pic_Site_01.png","images/Knowledge_Pic_Site_02.png",
    "images/Knowledge_Pic_Site_03.png","images/Knowledge_Pic_Site_04.png",
        "images/Knowledge_Pic_Site_05.png","images/Knowledge_Pic_Site_06.png",
    "images/Knowledge_Pic_Site_07.png","images/Knowledge_Pic_Site_08.png",
    "images/Knowledge_Pic_Site_08.png"];
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return ListView.builder(
      shrinkWrap: true,
      itemCount: imagelist.length,
        itemBuilder: (BuildContext context, int index){
          return _item(context, index);
    });
  }
  _item(BuildContext context, int index){
    return Row(
      children: <Widget>[
        new Container(
          child: new Image.asset(imagelist[index]),
        )
      ],
    );
  }
}

