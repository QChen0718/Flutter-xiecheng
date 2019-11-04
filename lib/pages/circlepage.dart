import 'package:flutter/material.dart';
import 'package:flutter_xiecheng/dao/search_dao.dart';
import 'package:flutter_xiecheng/model/search_model.dart';
import 'package:flutter_xiecheng/widget/search_bar.dart';
import 'package:flutter_xiecheng/widget/search_list.dart';

const String NOMAL_URL = 'https://m.ctrip.com/restapi/h5api/searchapp/search?source=mobileweb&action=autocomplete&contentType=json&keyword=';
class Circlepage extends StatefulWidget{
  //定义传入的参数
  final bool hidenLeft; //隐藏左边按钮
  final String searchUrl; //搜索的URL
  final String keyword;//搜索的关键字
  final String hint; //默认提示文案
  //{} 包起来表示可选参数，可传可不传
  const Circlepage({Key key, this.hidenLeft = true, this.searchUrl = NOMAL_URL, this.keyword, this.hint}) : super(key: key); //搜索的提示文案

  @override
  _SearchpageState createState() => _SearchpageState();
}

class _SearchpageState extends State<Circlepage>{
  SearchModel searchModel;
  String keyword;
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      body: new Column(
        children: <Widget>[
          appBar(context),
          MediaQuery.removePadding(
            removeTop: true,
            context: context,
            child: new Expanded(
                child: SearchList(searchModel: searchModel,)
            ),
          ),
        ],
      ),
    );
  }

  appBar(BuildContext context){
    return Column(
      children: <Widget>[
        new Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              //APPbar渐变遮罩背景
              colors:[Color(0x66000000),Colors.transparent],
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
            ),
          ),
          child: Container(
            padding: EdgeInsets.only(top: 20),
            height: 80,
            decoration: BoxDecoration(
                color: Colors.white
            ),
            child: SearchBar(
              hideLeft: widget.hidenLeft ,
              defaultText: widget.keyword,
              hint: widget.hint,
              searchBarType: SearchBarType.normal,
              onChaned: _onTextChange,
            ),
          ),
        ),
        new Container(
          height: 0.5,
          decoration: BoxDecoration(
              boxShadow: [BoxShadow(color: Colors.black12,blurRadius: 0.5)]
          ),
        )
      ],
    );
  }
  _onTextChange(String text){
    keyword = text;
    //监听输入的内容
    if (text.length == 0){
      setState(() {
        searchModel = null;
      });
      return;
    }
    String url = widget.searchUrl + text;
    SearchDao.featch(url,text).then((SearchModel model){
      //只有当当前输入的内容和服务端返回的内容一致时才渲染
      if (model.keyword == keyword)
        {
          setState(() {
            searchModel = model;
          });
        }

    }).catchError((error){
      setState(() {
        print(error);
      });
    });
  }
}