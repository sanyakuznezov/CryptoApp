




 import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:payarapp/data/api/model/model_ticker_price_api.dart';
import 'package:web_socket_channel/io.dart';
import 'package:web_socket_channel/web_socket_channel.dart';

class WebSocketClient{

   static const BASE_URL='wss://ftx.com/ws/';
   WebSocketChannel? _channel;

   WebSocketClient():
         _channel = WebSocketChannel.connect(Uri.parse('wss://ftx.com/ws/'));


   Stream<dynamic> get getTicker{
     _channel!.sink.add(jsonEncode({
       'op': 'subscribe', 'channel': 'ticker', 'market': 'DOGE/USD'
     }));
     return _channel!.stream.map<dynamic>((event) =>event);
   }


   closeTicker(){
     _channel!.sink.close();
   }
 }