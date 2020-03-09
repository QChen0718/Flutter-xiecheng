import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter_xiecheng/model/common_model.dart';
import 'package:flutter_xiecheng/model/gridnav_model.dart';
import 'package:flutter_xiecheng/widget/webview.dart';

class GridNav extends StatelessWidget{
  final GridnavModel gridnavModel;
  //@required 表示必填参数
  const GridNav({Key key, @required this.gridnavModel}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    //
    return PhysicalModel(
      //设置背景色为透明色
      color: Colors.transparent,
      //设置圆角
      borderRadius: BorderRadius.circular(6),
      //是否裁切
      clipBehavior: Clip.antiAlias,
      child: Column(
        children: _gridNavItems(context),
      ),
    );
  }
  //酒店，机票，旅行组件的集合
  _gridNavItems(BuildContext context) {
    List<Widget> items = [];

    if (gridnavModel == null) return items;
    //判断酒店是否为null
    if (gridnavModel.hotel != null){
      items.add( _gridNavItem(context, gridnavModel.hotel, true));
    }
    //判断机票是否为null
    if (gridnavModel.flight != null){
      items.add( _gridNavItem(context, gridnavModel.flight, false));
    }
    //判断旅行是否为null
    if (gridnavModel.travel != null){
      items.add(_gridNavItem(context, gridnavModel.travel, false));
    }
    return items;
  }
  //first 这个参数主要是第一个item与上面的Widget有段间隙要设置
  _gridNavItem(BuildContext context,GridNavItem gridNavItem, bool first){
    List<Widget> items = [];
    items.add(_mainItem(context, gridNavItem.mainItem));
    items.add(_doubleItem(context, gridNavItem.item1, gridNavItem.item2));
    items.add(_doubleItem(context, gridNavItem.item3, gridNavItem.item4));
    //这块这段代码很重要 ,这块是将三个大的组件都能撑满它的父布局，并且平分展示
    List<Widget> exandItems = [];
    items.forEach((item){
      exandItems.add(Expanded(child: item, flex: 1,));
    });
    Color startColor = Color(int.parse('0xff' + gridNavItem.startColor));
    Color endColor = Color(int.parse('0xff' + gridNavItem.endColor));
    return Container(
      height: 88,
      margin: first?null : new EdgeInsets.only(top: 3),
      decoration: BoxDecoration(
        //线性渐变
        //颜色数组
          gradient: LinearGradient(colors: [startColor,endColor])
      ),
      child: new Row(
        children: exandItems,
      ),
    );
  }
  _mainItem(BuildContext context, CommonModel model){
    return new GestureDetector(
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
//      //绝对定位 Stack 可以设置层级关系
      child: new Stack(
        //设置内容顶部居中显示
        alignment: AlignmentDirectional.topCenter,
        children: <Widget>[
          Image.network(model.icon, fit: BoxFit.contain,
            height: 88, width: 121,
            //设置图片位置
            alignment: AlignmentDirectional.bottomEnd,
          ),
          new Container(
            margin: EdgeInsets.only(top: 11 ),
            child: Text(
              model.title,
              style: new TextStyle(fontSize: 14, color: Colors.white),
              textAlign: TextAlign.center,
            ),
          )
        ],
      ),
    );
  }
  _doubleItem(BuildContext context,CommonModel topItem, CommonModel bottomItem){

    //上下布局
    return Column(
      children: <Widget>[
        // Expanded 设置垂直方向展开
        Expanded(
          child: _gesterWidget(context, _item(context, topItem, true), topItem) ,
        ),
        Expanded(
          child: _item(context, bottomItem, false),
        )
      ],
    );
  }
  _item(BuildContext context, CommonModel model, bool first){
    BorderSide borderSide = BorderSide(width: 0.8, color: Colors.white);
    //撑满父布局的宽度
    return FractionallySizedBox(
      widthFactor: 1,
      child: Container(
          decoration: BoxDecoration(
              border: Border(
                left: borderSide,
                bottom: first?borderSide:BorderSide.none,
              )
          ),
          child: Center(
            child: new Text(model.title,
               style: new TextStyle(fontSize: 14, color: Colors.white),
               textAlign: TextAlign.center,)
          ),
      ),
    );
  }
  //手势点击方法封装
  _gesterWidget(BuildContext context, Widget widget, CommonModel model){
    return new GestureDetector(
      onTap: (){
        //跳转到对应的H5页面
        Navigator.push(context,
            MaterialPageRoute(builder: (context) => WebView(
              url: model.url,
              statusBarColor: model.statusBarColor,
              hideAppBar: model.hideAppBar,
              title: model .title,
//            backForbid: true,
            ))
        );
      },
      child: widget,
    );
  }

}
