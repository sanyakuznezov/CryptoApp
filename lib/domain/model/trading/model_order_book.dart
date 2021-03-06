



import 'package:json_annotation/json_annotation.dart';
part 'model_order_book.g.dart';

 @JsonSerializable()
 class ModelOrderBook{


  List bids;
  List asks;
  String action;


  ModelOrderBook({required this.bids,required this.asks,required this.action});

  factory ModelOrderBook.fromApi({required Map<String,dynamic> map}){
    return  _$ModelOrderBookFromJson(map);

  }

  Map<String, dynamic> toApi() => _$ModelOrderBookToJson(this);

 }