import 'package:flutter/material.dart';
import 'package:flutter_xiecheng/model/common_model.dart';
import 'package:flutter_xiecheng/model/gridnav_model.dart';
import 'package:flutter_xiecheng/widget/webview.dart';

class LocalNav extends StatelessWidget{
  final List<CommonModel> localNavList;
  //@required 表示必填参数
  const LocalNav({Key key, @required this.localNavList,}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return new Container(
      height: 64,
      //渲染器
      decoration: BoxDecoration(
          color: Colors.white,
          //设置圆角
          borderRadius: BorderRadius.all(
              Radius.circular(6)
          )
      ),
      child: Padding(
        padding: EdgeInsets.all(7),
        child: _items(context),
      ),
    );
  }
  //传入上下文
  _items(BuildContext context){
    if (localNavList == null) return null;
    List <Widget> items = [];
    //遍历数组
    localNavList.forEach((model){
      items.add(_item(context, model));
    });
    return Row(
      //按照屏幕宽度平均排列
        mainAxisAlignment: MainAxisAlignment.spaceBetween ,
        children: items
    );
  }

  Widget _item(BuildContext context,CommonModel model){
    //添加手势
    return GestureDetector(
      onTap: (){
        //跳转到对应的H5页面
        Navigator.push(context,
          MaterialPageRoute(builder: (context) => WebView(
            url: model.url,
            statusBarColor: model.statusBarColor,
            hideAppBar: model.hideAppBar,
            title: model.title,
//            backForbid: true,
          ))
        );
      },
      child: Column(
        children: <Widget>[
          Image.network(
            model.icon,
            height: 32,
            width: 32,
          ),
          Text(
            model.title,
            style: new TextStyle(fontSize: 12),
          )
        ],
      ),
    );
  }

//  @override
//  _LocalNavState createState() => _LocalNavState();
}
//class _LocalNavState extends State<LocalNav>{
//  @override
//  Widget build(BuildContext context) {
//    // TODO: implement build
//    return null;
//  }
//}