



 import 'package:payarapp/data/api/model/model_ticker_price_api.dart';
import 'package:payarapp/domain/model/trading/model_ticker_price.dart';

class MapperTradingData{

  static ModelTickerPrice fromApi({required ModelTickerPriceApi modelTickerPriceApi}){
    return ModelTickerPrice(symbol: modelTickerPriceApi.symbol, price: modelTickerPriceApi.price);
  }


 }