//首页卡片模型
import 'package:flutter_xiecheng/model/common_model.dart';

class GridnavModel{
  final GridNavItem hotel;
  final GridNavItem flight;
  final GridNavItem travel;
//command + n  快速创建构造方法的快捷键

  GridnavModel({this.hotel, this.flight, this.travel});
  //工厂方法
  factory GridnavModel.fromJson(Map<String,dynamic>json){
    //json 不为空
    return json !=null? GridnavModel(
        hotel: GridNavItem.fromJson(json['hotel']) ,
        flight: GridNavItem.fromJson(json['flight']) ,
        travel: GridNavItem.fromJson(json['travel'])
    ): null ;
  }
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.hotel != null){
      data['hotel'] = this.hotel.toString();
    }
    if (this.flight != null){
      data['flight'] = this.flight.toString();
    }
    if (this.travel != null){
      data['travel'] = this.travel.toString();
    }
    return data;
  }
}

class GridNavItem{
  final String startColor;
  final String endColor;
  final CommonModel mainItem;
  final CommonModel item1;
  final CommonModel item2;
  final CommonModel item3;
  final CommonModel item4;

  GridNavItem({
    this.startColor,
    this.endColor,
    this.mainItem,
    this.item1,
    this.item2,
    this.item3,
    this.item4});
  factory GridNavItem.fromJson(Map<String,dynamic>json){
    return GridNavItem(
        startColor: json['startColor'],
        endColor: json['endColor'],
        mainItem: CommonModel.fromJson(json['mainItem']),
      item1: CommonModel.fromJson(json['item1']),
      item2: CommonModel.fromJson(json['item2']),
      item3: CommonModel.fromJson(json['item3']),
      item4: CommonModel.fromJson(json['item4'])
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();

    data['startColor'] = this.startColor.toString();

    data['endColor'] = this.endColor.toString();

    if (this.mainItem != null){
      data['mainItem'] = this.mainItem.toJson();
    }
    if (this.item1 != null){
      data['item1'] = this.item1.toJson();
    }
    if (this.item2 != null){
      data['item2'] = this.item2.toJson();
    }
    if (this.item3 != null){
      data['item3'] = this.item3.toJson();
    }
    if (this.item4 != null){
      data['item4'] = this.item4.toJson();
    }
    return data;
  }
}