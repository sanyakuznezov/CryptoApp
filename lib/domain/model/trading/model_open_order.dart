

import 'dart:ffi';

import 'package:json_annotation/json_annotation.dart';
part 'model_open_order.g.dart';

@JsonSerializable()
class ModelOpenOrder{


 String? createdAt;
  double? filledSize;
  String? future;
  int? id;
  String? market;
  double? price;
 double? avgFillPrice;
  double? remainingSize;
  String? side;
  double? size;
  String? status;
  String? type;
  bool? reduceOnly;
  bool? ioc;
  bool? postOnly;
  int? clientId;

  ModelOpenOrder({required this.createdAt,required this.filledSize,required this.future,
  required this.id,required this.market,required this.price,required this.avgFillPrice,required this.remainingSize,
   required this.side,required this.size, required this.status,required this.type,required this.reduceOnly,
   required this.ioc,required this.postOnly,required this.clientId
  });

    factory ModelOpenOrder.fromApi({required Map<String,dynamic> map})=>
        _$ModelOpenOrderFromJson(map);
     Map<String, dynamic> toApi() => _$ModelOpenOrderToJson(this);

}