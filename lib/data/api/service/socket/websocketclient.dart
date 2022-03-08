




 import 'dart:convert';
 import 'package:convert/convert.dart';
import 'package:crypto/crypto.dart';
import 'package:payarapp/data/api/model/model_ticker_price_api.dart';
import 'package:payarapp/data/mapper/mapper_trading_data.dart';
import 'package:web_socket_channel/web_socket_channel.dart';
import '../../../../constant.dart';


class WebSocketClient{


   static const BASE_URL='wss://ftx.com/ws/';
   static const API_KEY='AQmjcrH8Q-vWS8tsrzZjqWDRzNXH-QVIysguGeu9';
   static const API_PRIVATE_KEY='S3FtewQslutLHbji4hm2_FyJOpjjDMRN0imc6xjY';
   WebSocketChannel? _channelOpenOrder;
   WebSocketChannel? _chanellTicker;
   WebSocketChannel? _channelTrades;
   WebSocketChannel? _channelOrdersbookGrouped;




   WebSocketClient(){
     _channelOpenOrder=WebSocketChannel.connect(Uri.parse('wss://ftx.com/ws/'));
    _chanellTicker=WebSocketChannel.connect(Uri.parse('wss://ftx.com/ws/'));
     _channelTrades=WebSocketChannel.connect(Uri.parse('wss://ftx.com/ws/'));
     _channelOrdersbookGrouped=WebSocketChannel.connect(Uri.parse('wss://ftx.com/ws/'));
   }


   reconnect(int channel){
     print('Reconnect $channel');
     switch(channel){
       case 1:
         Future.delayed(Duration(milliseconds: 1000)).then((_){
           _channelOpenOrder=WebSocketChannel.connect(Uri.parse('wss://ftx.com/ws/'));
         });
       break;
       case 2:
         Future.delayed(Duration(milliseconds: 1000)).then((_){
           _chanellTicker=WebSocketChannel.connect(Uri.parse('wss://ftx.com/ws/'));
         });
       break;
       case 3:
         Future.delayed(Duration(milliseconds: 1000)).then((_){
           _channelTrades=WebSocketChannel.connect(Uri.parse('wss://ftx.com/ws/'));
         });
       break;
       case 4:
         Future.delayed(Duration(milliseconds: 1000)).then((_){
           _channelOrdersbookGrouped=WebSocketChannel.connect(Uri.parse('wss://ftx.com/ws/'));
         });
       break;
     }
   }
     //Тикерный канал предоставляет последние лучшие рыночные данные о предложениях и предложениях.
   subscribeTicker({required Function update}){
     _chanellTicker!.sink.add(jsonEncode({
       'op': 'subscribe', 'channel': Constant.CHANNEL_TICKER, 'market': 'DOGE/USD'
     }));
     _chanellTicker!.stream.listen((event) {
       if(jsonDecode(event)['data']!=null){
         update(MapperTradingData.fromApiTicker(modelTickerPriceApi: ModelTickerPriceApi.fromApi(map: jsonDecode(event)['data'])));
       }
     },onError: reconnect(2),onDone: reconnect(2));
    

   }

    //Канал сделок предоставляет данные обо всех сделках на рынке.
   subscribeTrades({required Function update}){
     _channelTrades!.sink.add(jsonEncode({
       'op': 'subscribe', 'channel': 'trades', 'market': 'DOGE/USD'
     }));
     _channelTrades!.stream.listen((event) {
       if(jsonDecode(event)['data']!=null){
         update(jsonDecode(event)['data']);
       }
     },onError: reconnect(3),onDone: reconnect(3));

   }

   //получение данных  открыты орерах
   subscribeOrders({required Function update})async{
     final ts=DateTime.now().millisecondsSinceEpoch;
     var key = utf8.encode(API_PRIVATE_KEY);
     var signaturePayload = utf8.encode('${ts}websocket_login');
     final hmac256=Hmac(sha256, key);
     Digest sha256Result = hmac256.convert(signaturePayload);
     _channelOpenOrder!.sink.add(jsonEncode({
       "args": {
         "key": API_KEY,
         "sign":  hex.encode(sha256Result.bytes),
         "time": ts
       },
       'op': 'login'
     })
    );
     _channelOpenOrder!.sink.add(jsonEncode({'op': 'subscribe', 'channel': 'orders'}));
     _channelOpenOrder!.stream.listen((event)=>update(event),onDone: reconnect(1),onError: reconnect(1));
   }




   //Канал книги ордеров предоставляет данные о 100 лучших ордерах книги ордеров с обеих сторон..
   subscribeOrderBookGrouped({required Function update}){
     _channelOrdersbookGrouped!.sink.add(jsonEncode({
       'op': 'subscribe', 'channel': 'orderbook', 'market': 'DOGE/USD'
     }));
     _channelOrdersbookGrouped!.stream.listen((event) {
       if(jsonDecode(event)['data']!=null){
         update(jsonDecode(event)['data']);
       }

     },onError: reconnect(4),onDone: reconnect(4));

   }



   close(){
     _channelOpenOrder!.sink.close();
     _chanellTicker!.sink.close();
     _channelTrades!.sink.close();
     _channelOrdersbookGrouped!.sink.close();
   }
 }