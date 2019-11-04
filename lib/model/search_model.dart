//搜索模型
class SearchModel{
   String keyword;
  final List<SearchItem> data;
  SearchModel({this.data,this.keyword});
  factory SearchModel.fromJson(Map<String,dynamic>json){
    var dataJson = json['data'] as List;
    List<SearchItem> data = dataJson.map((i) => SearchItem.fromJson(i)).toList();
    return SearchModel(data: data,keyword: json['keyword']);
  }
}

class SearchItem{
  final String word;//xx酒店
  final String type; //类型
  final String price; //实时价格
  final String star;//星级
  final String zonename; //虹桥
  final String districtname;//上海
  final String url;

  SearchItem({this.word, this.type, this.price, this.star, this.zonename,
    this.districtname, this.url}); //工厂方法

  factory SearchItem.fromJson(Map<String,dynamic>json){
    return SearchItem(
        word: json['word'],
        type: json['type'],
        url: json['url'],
        price: json['price'],
        star: json['star'],
        zonename: json['zonename'],
        districtname: json['districtname']
    );
  }
  // model 转 json
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['word'] = this.word;
    data['type'] = this.type;
    data['url'] = this.url;
    data['price'] = this.price;
    data['star'] = this.star;
    data['zonename'] = this.zonename;
    data['districtname'] = this.districtname;
    return data;
  }
}