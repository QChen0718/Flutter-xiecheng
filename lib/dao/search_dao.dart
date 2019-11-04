import 'package:flutter_xiecheng/model/home_model.dart';
import 'package:flutter_xiecheng/model/search_model.dart';
import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http; //去个别名叫 http

class SearchDao{
  static Future<SearchModel> featch(String url, String text) async {
    final response = await http.get(url);
    if (response.statusCode == 200){
      //请求成功
      Utf8Decoder utf8decoder = Utf8Decoder(); //处理中文乱码
      var result = json.decode(utf8decoder.convert(response.bodyBytes));
      //只有当当前输入的内容和服务端返回的内容一致时才渲染
      SearchModel model = SearchModel.fromJson(result);
      model.keyword = text;
      return model;
    }
    else {
      //抛出异常
      throw Exception('网络异常，请求失败');
    }
  }
}