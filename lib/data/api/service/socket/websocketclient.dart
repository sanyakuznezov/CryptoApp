




 import 'dart:convert';

import 'package:crypto/crypto.dart';
import 'package:payarapp/data/api/model/model_ticker_price_api.dart';
import 'package:payarapp/data/mapper/mapper_trading_data.dart';
import 'package:web_socket_channel/web_socket_channel.dart';

class WebSocketClient{


   static const BASE_URL='wss://ftx.com/ws/';
   static const API_KEY='AQmjcrH8Q-vWS8tsrzZjqWDRzNXH-QVIysguGeu9';
   static const API_PRIVATE_KEY='S3FtewQslutLHbji4hm2_FyJOpjjDMRN0imc6xjY';
   WebSocketChannel? _channel;



   WebSocketClient(){
     _channel=WebSocketChannel.connect(Uri.parse('wss://ftx.com/ws/'));

   }

   subscribeTicker({required String channel,required Function update}){
     _channel!.sink.add(jsonEncode({
       'op': 'subscribe', 'channel': channel, 'market': 'DOGE/USD'
     }));
     _channel!.stream.listen((event) {
       update(MapperTradingData.fromApiTicker(modelTickerPriceApi: ModelTickerPriceApi.fromApi(map: jsonDecode(event)['data'])));
     });

   }

   subscribeOrders({required String channel,required Function update}){

     final ts=DateTime.now().millisecondsSinceEpoch;
     var key = utf8.encode(API_PRIVATE_KEY);
     var signaturePayload = utf8.encode('${ts}websocket_login');
     final hmac256=Hmac(sha256, key);
     Digest sha256Result = hmac256.convert(signaturePayload);
     _channel!.sink.add(jsonEncode(
     {
       "args": {
         "key": API_KEY,
         "sign": sha256Result,
         "time": ts
       },
       'op': 'subscribe', 'channel': 'orders'
     }
     ));
     _channel!.stream.listen((event) {
       update(event);
     }).onError((error){
       print('Error subscrabe $error');
     });

   }



   close(){
     _channel!.sink.close();
   }
 }