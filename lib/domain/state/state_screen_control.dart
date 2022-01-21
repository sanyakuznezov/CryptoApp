






import 'dart:async';

import 'package:flutter/material.dart';
import 'package:mobx/mobx.dart';
import 'package:payarapp/data/api/service/socket/websocketclient.dart';
import 'package:payarapp/domain/model/trading/model_all_balances.dart';
import 'package:payarapp/domain/model/trading/model_log_trading.dart';
import 'package:payarapp/domain/model/trading/model_orderbook_ask.dart';
import 'package:payarapp/domain/model/trading/model_orderbook_bid.dart';
import 'package:payarapp/domain/model/trading/model_ticker_price.dart';
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
    @observable
    ModelTickerPrice? ticker;
    WebSocketClient? webSocketClient=WebSocketClient();
    double _priceMarketAsk=0;
    double _priceMarketBid=0;
    bool _isTrading=false;
    @observable
    ObservableList<ModelLogTrading> listLogTrading=ObservableList<ModelLogTrading>();
    TradeHandler _tradeHandler=TradeHandler();
    List<ModelOrderBookBid> _bids=[];
    List<ModelOrderBookAsk> _asks=[];
    int _iterableDot=0;
    int _tick=0;
    double _tickPrice=0.0;
    bool _isBuy=false;
    int _stateTrade=0;


    @action
    getTicker(){
      hasDataTicker=false;
      webSocketClient!.subscribeTicker(update: (ModelTickerPrice data){
        ticker=data;
        _priceMarketAsk=ticker!.ask;
        _priceMarketBid=ticker!.bid;
        hasDataTicker=true;
        _isBuy=isValidTrade(_priceMarketBid);
        if(_isTrading){
          if(_stateTrade==1&&_isBuy){
            startTrading();
          }else if(_stateTrade==2){
            _tradeHandler.control(bidPriceOfTicker:ticker!.bid, callback:(int status,double price,double profit){
              if(status==1){
                hasDataBalances=true;
                listBalances![0].total=listBalances![0].total+price*3;
                listBalances![1].total=listBalances![1].total+3;
                listLogTrading.add(ModelLogTrading(market: 'DOGE/USD',timeStamp:DateTime.now().toString(),status: 'open',profit: profit,nameLog:'Sell Start', size: 3,price: price));
                Timer(Duration(seconds: 2), (){
                  listLogTrading.add(ModelLogTrading(market: 'DOGE/USD',timeStamp:DateTime.now().toString(),status: 'executed',profit: profit,nameLog:'Sell End', size: 3,price: 0));
                  _stateTrade=1;
                });

              }

              if(status==2){
                hasDataBalances=true;
                listBalances![0].total=listBalances![0].total+price*3;
                listBalances![1].total=listBalances![1].total+3;
                listLogTrading.add(ModelLogTrading(market: 'DOGE/USD',timeStamp:DateTime.now().toString(),status: 'open',profit: profit,nameLog:'Sell Start Trend Fell', size: 3,price: price));
                Timer(Duration(seconds: 2), (){
                  listLogTrading.add(ModelLogTrading(market: 'DOGE/USD',timeStamp:DateTime.now().toString(),status: 'executed',profit: profit,nameLog:'Sell End Trend Fell', size: 3,price: 0));
                  _stateTrade=1;
                });
              }
            });
          }


        }
      });


   }


   isValidTrade(double bid){
      bool result=false;
      if(_tick==0){
        _tickPrice=bid+(bid*0.001)/100;
      }
      _tick++;
      if(_tickPrice<bid&&_tick==2){
          _iterableDot++;
       }
      if(_tick==2){
        _tick=0;
      }
      print('tick $_tick _iterableDot $_iterableDot _tickPrice $_tickPrice bid $bid');
      if(_iterableDot==3){
        result= true;
        _iterableDot=0;
      }
      return result;
   }

   @action
   getOrders(){
      // webSocketClient!.subscribeOrders(channel: Constant.CHANNEL_ORDERS, update:(data){
      //   print('Orders $data');
      // });
     // webSocketClient!.subscribeTrades(update: (value){
     //   print('Trades data ${value}');
     // });
   }

   @action
   getOrderBook(){
      // webSocketClient!.subscribeOrderbookgrouped(update: (data){
      //   List asks=data['asks'] as List;
      //   if(asks.isNotEmpty){
      //     asks.forEach((element) {
      //       if(element[1]!=0.0){
      //         _asks.add(ModelOrderBookAsk(size:element[1],time:data['time'], price: element[0], checksum: data['checksum']));
      //       }
      //
      //     });
      //   }
      //    _asks.forEach((element) {
      //      print('list ask ${element.price}- ${element.size} lenght ${_asks.length}');
      //    });
      // });
   }

    @action
    Future<void> getAllBalances() async{
       hasDataBalances=false;
       final result=await RepositoryModule.firebaseRepository().getBalance().catchError((error){
         //error hendler
       });
       hasDataBalances=true;
        listBalances=result;

    }

   @action
    close(){
      webSocketClient!.close();
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
         listLogTrading.add(ModelLogTrading(market: 'DOGE/USD',timeStamp:DateTime.now().toString(),status: 'open',profit: 0,nameLog:'BUY Start', size: 3,price: _priceMarketAsk));
         Timer(Duration(seconds: 2), (){
           _stateTrade=2;
           listLogTrading.add(ModelLogTrading(market: 'DOGE/USD',timeStamp:DateTime.now().toString(),status: 'executed',profit: 0,nameLog:'BUY End', size: 3,price: _priceMarketAsk));
         });
      }
   }

    @action
    stopTrading(){
         _isTrading=false;
        listLogTrading.add(ModelLogTrading(market: 'DOGE/USD',timeStamp:DateTime.now().toString(),status: '-',profit: 0,nameLog:'Stop trading', size: 3,price: _priceMarketAsk));

    }

}