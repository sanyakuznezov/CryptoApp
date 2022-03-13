




 import 'package:payarapp/data/api/model/modelorderplaceapi.dart';
import 'package:payarapp/internal/dependencies/repository_module.dart';

import '../../constant.dart';

class StrategyMarket{




   placeOrderMarketSell({required String market}){
    RepositoryModule.apiRepository().placeOrder(modelOrderRequestPlaceApi:
    ModelOrderRequestPlaceApi(
        market: market,
        side: Constant.SIDE_SELL,
        //todo compute price
        price: null,
        type: Constant.TYPE_ORDER_MARKET,
        //todo init balance usd
        size: 1,
        reduceOnly: false,
        ioc: false,
        postOnly: false,
        clientId:null));
   }


   Future<int>placeOrderMarketBuy({required String market})async{
  final result=await RepositoryModule.apiRepository().placeOrder(modelOrderRequestPlaceApi:
    ModelOrderRequestPlaceApi(
        market: market,
        side: Constant.SIDE_BUY,
        //todo compute price
        price: null,
        type: Constant.TYPE_ORDER_MARKET,
        //todo init balance usd
        size: 1,
        reduceOnly: false,
        ioc: false,
        postOnly: false,
        clientId:null));

       return result;
   }

 }