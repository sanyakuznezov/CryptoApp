
  import 'package:payarapp/constant.dart';
import 'package:payarapp/data/api/model/modelorderplaceapi.dart';
import 'package:payarapp/internal/dependencies/repository_module.dart';

class StrategyLimitOrder {




   placeOrderSell({required String market,required,required int percentageOfBalance}){
     RepositoryModule.apiRepository().placeOrder(modelOrderRequestPlaceApi:
     ModelOrderRequestPlaceApi(
         market: market,
         side: Constant.SIDE_SELL,
         //todo compute price
         price: 0,
         type: Constant.TYPE_ORDER_LIMIT,
         //todo init balance usd
         size: _getSize(percentageOfBalance, 0),
         reduceOnly: false,
         ioc: false,
         postOnly: false,
         clientId:''));
   }


   double _getSize(int percentageOfBalance,double mainBalance){
      return (mainBalance*percentageOfBalance)/100;
   }


  placeOrderBuy(){



  }


  }