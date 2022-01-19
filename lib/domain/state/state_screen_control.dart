






import 'dart:async';

import 'package:flutter/material.dart';
import 'package:mobx/mobx.dart';
import 'package:payarapp/data/api/service/socket/websocketclient.dart';
import 'package:payarapp/domain/model/trading/model_all_balances.dart';
import 'package:payarapp/domain/model/trading/model_log_trading.dart';
import 'package:payarapp/domain/model/trading/model_orderbook.dart';
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

    @action
    getTicker(){
      hasDataTicker=false;
      webSocketClient!.subscribeTicker(update: (ModelTickerPrice data){
        ticker=data;
        _priceMarketAsk=ticker!.ask;
        _priceMarketBid=ticker!.bid;
        hasDataTicker=true;
        if(_isTrading){
         _tradeHandler.control(bidPriceOfTicker:ticker!.bid, callback:(int status,double price,double profit){
            if(status==1){
              hasDataBalances=true;
              listBalances![0].total=listBalances![0].total+price*3;
              listBalances![1].total=listBalances![1].total+3;
              listLogTrading.add(ModelLogTrading(market: 'DOGE/USD',timeStamp:DateTime.now().toString(),status: 'open',profit: profit,nameLog:'Sell Start', size: 3,price: price));
              Timer(Duration(seconds: 2), (){
                listLogTrading.add(ModelLogTrading(market: 'DOGE/USD',timeStamp:DateTime.now().toString(),status: 'executed',profit: profit,nameLog:'Sell End', size: 3,price: 0));
                startTrading();
              });

            }

            if(status==2){
              hasDataBalances=true;
              listBalances![0].total=listBalances![0].total+price*3;
              listBalances![1].total=listBalances![1].total+3;
              listLogTrading.add(ModelLogTrading(market: 'DOGE/USD',timeStamp:DateTime.now().toString(),status: 'open',profit: profit,nameLog:'Sell Start Trend Fell', size: 3,price: price));
              Timer(Duration(seconds: 2), (){
                listLogTrading.add(ModelLogTrading(market: 'DOGE/USD',timeStamp:DateTime.now().toString(),status: 'executed',profit: profit,nameLog:'Sell End Trend Fell', size: 3,price: 0));
                startTrading();
              });
            }
         });

        }
      });


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
      webSocketClient!.subscribeOrderbookgrouped(update: (ModelOrderBook data){
        print("Ask: ${data.asks} Bids: ${data.bids}");

      });
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