




 import 'dart:convert';

import 'package:payarapp/data/api/model/model_ticker_price_api.dart';
import 'package:payarapp/data/mapper/mapper_trading_data.dart';
import 'package:web_socket_channel/web_socket_channel.dart';

class WebSocketClient{


   static const BASE_URL='wss://ftx.com/ws/';
   static const API_KEY='';
   static const API_PRIVATE_KEY='';
   WebSocketChannel? _channel;



   WebSocketClient(){
     _channel=WebSocketChannel.connect(Uri.parse('wss://ftx.com/ws/'));

   }

   subscribe({required String channel,required Function update}){
     _channel!.sink.add(jsonEncode({
       'op': 'subscribe', 'channel': channel, 'market': 'DOGE/USD'
     }));
     _channel!.stream.listen((event) {
       update(MapperTradingData.fromApi(modelTickerPriceApi: ModelTickerPriceApi.fromApi(map: jsonDecode(event)['data'])));
     });

   }




   close(){
     _channel!.sink.close();
   }
 }