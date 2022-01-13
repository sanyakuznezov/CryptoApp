



 import 'package:payarapp/data/api/model/model_all_balances_api.dart';
import 'package:payarapp/data/api/model/model_ticker_price_api.dart';
import 'package:payarapp/domain/model/trading/model_all_balances.dart';
import 'package:payarapp/domain/model/trading/model_ticker_price.dart';


class MapperTradingData{

  static ModelAllBalances fromApi({required ModelAllBalancesApi modelAllBalancesApi}){
    return ModelAllBalances(total: modelAllBalancesApi.total, coin: modelAllBalancesApi.coin, usdValue: modelAllBalancesApi.usdValue);
  }

  static ModelTickerPrice fromApiTicker({required ModelTickerPriceApi modelTickerPriceApi}){
    return ModelTickerPrice(ask: modelTickerPriceApi.ask, time: modelTickerPriceApi.time, last: modelTickerPriceApi.last, bid: modelTickerPriceApi.bid);
  }
 }