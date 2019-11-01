import 'package:flutter/material.dart';

class TestList extends StatefulWidget{
  @override
  _TestListState createState() => _TestListState();

}
class _TestListState extends State<TestList>{
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return _item();
  }
  _item(){
    return Row(
      children: <Widget>[
        new Container(
          margin: EdgeInsets.only(top: 10,left: 10),
          height: 100,
          width: 100,
          decoration: BoxDecoration(
            color: Colors.red,
            borderRadius: BorderRadius.circular(6)
          ),
          child: Image.network("http://pages.ctrip.com/commerce/promote/20180718/yxzy/img/640sygd.jpg",height: 90,width: 90,fit: BoxFit.fill,),
        ),
        new Container(
          margin: EdgeInsets.only(left: 10),
          width: MediaQuery.of(context).size.width-140,
          height: 120,
          child: Column(
            children: <Widget>[
              new Text('标题啦啦啦',style: TextStyle(fontSize: 18,color: Colors.black),),
              new Container(
                padding: EdgeInsets.only(top: 5),
//                overflow: TextOverflow
//                    .ellipsis, //文字超出屏幕之后的处理方式  TextOverflow.clip剪裁   TextOverflow.fade 渐隐  TextOverflow.ellipsis省略号
                child: new Text('内容很多很多很多很多内容很多很多很多很多内容很多很多很多很多内容很多'
                    '很多很多很多内容很多很多很多很多内容很多很多很多很多内容很多很多很多很'
                    '多内容很多很多很多很内容很多很多很多很多内容很多很多很多很多内容很多很多多内容很多很多很多很多内容很多很多很多很'
                    '多内容很多很多很多很内容很多很多很多很多内容很多很多很多很多内容很多很多,内容很多很多很多很多内容很多很多很多很多内容很多很多很多很多内容很多'
                    '很多很多很多内容很多很多很多很多内容很多很多很多很多内容很多很多很多很'
                    '多内容很多很多很多很内容很多很多很多很多内容很多很多很多很多内容很多很多多内容很多很多很多很多内容很多很多很多很'
                    '多内容很多很多很多很内容很多很多很多很多内容很多很多很多很多内容很多很多',style: TextStyle(fontSize: 12),maxLines: 5,overflow: TextOverflow.ellipsis,),
              ),
            ],
          ),
        )
      ],
    );
  }
}