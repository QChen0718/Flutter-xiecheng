import 'net.dart';
import 'net_url.dart';
class NetUtil{
  static void homedata(Map<String,dynamic> params,{Function success, Function failure}){
    Net().get(NetUrl.HOME_URL, params,success: success,failure: failure);
  }
}