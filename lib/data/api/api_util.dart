

  import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:payarapp/data/api/service/main_trading_service.dart';
import 'package:payarapp/data/mapper/mapper_trading_data.dart';
import 'package:payarapp/data/mapper/order_mapper.dart';
import 'package:payarapp/data/api/service/order_service.dart';
import 'package:payarapp/domain/model/order.dart';
import 'package:payarapp/domain/model/tickets.dart';
import 'package:payarapp/domain/model/trading/model_ticker_price.dart';

import 'model/model_ticker_price_api.dart';

class ApiUtil{

    MainTradingService _mainTradingService;

    ApiUtil(this._mainTradingService);

    // Future<Order> getOrder({@required String? idUser}) async{
    //   final result = await _orderService.getOrder(idUser: idUser!);
    //   return OrderMapper.fromApi(result);
    // }
    //
    // Future <List<Tickets>> getTickets({@required String? idUser}) async{
    //      final result=await _orderService.getTickets(idUser: idUser!);
    //      return  OrderMapper.fromApiTickets(result);
    // }
    //
    //
    // Future<void> addOrder({@required String? id_puschase,@required String? price, @required Order? order})async{
    //   await _orderService.addOrder(id_puschase: id_puschase,price: price, order: order);
    //
    // }

    Future <List<ModelTickerPrice>> getListTickerPrice() async{
      List<ModelTickerPrice> list=[];
       final result= await _mainTradingService.getListTickerPrice();
       result!.forEach((element) {
          list.add(MapperTradingData.fromApi(modelTickerPriceApi: element));
       });
       return list;
    }

    Future<void> startWS() async{
      await _mainTradingService.startWS();
    }

    Future<void> stopWS() async{
      await _mainTradingService.stopWS();
    }
    Future<void> addOrdersell() async{
      await _mainTradingService.addOrdersell();
    }

    Future<void> addOrderbuy() async{
      await _mainTradingService.addOrderbuy();
    }

}