
class ConfigModel {
  final String searchUrl;
  //实例构造方法 用{}包裹一下表示构造方法是可选的
  ConfigModel({this.searchUrl});
  //工厂方法
  //json 转 model
  factory ConfigModel.fromJson(Map<String,dynamic>json){
    return ConfigModel(
      searchUrl: json['searchUrl']
    );
  }
  // model 转 json
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['searchUrl'] = this.searchUrl;
    return data;
  }
}