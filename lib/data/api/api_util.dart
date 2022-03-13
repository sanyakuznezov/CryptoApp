

import 'package:payarapp/data/api/service/rest/main_trading_service.dart';
import 'package:payarapp/data/mapper/mapper_trading_data.dart';
import 'package:payarapp/domain/model/trading/model_all_balances.dart';
import 'package:payarapp/domain/model/trading/model_open_order.dart';
import 'package:payarapp/domain/model/trading/model_ticker_price.dart';

import 'model/modelorderplaceapi.dart';


class ApiUtil{

    MainTradingService _mainTradingService;

    ApiUtil(this._mainTradingService);


    Future <List<ModelAllBalances>> getBalance() async{
      List<ModelAllBalances> list=[];
       final result= await _mainTradingService.getBalance();
       result!.forEach((element) {
          list.add(MapperTradingData.fromApi(modelAllBalancesApi: element));
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

    Future<void> startTrending() async{
      await _mainTradingService.startTrending();
    }
    Future<List<ModelOpenOrder>?> getOpenOrders()async{
     return await _mainTradingService.getOpenOrders();
    }

    Future<int> placeOrder({required ModelOrderRequestPlaceApi modelOrderRequestPlaceApi})async{
      return await _mainTradingService.placeOrder(modelOrderRequestPlaceApi: modelOrderRequestPlaceApi);
    }

    Future<void> getTrades({required String market}) async{
     await _mainTradingService.getTrades(market: market);
    }

    Future<bool> cancelOrder({required String id})async{
      return await _mainTradingService.cancelOrder(id: id);
    }
}