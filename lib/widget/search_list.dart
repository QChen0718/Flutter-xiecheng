import 'package:flutter/material.dart';
import 'package:flutter_xiecheng/model/search_model.dart';

class SearchList extends StatefulWidget{
  final SearchModel searchModel;

  const SearchList({Key key,@required this.searchModel}) : super(key: key);
  @override
  _SearchListState createState() => _SearchListState();

}
class _SearchListState extends State<SearchList>{

  List<String> imagelist = ["images/Knowledge_Pic_Site_01.png","images/Knowledge_Pic_Site_02.png",
    "images/Knowledge_Pic_Site_03.png","images/Knowledge_Pic_Site_04.png",
        "images/Knowledge_Pic_Site_05.png","images/Knowledge_Pic_Site_06.png",
    "images/Knowledge_Pic_Site_07.png","images/Knowledge_Pic_Site_08.png",
    "images/Knowledge_Pic_Site_09.png"];
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return RefreshIndicator(
      onRefresh: loadData,
      child: ListView.builder(
          shrinkWrap: true,
          itemCount: widget.searchModel?.data?.length ?? 0,
          itemBuilder: (BuildContext context, int index){
            return _item(context, index);
          }),
    );
  }
  _item(BuildContext context, int index){
    //做一下判空处理
    if(widget.searchModel==null || widget.searchModel.data == null) return null;
    SearchItem item = widget.searchModel.data[index];
    return GestureDetector(
      onTap: (){
        print('列表被点击$index');
        setState(() {

        });
      },
      child: Container(
        decoration: BoxDecoration(
          border: Border(bottom: BorderSide(width: 0.3,color: Colors.grey))
        ),
        child: Row(
          children: <Widget>[
            new Container(
              margin: EdgeInsets.only(top: 10,left: 15),
              child: index<9? new Image.asset(imagelist[index]):new Image.asset(imagelist[0]),
            ),
            new Padding(
              padding: EdgeInsets.only(left: 10),
              child: new Column(
                children: <Widget>[
                  new Container(
//                alignment: Alignment.centerLeft,
                    width: MediaQuery.of(context).size.width - 200,
                    child: _title(item),
                  ),
                  new Container(
                    width: MediaQuery.of(context).size.width - 200,
                    child: _subtitle(item)
                  )
                ],
              ),
            )
          ],
        ),
      )
    );
  }
  _title(SearchItem item){
    if(item == null)return null;
    List<TextSpan> spans = [];
    //数组添加数组用addall来追加
    spans.addAll(_keywordTextSpans(item.word, widget.searchModel.keyword));
    spans.add(TextSpan(text: ' '+(item.districtname??'')+ ' '+(item.zonename??''),style: TextStyle(fontSize: 16,color: Colors.grey)));
    return RichText(text: TextSpan(children: spans));
  }
  _subtitle(SearchItem item){
    return RichText(text: TextSpan(
      children: <TextSpan>[
       TextSpan(
         text: item.price??'',
         style: TextStyle(fontSize: 16,color: Colors.orange)
       ),
        TextSpan(
          text: ' ' + (item.star??''),
          style: TextStyle(fontSize: 12,color: Colors.grey)
        )
      ]
    ));
  }
  _keywordTextSpans(String word, String keyword){
    List<TextSpan> spans = [];
    if (word == null && word.length == 0) return spans;
    List<String> arr = word.split(keyword);
    TextStyle normalStyle = TextStyle(fontSize: 16,color: Colors.black87);
    TextStyle keywordStyle = TextStyle(fontSize: 16,color: Colors.orange);
    for(int i=0; i<arr.length; i++){
      if((i+1)%2 ==0 ){
        //说明是关键字
        spans.add(TextSpan(text: keyword,style: keywordStyle));
      }
      String val = arr[i];
      if(val != null && val.length>0){
        spans.add(TextSpan(text: val, style: normalStyle));
      }
    }
    return spans;
  }
  Future<Null> loadData(){
    return null;
  }
}

