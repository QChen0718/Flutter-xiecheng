import 'package:flutter/material.dart';
enum SearchBarType{
  home,
  normal,
  homeLight
}
class SearchBar extends StatefulWidget{
  final bool enabled ; //是否可以编辑
  final bool hideLeft; //是否隐藏左侧按钮
  final SearchBarType searchBarType ; //搜索栏的几种样式
  final String hint; //提示文案
  final String defaultText; //默认文案
  final void Function() leftButtonClick; //左侧按钮点击回调方法
  final void Function() rightButtonClick; //右侧按钮点击回调方法
  final void Function() speakClick; //语音按钮点击回调方法
  final void Function() inputBoxClick;
  final ValueChanged<String> onChaned; //内容变化的回调

  const SearchBar({Key key,
    //是否可编辑
    this.enabled = true,
    //隐藏左侧按钮
    this.hideLeft = true,
    //搜索栏类型
    this.searchBarType = SearchBarType.normal,
    //提示文案
    this.hint,
    //默认文案
    this.defaultText,
    this.leftButtonClick,
    this.rightButtonClick,
    this.speakClick,
    this.inputBoxClick,
    this.onChaned}) : super(key: key);
  @override
  _SearchBarState createState() => _SearchBarState();

}
class _SearchBarState extends State<SearchBar>{
  bool showClear = false;
  // textfield 通过TextEditingController 监听内容变化
 final TextEditingController _controller = TextEditingController();
 @override
  void initState() {
    // TODO: implement initState
   //这块加这个判断，当有默认的数据，给textfiled赋值
   if (widget.defaultText != null){
     setState(() {
       _controller.text = widget.defaultText;
     });
   }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return widget.searchBarType == SearchBarType.normal ? _genNormalSearch(): _genHomeSearch();
  }
  //创建默认searchbar 方法
  _genNormalSearch(){
   return Container(
     child: Row(
       children: <Widget>[
         //icon
         _wrapTap(new Container(
           margin: EdgeInsets.only(left: 10),
           child:widget.hideLeft?null: new Icon(Icons.arrow_back_ios,size: 26,color: Colors.grey,),
         ), widget.leftButtonClick),
         //Expanded撑满屏幕的剩余的部分
         new Expanded(
             flex: 1,
             child: _inputBox(),
         ),
         _wrapTap(new Container(
           padding: EdgeInsets.fromLTRB(10,5,10,5),
           child:Text('搜索',style: TextStyle(color: Colors.blue,fontSize: 17),)
         ), widget.rightButtonClick),
       ],
     ),
   );
  }
  //创建首页searchbar 方法
  _genHomeSearch(){
    return Container(
      child: Row(
        children: <Widget>[
          //icon
          _wrapTap(
              new Row(
                children: <Widget>[
                  Text(
                    '上海',
                    style: TextStyle(
                      fontSize: 14,
                      color: _homeFontColor(),
                    ),
                  ),
                  Icon(
                    Icons.expand_more,
                    size: 22,
                    color: _homeFontColor(),
                  )
                ],
              ),
              widget.leftButtonClick),
          //Expanded撑满屏幕的剩余的部分
          new Expanded(
            flex: 1,
            child: _inputBox(),
          ),
          _wrapTap(
              new Icon(
                Icons.message,
                size: 26,
                color: _homeFontColor() ,
              ),
              widget.rightButtonClick),
        ],
      ),
    );
  }

  //自定制输入框样式
  _inputBox(){
   //输入框背景颜色
    Color inputBoxColor;
    if (widget.searchBarType == SearchBarType.home){
      inputBoxColor = Colors.white;
    }else {
      inputBoxColor = Color(int.parse('0xffEDEDED'));
    }
   return Container(
     height: 30,
      padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
      decoration: BoxDecoration(
        color: inputBoxColor,
        borderRadius: BorderRadius.circular(widget.searchBarType == SearchBarType.normal ? 5 :15)
      ),
      child: Row(
        children: <Widget>[
          Icon(
            Icons.search,
            size: 20,
            color: widget.searchBarType == SearchBarType.normal ? Color(0xffA9A9A9):Colors.blue,
          ),
          Expanded(
              flex: 1,
              child: widget.searchBarType == SearchBarType.normal? TextField(
                controller: _controller,
                //监听输入的内容
                onChanged: _onChanged,
                //自动聚焦
                autofocus: true,
                style: TextStyle(
                    fontSize: 18,
                    color: Colors.black,
                    fontWeight: FontWeight.w300
                ),
                //输入文本样式
                decoration: InputDecoration(
                    contentPadding: EdgeInsets.fromLTRB(5, 0, 5 , 0),
                    border: InputBorder.none,
                    //类似于iOS的plansHandel
                    hintText: widget.hint ?? "",
                    hintStyle: TextStyle(fontSize: 15)
                ),
              ):_wrapTap(
                Text(
                    widget.defaultText,
                  style: TextStyle(fontSize: 13, color: Colors.grey),
                ),
                widget.inputBoxClick
              ),
          ),
          showClear == true ? _wrapTap(
              Icon(Icons.close,size: 22,color: Colors.grey,), (){
               setState(() {
                 //清空输入框的内容
                 _controller.clear();
               });
               _onChanged('');
             }
          ): _wrapTap(
              Icon(
                  Icons.mic,
                  size: 22,
                  color: widget.searchBarType == SearchBarType.normal ? Colors.blue:Colors.grey,
              ), widget.inputBoxClick
          )
        ],
      ),
    );
  }
  //封装的控件方法增加点击效果
  _wrapTap(Widget child, void Function() callback){
    return GestureDetector(
      onTap: (){
        if (callback != null) callback();
      },
      child: child,
    );
  }
  //输入框变化监听方法
  _onChanged(String value){
      print('----->$value');
    if (value.length > 0){
      //刷新UI重新赋值
      setState(() {
        showClear = true;
      });
    }else {
      setState(() {
        showClear = false;
      });
    }
    if (widget.onChaned != null){
      widget.onChaned(value);
    }
  }
  //首页字体颜色变化方法
  _homeFontColor(){
    return widget.searchBarType == SearchBarType.homeLight ? Colors.black54 : Colors.white;
  }
}