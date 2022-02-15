




import 'dart:convert';

import 'package:mobx/mobx.dart';
import 'package:payarapp/data/api/service/socket/websocketclient.dart';
import 'package:payarapp/domain/model/trading/model_order_book.dart';
import 'package:payarapp/domain/model/trading/model_orderbook_ask.dart';
import 'package:payarapp/domain/model/trading/model_orderbook_bid.dart';




part 'state_screen_glass.g.dart';
class StateScreenGlass=StateScreenGlassBase with _$StateScreenGlass;

abstract class StateScreenGlassBase with Store{

  WebSocketClient  _webSocketClient=WebSocketClient();
  @observable
  List<ModelOrderBookBid> bidsFinal=[];
  @observable
  List<ModelOrderBookAsk> asksFinal=[];
  @observable
  bool hasData=false;

  @action
  getOrderBook(){
    hasData=false;
    _webSocketClient.subscribeOrderbookgrouped(update: (data){
      List asks=ModelOrderBook.fromApi(map: data).asks;
      List bids=ModelOrderBook.fromApi(map: data).bids;
      hasData=true;
      int _indexAsk=-1;
      int _indexBid=-1;
      if(asks.isNotEmpty){
        asks.forEach((element) {
          if(asks.isNotEmpty){
            asksFinal.removeWhere((i)=>i.size==0.0);
            _indexAsk=asksFinal.indexWhere((item) => item.price==element[0]);
            if(_indexAsk>-1){
              asksFinal[_indexAsk].size=element[1];
            }else{
              asksFinal.add(ModelOrderBookAsk(size:element[1],time:data['time'], price: element[0], checksum: data['checksum']));
            }

          }else{
            asksFinal.add(ModelOrderBookAsk(size:element[1],time:data['time'], price: element[0], checksum: data['checksum']));
          }

        });
      }

      if(bids.isNotEmpty){
        bids.forEach((element) {
          if(bids.isNotEmpty){
            bidsFinal.removeWhere((i)=>i.size==0.0);
            _indexBid=bidsFinal.indexWhere((item) => item.price==element[0]);
            if(_indexBid>-1){
              bidsFinal[_indexBid].size=element[1];
            }else{
              bidsFinal.add(ModelOrderBookBid(size:element[1],time:data['time'], price: element[0], checksum: data['checksum']));
            }

          }else{
            bidsFinal.add(ModelOrderBookBid(size:element[1],time:data['time'], price: element[0], checksum: data['checksum']));
          }
        });
      }

    });


  }

  @action
  close(){
    _webSocketClient.close();
  }
}