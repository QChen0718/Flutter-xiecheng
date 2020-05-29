import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:flutter_xiecheng/dao/base_model.dart';
//import 'package:';
enum Method {
  get,
  post,
  put,
  delete
}

class Net{
  //工厂模式
  factory Net() => _getInstance();
  static Net get instance => _getInstance();
  static Net _instance;

  Dio dio;
  Net._internal() {
    // 初始化
    /// 请求的Content-Type，默认值是"application/json; charset=utf-8".
    /// 如果您想以"application/x-www-form-urlencoded"格式编码请求数据,
    /// 可以设置此选项为 `Headers.formUrlEncodedContentType`,  这样[Dio]
    /// 就会自动编码请求体.
    String contentType;

    /// [responseType] 表示期望以那种格式(方式)接受响应数据。
    /// 目前 [ResponseType] 接受三种类型 `JSON`, `STREAM`, `PLAIN`.
    ///
    /// 默认值是 `JSON`, 当响应头中content-type为"application/json"时，dio 会自动将响应内容转化为json对象。
    /// 如果想以二进制方式接受响应数据，如下载一个二进制文件，那么可以使用 `STREAM`.
    ///
    /// 如果想以文本(字符串)格式接收响应数据，请使用 `PLAIN`.
    ResponseType responseType;

    /// `validateStatus` 决定http响应状态码是否被dio视为请求成功， 返回`validateStatus`
    ///  返回`true` , 请求结果就会按成功处理，否则会按失败处理.
    ValidateStatus validateStatus;

    /// 用户自定义字段，可以在 [Interceptor]、[Transformer] 和 [Response] 中取到.
    Map<String, dynamic> extra;

    /// Common query parameters
    Map<String, dynamic /*String|Iterable<String>*/ > queryParameters;

    dio = Dio(BaseOptions(
      connectTimeout: 60000,   // 连接服务器超时时间，单位是毫秒.
      receiveTimeout: 10000,   // 响应流上前后两次接受到数据的间隔，单位为毫秒, 这并不是接收数据的总时限.
    )
    );
  }
  //单例模式
  static Net _getInstance(){
    if(_instance == null){
      _instance = Net._internal();
    }
    return _instance;
  }

  get(String url,Map<String,dynamic> params,{Function success,Function failure}){
      _doRequest(url, params, Method.get, success, failure);
  }

  post(String url,Map<String,dynamic> params,{Function success,Function failure}){
    _doRequest(url, params, Method.post, success, failure);
  }
  void _doRequest(String url,Map<String,dynamic> params,Method method,Function successCallBack, Function failureCallBack) async{
    try{
      Response response;
      switch(method){
        case Method.get:
          if(params != null && params.isNotEmpty){
            response = await dio.get(url,queryParameters: params);
          }else{
            response = await dio.get(url);
          }
          break;
        case Method.post:
          if(params != null && params.isNotEmpty){
            response = await dio.post(url,queryParameters: params);
          }else{
            response = await dio.post(url);
          }
          break;
        case Method.put:
          break;
        case Method.delete:
          break;
      }
      Map<String,dynamic> result = json.decode(response.toString());
      print('result:$result');
      //转换成模型
      BaseModel model = BaseModel.formJson(result);
      if(response.statusCode == 200){
        if(successCallBack != null){
           successCallBack(result);
        }
      }else{
        //弹出错误信息
        if(failureCallBack != null){
          failureCallBack(model.error);
        }
      }
    } catch(exception){
        print("请求失败，请稍后再试");
    }
  }
}