


 import 'package:payarapp/data/api/service/socket/websocketclient.dart';
import 'package:payarapp/data/mapper/mapper_trading_data.dart';
import 'package:payarapp/domain/model/trading/model_ticker_price.dart';

class SocketUtil{
     WebSocketClient _client;
   SocketUtil(this._client);

     // Stream<ModelTickerPrice> get getTicker{
     //   return _client.getTicker.map((event) => MapperTradingData.fromApi(modelTickerPriceApi: event));
     // }

     closeTicker(){
       _client.closeTicker();
     }

 }