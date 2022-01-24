


import 'package:json_annotation/json_annotation.dart';
part 'model_trades.g.dart';
@JsonSerializable()
 class ModelTrades{

   double price;
   double size;
   String side;
   bool liquidation;
   String time;


   ModelTrades({required this.price,required this.size,required this.side,required this.liquidation,required this.time});

   factory ModelTrades.fromApi({required Map<String,dynamic> map})=>
       _$ModelTradesFromJson(map);
   Map<String, dynamic> toApi() => _$ModelTradesToJson(this);
 }