import 'package:flutter/material.dart';
import 'package:flutter_xiecheng/pages/circlepage.dart';
import 'package:flutter_xiecheng/pages/homepage.dart';
import 'package:flutter_xiecheng/pages/mepage.dart';
import 'package:flutter_xiecheng/pages/messagepage.dart';

class Navigators extends StatefulWidget {
  @override
  _NavigatorState createState() => _NavigatorState();
}

class _NavigatorState extends State<Navigators> {
  final PageController _controller = PageController(
    initialPage: 0
  );
  int _currentIndex = 0;
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      //分页控制器
      body: new PageView(
        //
        scrollDirection: Axis.vertical,
        controller: _controller,
        //pageview包含的控制器
        children: <Widget>[
          Homepage(),
          Circlepage(),
          Messagepage(),
          Mepage()
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        type: BottomNavigationBarType.fixed,
        onTap: (index) {
          //刷新UI设置当前选中的item
          setState(() {
            _currentIndex = index;
          });
          _controller.jumpToPage(_currentIndex);
        } ,
        items: [
          BottomNavigationBarItem(
            //默认icon
            icon: new Icon(Icons.home),
            //选中icon
            activeIcon: new Icon(Icons.home,color: Colors.blue,),
            title: new Text("首页",style: new TextStyle(color: _currentIndex == 0 ? Colors.blue : Colors.grey),)
          ),
          BottomNavigationBarItem(
              icon: new Icon(Icons.account_circle),
              activeIcon: new Icon(Icons.account_circle,color: Colors.blue,),
              title: new Text("圈子",style: new TextStyle(color: _currentIndex == 1 ? Colors.blue : Colors.grey),)
          ),
          BottomNavigationBarItem(
              icon: new Icon(Icons.message),
              activeIcon: new Icon(Icons.message,color: Colors.blue,),
              title: new Text("消息",style: new TextStyle(color: _currentIndex == 2 ? Colors.blue : Colors.grey),)
          ),
          BottomNavigationBarItem(
              icon: new Icon(Icons.assignment_ind),
              activeIcon: new Icon(Icons.assignment_ind,color: Colors.blue,),
              title: new Text("我的",style: new TextStyle(color: _currentIndex == 3 ? Colors.blue : Colors.grey),)
          ),
        ]
      ),
    );
  }

}