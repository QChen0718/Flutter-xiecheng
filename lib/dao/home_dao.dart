import 'package:flutter_xiecheng/model/home_model.dart';
import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http; //取个别名叫 http

const HOME_URL = 'http://www.devio.org/io/flutter_app/json/home_page.json';
class HomeDao{
  static Future<Map<String,dynamic>> featch() async {
    final response = await http.get(HOME_URL);
    if (response.statusCode == 200){
      //请求成功
      Utf8Decoder utf8decoder = Utf8Decoder(); //处理中文乱码
      var result = json.decode(utf8decoder.convert(response.bodyBytes));
      return result;
    }
    else {
      //抛出异常
      throw Exception('网络异常，请求失败');
    }
  }

  static Future<Map<String,dynamic>> get(String path,[Map<String,dynamic> params]) async{
    final response = await http.get(path);
    if(response.statusCode == 200){
      //请求成功
      Utf8Decoder utf8decoder = Utf8Decoder(); //处理中文乱码
      var result = json.decode(utf8decoder.convert(response.bodyBytes));
      return result;
    }
    else {
      throw Exception('');
    }
  }
}