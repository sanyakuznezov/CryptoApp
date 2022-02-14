




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
  List<ModelOrderBookBid> _bids=[];
  @observable
  List<ModelOrderBookAsk> _asks=[];

  @action
  getOrderBook(){
    _webSocketClient.subscribeOrderbookgrouped(update: (data){
      List asks=ModelOrderBook.fromApi(map: data).asks;
      List bids=ModelOrderBook.fromApi(map: data).bids;
      int _indexAsk=-1;
      int _indexBid=-1;
      if(asks.isNotEmpty){
        asks.forEach((element) {
          if(_asks.isNotEmpty){
            _asks.removeWhere((i)=>i.size==0.0);
            _indexAsk=_asks.indexWhere((item) => item.price==element[0]);
            if(_indexAsk>-1){
              _asks[_indexAsk].size=element[1];
            }else{
              _asks.add(ModelOrderBookAsk(size:element[1],time:data['time'], price: element[0], checksum: data['checksum']));
            }

          }else{
            _asks.add(ModelOrderBookAsk(size:element[1],time:data['time'], price: element[0], checksum: data['checksum']));
          }


        });
      }
      _asks.forEach((element) {
        print('Asks ${element.price}');
      });
      if(bids.isNotEmpty){
        bids.forEach((element) {
          if(_bids.isNotEmpty){
            _bids.removeWhere((i)=>i.size==0.0);
            _indexBid=_bids.indexWhere((item) => item.price==element[0]);
            if(_indexBid>-1){
              _bids[_indexBid].size=element[1];
            }else{
              _bids.add(ModelOrderBookBid(size:element[1],time:data['time'], price: element[0], checksum: data['checksum']));
            }

          }else{
            _bids.add(ModelOrderBookBid(size:element[1],time:data['time'], price: element[0], checksum: data['checksum']));
          }


        });
      }
      _bids.forEach((element) {
        print('Bids ${element.price}');
      });

    });


  }

  @action
  close(){
    _webSocketClient.close();
  }
}