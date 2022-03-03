






import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:mobx/mobx.dart';
import 'package:payarapp/data/api/service/socket/websocketclient.dart';
import 'package:payarapp/domain/model/trading/model_all_balances.dart';
import 'package:payarapp/domain/model/trading/model_log_trading.dart';
import 'package:payarapp/domain/model/trading/model_orderbook_ask.dart';
import 'package:payarapp/domain/model/trading/model_orderbook_bid.dart';
import 'package:payarapp/domain/model/trading/model_ticker_price.dart';
import 'package:payarapp/domain/model/trading/model_trades.dart';
import 'package:payarapp/internal/dependencies/api_modul.dart';
import 'package:payarapp/internal/dependencies/repository_module.dart';
import 'package:payarapp/util/trade_handler.dart';
part 'state_screen_control.g.dart';
class StateListTicker=StateListTickerBase with _$StateListTicker;
abstract class StateListTickerBase with Store{

    @observable
    bool hasDataTicker=false;
    @observable
    bool hasDataBalances=false;
    @observable
     List<ModelAllBalances>? listBalances;
    @observable
    bool isError=false;
    WebSocketClient  _webSocketClient=WebSocketClient();
    @observable
    ModelTickerPrice? ticker;
    double _priceMarketAsk=0;
    double _priceMarketBid=0;
    bool _isTrading=false;
    @observable
    ObservableList<ModelLogTrading> listLogTrading=ObservableList<ModelLogTrading>();
    TradeHandler _tradeHandler=TradeHandler();
    List<ModelOrderBookBid> _bids=[];
    List<ModelOrderBookAsk> _asks=[];
    List<ModelTrades> _trading=[];
    int _tick=0;
    double _tickPrice=0.0;
    bool _isBuy=false;
    int _stateTrade=0;


    @action
    getTicker(){
      hasDataTicker=false;
     _webSocketClient.subscribeTicker(update: (ModelTickerPrice data){
        ticker=data;
        _priceMarketAsk=ticker!.ask;
        _priceMarketBid=ticker!.bid;
        hasDataTicker=true;
        _isBuy=_isValidTradeByLevel(_priceMarketBid);
        if(_isTrading){
          if(_stateTrade==1){
            startTrading();

          }else{
            _tradeHandler.control(bidPriceOfTicker:ticker!.bid, callback:(int status,double price,double profit){
              if(status==1){
                hasDataBalances=true;
                listBalances![0].total=listBalances![0].total+price*3;
                listBalances![1].total=listBalances![1].total+3;
                _stateTrade=1;
                // listLogTrading.add(ModelLogTrading(market: 'DOGE/USD',timeStamp:DateTime.now().toString(),status: 'open',profit: profit,nameLog:'Sell Start', size: 3,price: price));
                // Timer(Duration(seconds: 2), (){
                //   listLogTrading.add(ModelLogTrading(market: 'DOGE/USD',timeStamp:DateTime.now().toString(),status: 'executed',profit: profit,nameLog:'Sell End', size: 3,price: 0));
                // });

              }

              if(status==2){
                hasDataBalances=true;
                listBalances![0].total=listBalances![0].total+price*3;
                listBalances![1].total=listBalances![1].total+3;
                _stateTrade=1;
                // listLogTrading.add(ModelLogTrading(market: 'DOGE/USD',timeStamp:DateTime.now().toString(),status: 'open',profit: profit,nameLog:'Sell Start Trend Fell', size: 3,price: price));
                // Timer(Duration(seconds: 2), (){
                //   listLogTrading.add(ModelLogTrading(market: 'DOGE/USD',timeStamp:DateTime.now().toString(),status: 'executed',profit: profit,nameLog:'Sell End Trend Fell', size: 3,price: 0));
                // });
              }
            });
          }

          }



      });


   }
   //метод спроса-предложения
   _isValidTradeByGlass({required List<ModelOrderBookBid> bids,required List<ModelOrderBookAsk> asks}){
      double sizeBid=0.0;
      double sizeAsk=0.0;
      bids.forEach((element) {
        sizeBid+=element.size;
      });
      asks.forEach((element) {
        sizeAsk+=element.size;
      });
      return sizeAsk<sizeBid;
   }

   //метод пробития исскуственных микроуровней
   _isValidTradeByLevel(double bid){
      bool result=false;
      if(_tick==0){
        _tickPrice=bid+(bid*0.005)/100;
      }
      _tick++;
      if(_tickPrice<bid&&_tick==2){
        result= true;
       }
      if(_tick==2){
        _tick=0;
      }


      return result;
   }

   @action
   getOrders(){
      // webSocketClient!.subscribeOrders(channel: Constant.CHANNEL_ORDERS, update:(data){
      //   print('Orders $data');
      // });
   }

   @action
   getOrderBook(){
     _webSocketClient.subscribeOrderbookgrouped(update: (data){
        List asks=data['asks'] as List;
        List bids=data['bids'] as List;
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

      });


   }


   @action
   getTrade(){
     _webSocketClient.subscribeTrades(update: (value){
          List trades= value as List;
          trades.forEach((element) {
            _trading.add(ModelTrades.fromApi(map:element as Map<String,dynamic>));

          });

          _trading.forEach((element) {
            print('Trades ${element.price} side ${element.side}');
          });
     });
    }

    @action
    Future<void> getAllBalances() async{
       hasDataBalances=false;
       final result=await RepositoryModule.apiRepository().getBalance().catchError((error){
         //error hendler
       });
       hasDataBalances=true;
        listBalances=result;

    }

   @action
    close(){
     _webSocketClient.close();
   }

   @action
   startTrading(){
      if(_priceMarketAsk!=0){
        _isTrading=true;
        _tradeHandler.buy(_priceMarketAsk);
        _tradeHandler.bid(_priceMarketBid);
        hasDataBalances=true;
        listBalances![0].total=listBalances![0].total-_priceMarketAsk*3;
        listBalances![1].total=listBalances![1].total-3;
        _stateTrade=2;
         // listLogTrading.add(ModelLogTrading(market: 'DOGE/USD',timeStamp:DateTime.now().toString(),status: 'open',profit: 0,nameLog:'BUY Start', size: 3,price: _priceMarketAsk));
         // Timer(Duration(seconds: 2), (){
         //   listLogTrading.add(ModelLogTrading(market: 'DOGE/USD',timeStamp:DateTime.now().toString(),status: 'executed',profit: 0,nameLog:'BUY End', size: 3,price: _priceMarketAsk));
         // });
      }
   }

    @action
    stopTrading(){
         _isTrading=false;
       // listLogTrading.add(ModelLogTrading(market: 'DOGE/USD',timeStamp:DateTime.now().toString(),status: '-',profit: 0,nameLog:'Stop trading', size: 3,price: _priceMarketAsk));

    }





}