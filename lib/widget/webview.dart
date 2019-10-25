import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_webview_plugin/flutter_webview_plugin.dart';
//配置白名单
const CATCH_URLS = ['m.ctrip.com/','m.ctrip.com/html5/','m.ctrip.com/html5','dp.ctrip.com/'];

class WebView extends StatefulWidget{
  //h5地址
  final String url;
  //状态栏颜色
  final String statusBarColor;
  //标题
  final String title;
  //是否隐藏APPbar
  final bool  hideAppBar;
  //是否禁止返回
  final bool backForbid;
  //是否返回

  const WebView({Key key, this.url, this.statusBarColor, this.title, this.hideAppBar, this.backForbid = false}) : super(key: key);
  @override
  _WebViewState createState() => _WebViewState();

}
class _WebViewState extends State<WebView>{
  //创建webview实例
  final webviewReference = FlutterWebviewPlugin();
  StreamSubscription<String> _onUrlChanged;
  StreamSubscription<WebViewStateChanged> _onStateChanged;
  StreamSubscription<WebViewHttpError> _onHttpError;
  bool exiting = false;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    //防止多次打开该页面
    webviewReference.close();
    //url地址改变的时候调用该方法
  _onUrlChanged = webviewReference.onUrlChanged.listen((String url){

    });
  //监听webview状态的改变
    _onStateChanged = webviewReference.onStateChanged.listen((WebViewStateChanged state){
        switch (state.type){
          case WebViewState.startLoad:
            //如果返回的是白名单里面的页面，就pop会上一个跳转的页面
            if (_isToMain(state.url) && !exiting){
              if(widget.backForbid){
                //禁止返回，就再次加载当前页面
                webviewReference.launch(widget.url);
              }else{
                Navigator.pop(context);
                exiting = true;
              }
            }
            break;
          default:
            break;
        }
    });
    //监听加载网页错误的时候
   _onHttpError = webviewReference.onHttpError.listen((WebViewHttpError error){

    });
  }

  _isToMain(String url){
    bool contain = false;
    for (final value in CATCH_URLS){
      //如果url为nil 就用默认值false
      //endsWith 包含的方法，判断一个字符串是否包含在另一个字符串中
      if (url?.endsWith(value)??false){
        contain = true;
        break;
      }
    }
    return contain;
  }
  @override
  //相当于swift中的deinit方法
  void dispose() {
    // TODO: implement dispose

    //取消注册监听
    _onUrlChanged.cancel();
    _onStateChanged.cancel();
    _onHttpError.cancel();
    //关闭webview
    webviewReference.dispose();
    //关闭当前页面
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    //设置默认是白色 widget.statusBarColor 这个为空的话就显示默认的颜色
    String statusBarColorStr = widget.statusBarColor ?? 'ffffff';
    Color backButtonColor;
     if (statusBarColorStr == 'ffffff'){
       backButtonColor = Colors.black;
     }else {
       backButtonColor = Colors.white;
     }

    return Scaffold(
      body: Column(
        children: <Widget>[
          //状态栏
          _appBar(Color(int.parse('0xff'+statusBarColorStr)),backButtonColor),
          //网页内容
          Expanded(
              child: WebviewScaffold(
                url: widget.url,
            //是否支持缩放
            withZoom: true,
            //是否本地缓存
            withLocalStorage: true,
            //设为默认隐藏
            hidden: true,
            //设置加载网页的加载指示器
            initialChild: Container(
              color: Colors.white,
              child: Center(
                child: Text('加载中...'),
              ),
            ),
          )
          )
        ],
      ),
    );
  }
  _appBar(Color backgroundColor, Color backButtonColor){
    //隐藏下的APPbar
//    if(widget.hideAppBar??false){
//      return Container(
//        color: backgroundColor,
//        height: 74,
//      );
//    }
    return Container(
      //FractionallySizedBox 表示盛满屏幕的宽度
      height: 74,
      child: FractionallySizedBox(
        //设置宽度撑满
        widthFactor: 1,
        //层次布局 Stack
        child: Stack(
          children: <Widget>[
            //添加手势
            GestureDetector(
              onTap: (){
                Navigator.pop(context);
              },
              child: Container(
                margin: new EdgeInsets.only(left: 10,top: 44),
                child: new Icon(
                  Icons.close,
                  color: Colors.red,
                  size: 26,
                ),
              ),
            ),

            Positioned(
              left: 0,
                right: 0,
                child: Center(
                  child: Container(
                    margin: new EdgeInsets.only(left: 10,top: 44),
                    child: new Text(widget.title??'急急急',
                      style: new TextStyle(color: Colors.red,fontSize: 20),
                    ),
                  )
                )
            )
          ],
        ),
      )
    );

  }
}