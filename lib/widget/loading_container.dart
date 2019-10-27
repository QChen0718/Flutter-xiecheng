
import 'package:flutter/material.dart';
//加载进度条组件
class LoadingContainer extends StatelessWidget{
  //loading之后显示的内容
  final Widget child;
  //是否在加载
  final bool isLoading;
  //是否覆盖整个页面
  final bool cover;

  const LoadingContainer({Key key, this.isLoading, this.cover = false, this.child}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    //先判断是否在加载，在加载就显示_loadingView，不在就显示child
    //在判断是否显示在整个屏幕之上，是的话 用Stack层级布局将child放在
    //_loadingView的下面
    return !cover?!isLoading?child:_loadingView
        : Stack(
          children: <Widget>[
          child, isLoading? _loadingView:null
      ],
    );
  }
 Widget get  _loadingView{
    return Center(
      child: CircularProgressIndicator(),
    );
  }
}