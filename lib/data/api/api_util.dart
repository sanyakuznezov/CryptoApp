

import 'package:payarapp/data/api/service/rest/main_trading_service.dart';
import 'package:payarapp/data/mapper/mapper_trading_data.dart';
import 'package:payarapp/domain/model/trading/model_ticker_price.dart';


class ApiUtil{

    MainTradingService _mainTradingService;

    ApiUtil(this._mainTradingService);


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

    Future<void> startTrending() async{
      await _mainTradingService.startTrending();
    }

}