


import 'package:json_annotation/json_annotation.dart';
part 'model_orderbook.g.dart';
@JsonSerializable()
 class ModelOrderBook{

   int checksum;
   List bids;
   List asks;
   double time;


  ModelOrderBook({required this.time,required this.asks,required this.bids,required this.checksum});

  factory ModelOrderBook.fromApi({required Map<String,dynamic> map}){
    return _$ModelOrderBookFromJson(map);


  }
   Map<String, dynamic> toApi() => _$ModelOrderBookToJson(this);


   }