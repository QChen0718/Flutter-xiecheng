import 'package:flutter_xiecheng/model/home_model.dart';
import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http; //去个别名叫 http

const HOME_URL = 'http://www.devio.org/io/flutter_app/json/home_page.json';
class HomeDao{
  static Future<HomeModel> featch() async {
    final response = await http.get(HOME_URL);
    if (response.statusCode == 200){
      //请求成功
      Utf8Decoder utf8decoder = Utf8Decoder(); //处理中文乱码
      var result = json.decode(utf8decoder.convert(response.bodyBytes));
      return HomeModel.fromJson(result);
    }
    else {
      //抛出异常
      throw Exception('网络异常，请求失败');
    }
  }
}