import 'package:flutter/material.dart';
enum statusbartype{
  nomal,
  home,
  search
}
class SearchBar extends StatefulWidget{
  @override
  _SearchBarState createState() => _SearchBarState();

}
class _SearchBarState extends State<SearchBar>{
  TextEditingController controller = TextEditingController();
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Row(
      children: <Widget>[
        //icon
        new Container(
          margin: EdgeInsets.only(left: 10),
          child: new Icon(Icons.arrow_back_ios,size: 24,color: Colors.grey,),
        ),
        new Expanded(
            flex: 1,
            child: Container(
              decoration: BoxDecoration(
                color: Colors.grey,
                borderRadius: BorderRadius.circular(5)
              ),
              child: TextField(
                controller: controller,
                decoration: new InputDecoration(
                  hintText: '请输入你要查找的内容'
                ) ,
                style: TextStyle(fontSize: 15,color: Colors.red),
              ),
            )
        ),
        new Container(
          height: 44,
          width: 44,
          alignment: Alignment(0.0, 0.0),
          margin: EdgeInsets.only(left: 10,right: 10),
          child: new GestureDetector(
            onTap: (){
              print('搜索被点击');
            },
            child: new Text('搜索',style: new TextStyle(color: Colors.blue, fontSize: 18),textAlign: TextAlign.center,),
          )
        )
      ],
    );
  }

}