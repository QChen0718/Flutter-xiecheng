import 'package:flutter/material.dart';
import 'package:flutter_xiecheng/model/Sales_box_model.dart';
import 'package:flutter_xiecheng/model/common_model.dart';
import 'package:flutter_xiecheng/model/gridnav_model.dart';
import 'package:flutter_xiecheng/widget/webview.dart';

class SalesBox extends StatelessWidget{
  final SalesBoxModel salesBoxModel;
  //@required 表示必填参数
  const SalesBox({Key key, @required this.salesBoxModel,}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return new Container(
      //渲染器
      decoration: BoxDecoration(
          color: Colors.white,
      ),
      child: _items(context),
    );
  }
  //传入上下文
  _items(BuildContext context){
    if (salesBoxModel == null) return null;
    List <Widget> items = [];
    items.add(_doubleitem(context,salesBoxModel.bigCard1,salesBoxModel.bigCard2,true,false));
    items.add(_doubleitem(context, salesBoxModel.smallCard1, salesBoxModel.smallCard2, false, false));
    items.add(_doubleitem(context, salesBoxModel.smallCard3, salesBoxModel.smallCard4, false, true));

    return Column(
        children: <Widget>[
          Container(
            height: 44,
            margin: EdgeInsets.only(left: 10),
            //装饰器 decoration
            decoration: BoxDecoration(
              border: Border(
                bottom: BorderSide(width: 1, color: Color(0xfff2f2f2))
              )
            ),
            child: Row (mainAxisAlignment: MainAxisAlignment.spaceBetween,
             children: <Widget>[
               Image.network(salesBoxModel.icon,height: 15,fit: BoxFit.fill,),
               Container(
                   //内部间距
                   padding: EdgeInsets.fromLTRB(10, 1, 8, 1),
                   //外部间距
                   margin: EdgeInsets.only(right: 10),
                   decoration: BoxDecoration(
                     //设置圆角
                       borderRadius: BorderRadius.circular(12),
                       //设置渐变色
                       gradient: LinearGradient(colors: [
                         Color(0xffff4e63),Color(0xffff6cc9)
                       ],
                           //指定渐变色的起始和终止的位置
                           begin: Alignment.centerLeft,end: Alignment.centerRight)
                   ),
                   child:GestureDetector(
                     //设置点击事件
                     onTap: (){
                       //跳转到对应的H5页面
                    Navigator.push(context,
                       MaterialPageRoute(builder: (context) => WebView(
                         url: salesBoxModel.moreUrl,
                         title: '更多活动',
//            backForbid: true,
                       ))

                    );

                   },
                     child: Text('获取更多福利 >',style: TextStyle(fontSize: 12,color:  Colors.white),),

                ),

               )],)
          ),
          Row(
            //按照屏幕宽度平均排列
              mainAxisAlignment: MainAxisAlignment.center ,
              children: items.sublist(0,1)
          ),
          Row(
                //按照屏幕宽度平均排列
                  mainAxisAlignment: MainAxisAlignment.center ,
                  children: items.sublist(1,2)
              ),
          Row(
            //按照屏幕宽度平均排列
              mainAxisAlignment: MainAxisAlignment.center ,
              children: items.sublist(2,3)
          )
      ]
    );
  }

   _doubleitem(BuildContext context,CommonModel leftCard,CommonModel rightCard,bool big, bool last){
    return Row(
      children: <Widget>[
        _item(context, leftCard, big, true, last),
        _item(context, rightCard, big, false, last)
      ],
    );
  }
  Widget _item(BuildContext context,CommonModel model, bool big, bool left, bool last){
    //添加手势
    //Expanded 类似于自动布局 会根据子控件的大小来设置父控件的大小，可以自适应子控件
    BorderSide borderSide = BorderSide(color: Color(0xfff2f2f2));
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
      child: Container(
        decoration: BoxDecoration(
          //border 边框
          border: Border(
            right: left?borderSide:BorderSide.none,
            bottom: last?BorderSide.none:borderSide
          )
        ),
        child: Image.network(
          model.icon,
          height: big?129:80,
          //MediaQuery 这个方法可以获取屏幕的宽度和高度
          width: MediaQuery.of(context).size.width/2-10,
          //图片的显示方式，撑满
          fit: BoxFit.fill,
        ),
      )
    );
  }
}
