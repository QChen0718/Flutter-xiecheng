import 'package:flutter/material.dart';
import 'package:flutter_xiecheng/model/common_model.dart';
import 'package:flutter_xiecheng/model/gridnav_model.dart';
import 'package:flutter_xiecheng/widget/webview.dart';

class SubNav extends StatelessWidget{
  final List<CommonModel> subNavList;
  //@required 表示必填参数
  const SubNav({Key key, @required this.subNavList,}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return new Container(
      //渲染器
      decoration: BoxDecoration(
          color: Colors.white,
          //设置圆角
          borderRadius: BorderRadius.circular(6)
      ),
      child: Padding(
        padding: EdgeInsets.all(7),
        child: _items(context),
      ),
    );
  }
  //传入上下文
  _items(BuildContext context){
    if (subNavList == null) return null;
    List <Widget> items = [];
    //遍历数组
    subNavList.forEach((model){
      items.add(_item(context, model));
    });
    //计算每一行展示的数量
    int spedCount = (subNavList.length/2 +0.5).toInt();
    return Column(
        children: <Widget>[
          Row(
            //按照屏幕宽度平均排列
              mainAxisAlignment: MainAxisAlignment.spaceBetween ,
              children: items.sublist(0,spedCount)
          ),
          //设置间距
          Padding(
              padding: EdgeInsets.only(top: 10),
              child: Row(
                //按照屏幕宽度平均排列
                  mainAxisAlignment: MainAxisAlignment.spaceBetween ,
                  children: items.sublist(spedCount,subNavList.length)
              )
          )

        ],
    );
  }

  Widget _item(BuildContext context,CommonModel model){
    //添加手势
    //Expanded 类似于自动布局 会根据子控件的大小来设置父控件的大小，可以自适应子控件
    return Expanded(
      flex: 1,
        child: GestureDetector(
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
                height: 18,
                width: 18,
              ),
              Padding(
                padding: EdgeInsets.only(top: 3),
                child: Text(
                  model.title,
                  style: new TextStyle(fontSize: 12),
                ),
              )

            ],
          ),
        ));
  }
}
