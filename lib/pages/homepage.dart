import 'dart:convert';

import 'package:flutter/material.dart';
import "package:flutter_swiper/flutter_swiper.dart";
import 'package:flutter_xiecheng/dao/home_dao.dart';
import 'package:flutter_xiecheng/model/Sales_box_model.dart';
import 'package:flutter_xiecheng/model/common_model.dart';
import 'package:flutter_xiecheng/model/gridnav_model.dart';
import 'package:flutter_xiecheng/model/home_model.dart';
import 'package:flutter_xiecheng/pages/circlepage.dart';
import 'package:flutter_xiecheng/pages/searchpage.dart';
import 'package:flutter_xiecheng/widget/grid_nav.dart';
import 'package:flutter_xiecheng/widget/loading_container.dart';
import 'package:flutter_xiecheng/widget/local_nav.dart';
import 'package:flutter_xiecheng/widget/sales_box.dart';
import 'package:flutter_xiecheng/widget/search_bar.dart';
import 'package:flutter_xiecheng/widget/sub_nav.dart';
import 'package:flutter_xiecheng/widget/test_list.dart';
import 'package:flutter_xiecheng/widget/webview.dart';
//滚动变化的高度
const APPBAR_SCROLL_OFFSET = 100.0;
const SEARCH_BAR_DEFAULT_TEXT = '网红打卡地 景点 酒店 美食';
class Homepage extends StatefulWidget {
  @override
  _HomepageState createState() => _HomepageState();
}

class _HomepageState extends State<Homepage>{

//  List _imageUrls = ['http://pages.ctrip.com/commerce/promote/20180718/yxzy/img/640sygd.jpg',
//    'https://dimg04.c-ctrip.com/images/700u0r000000gxvb93E54_810_235_85.jpg',
//    'https://dimg04.c-ctrip.com/images/700c10000000pdili7D8B_780_235_57.jpg'];
  //定义alpha值变量
  double appBarAlpha = 0.0;
  String resultString = "";
  List<CommonModel> localNavlist = [];
  List<CommonModel> subNavlist = [];
  List<CommonModel> bannerList = [];
  GridnavModel gridnavmodel;
  SalesBoxModel salesBoxModel;
  bool _loding = true;
  @override
  void initState() {
      super.initState();
      _handleRefresh();

  } //初始化方法
  //加载网路数据
  Future<Null> _handleRefresh() async {
    //第一种加载网路数据方法
//    HomeDao.featch().then((result){
//        setState(() {
//          resultString = json.encode(result);
//        });
//     }).catchError((error){
//        setState(() {
//          resultString = error.toString();
//        });
//      });
  //第二种  async  await 组合网络请求方法
    try {
      HomeModel model = await HomeDao.featch();
      setState(() {
        localNavlist = model.localNavList;
        subNavlist = model.subNavList;
        gridnavmodel = model.graidNav;
        salesBoxModel = model.salesBox;
        bannerList = model.bannerList;
        _loding = false;
      });
    }catch (e) {
      // 错误处理
      setState(() {
        resultString = e.toString();
        _loding = false;
      });
    }
    return null;
  }
  //列表滑动监听方法
  _onScroll(offset) {
    double alpha = offset / APPBAR_SCROLL_OFFSET;
    if (alpha < 0.0){
      alpha = 0.0;
    }else if(alpha>1.0){
      alpha=1.0;
    }
    //更新alpha值
    setState(() {
      appBarAlpha = alpha;
    });
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      backgroundColor: Color(0xfaf2f2f2),
      //Stack 有层级关系的，越在后面就是呈现在界面的最上面
        // LoadingContainer 网络加载进度条，网络加载成功后在显示界面
      body: LoadingContainer(
        cover: false,
        isLoading: _loding,
        child: Stack(
          children: <Widget>[
            MediaQuery.removePadding(
              //移除上部间距，listview默认顶部是有间距的
                removeTop: true,
                //context 当前上下文
                context: context,
                // NotificationListener 监听滚动通知
                //在这添加下拉刷新组件
                //RefreshIndicator
                child: RefreshIndicator(
                  // onRefresh 这个方法必须是返回 Future<void> 这个类型
                  onRefresh: _handleRefresh,
                  child: NotificationListener(
                    //滚动改变的回调方法
                    onNotification: (scrollNotification) {
                      if (scrollNotification is ScrollUpdateNotification &&
                          scrollNotification.depth == 0){
                        //滚动且是列表的时候
                        //scrollNotification.depth == 0 是listview才监听滚动
                        _onScroll(scrollNotification.metrics.pixels);
                      }
                    },
                    child: listView,
                  ),
                )
            ),
            //透明组件
            appBar
          ],
        ),
      )
    );
  }

  Widget get listView{
    return ListView(
      //设置纵向滚动
      scrollDirection: Axis.vertical,
      children: <Widget>[
        Container(
          //设置轮播图高度
          height: 160,
          //Swiper 轮播图三方组件
          child: bannerView,
        ),
        Padding(
          padding: new EdgeInsets.fromLTRB(7, 4, 7, 4),
          child: LocalNav(localNavList: localNavlist,),
        ),
        Padding(
          padding: new EdgeInsets.fromLTRB(7, 4, 7, 4),
          child: GridNav(gridnavModel: gridnavmodel,),
        ),
        Padding(
          padding: new EdgeInsets.fromLTRB(7, 4, 7, 4),
          child: SubNav(subNavList: subNavlist,),
        ),
        Padding(
          padding: new EdgeInsets.fromLTRB(7, 4, 7, 4),
          child: SalesBox(salesBoxModel: salesBoxModel,),
        ),
        Padding(
          padding: new EdgeInsets.fromLTRB(7, 4, 7, 4),
          child: TestList(),
        )
      ],
    );
  }
  Widget get appBar{
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
                color: Color.fromARGB((appBarAlpha*255).toInt(), 255, 255, 255)
              ),
              child: SearchBar(
                searchBarType: appBarAlpha > 0.2 ? SearchBarType.homeLight:SearchBarType.home,
                defaultText: SEARCH_BAR_DEFAULT_TEXT,
                inputBoxClick: _jumpToSearch,//跳转到搜索页面
                speakClick: _jumpToSpeak,//跳转到语音搜索页面
                leftButtonClick: _jumpToSelectCity, //跳转到选择城市页面
              ),
            ),
          ),
        new Container(
          height: appBarAlpha > 0.2 ? 1.5 : 0,
          decoration: BoxDecoration(
            boxShadow: [BoxShadow(color: Colors.black12,blurRadius: 0.5)]
          ),
        )
      ],
    );
  }
  Widget get bannerView{
    return Swiper(
      itemCount: bannerList.length,
      //是否自动播放
      autoplay: true,
      //设置轮播组件的内容
      itemBuilder: (BuildContext context, int index){
        CommonModel model = bannerList[index];
        return GestureDetector(
          onTap: (){
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
          child: Image.network(
            bannerList[index].icon,
            //图片展示模式
            fit: BoxFit.fill,
          ),
        );
      },
      //添加轮播图指示器
      pagination: SwiperPagination(),
    );
  }
  //跳转到搜索页面的事件
  _jumpToSearch(){
      Navigator.push(context, MaterialPageRoute(builder: (context){
        return Circlepage(hidenLeft: false,hint: SEARCH_BAR_DEFAULT_TEXT,);
      }));
  }
  //跳转到语音搜索页面事件
  _jumpToSpeak(){

  }
  //跳转到城市选择页面事件
  _jumpToSelectCity(){

  }
}

