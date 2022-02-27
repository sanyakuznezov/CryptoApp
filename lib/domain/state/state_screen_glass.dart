




import 'dart:convert';

import 'package:flutter/services.dart';
import 'package:mobx/mobx.dart';
import 'package:payarapp/constant.dart';
import 'package:payarapp/data/api/service/socket/websocketclient.dart';
import 'package:payarapp/domain/features/strategy_limit_order_place.dart';
import 'package:payarapp/domain/features/strategy_market_order_place.dart';
import 'package:payarapp/domain/model/trading/model_order_book.dart';
import 'package:payarapp/domain/model/trading/model_orderbook_ask.dart';
import 'package:payarapp/domain/model/trading/model_orderbook_bid.dart';
import 'package:payarapp/domain/model/trading/model_ticker_price.dart';
import 'package:payarapp/domain/model/trading/model_trades.dart';




part 'state_screen_glass.g.dart';
class StateScreenGlass=StateScreenGlassBase with _$StateScreenGlass;

abstract class StateScreenGlassBase with Store{

  WebSocketClient  _webSocketClient=WebSocketClient();
  late StrategyMarket _strategyMarket=StrategyMarket();
  late StrategyLimitOrder _strategyLimitOrder=StrategyLimitOrder();
  @observable
  List<ModelOrderBookBid> bidsFinal=[];
  @observable
  List<ModelOrderBookAsk> asksFinal=[];
  @observable
  bool hasData=false;
  List<ModelTrades> _trading=[];
  double priceCurrent=0.0;
  double pB=0;
  double pS=0;
  @observable
  double profit=0;
  @observable
  double takeLosses=0;
  double takeProfit=0;
  double stopLoss=0;
  double buyPrice=0;
  double sellPrice=0;
  @observable
  bool trandUp=true;
  @observable
  bool isTrade=false;
  int state=1;



  @action
  getOrderBook() {
    hasData=false;
   _webSocketClient.subscribeOrderbookgrouped(update: (data){
      List asks=ModelOrderBook.fromApi(map: data).asks;
      List bids=ModelOrderBook.fromApi(map: data).bids;
      hasData=true;
      asks.reversed;
      int _indexAsk=-1;
      int _indexBid=-1;
      if(asks.isNotEmpty){
        asks.forEach((element)  async {
          if(data['action']=='partial'){
            asksFinal.add(ModelOrderBookAsk(size:element[1],time:data['time'], price: element[0], checksum: data['checksum']));
          }else if(data['action']=='update'){
              _indexAsk=asksFinal.indexWhere((item) => item.price==element[0]);
              if(_indexAsk>-1){
                asksFinal[_indexAsk].size=element[1];
              }else{
                for (int i=0;asksFinal.length>i;i++){
                  if(asksFinal[i].price>element[0]){
                    asksFinal.insert(i, ModelOrderBookAsk(size:element[1],time:data['time'], price: element[0], checksum: data['checksum']));
                    break;
                  }
                }
              }
              asksFinal.removeWhere((i)=>i.size==0.0);
          }
        });
      }
      if(bids.isNotEmpty){
        bids.forEach((element) async {
          if(data['action']=='partial'){
            bidsFinal.add(ModelOrderBookBid(size:element[1],time:data['time'], price: element[0], checksum: data['checksum']));
          }else if(data['action']=='update'){
              _indexBid=bidsFinal.indexWhere((item) => item.price==element[0]);
              if(_indexBid>-1){
                bidsFinal[_indexBid].size=element[1];
              }else{
                for(int i=0;bidsFinal.length>i;i++) {
                  if(bidsFinal[i].price<element[0]){
                    bidsFinal.insert(i, ModelOrderBookBid(size:element[1],time:data['time'], price: element[0], checksum: data['checksum']));
                    break;
                  }
                }

              }
              bidsFinal.removeWhere((i)=>i.size==0.0);
          }
        });

     }
      trandHandler(bidsFinal, asksFinal);
    });
  }

  @action
  trandHandler(List<ModelOrderBookBid> bids,List<ModelOrderBookAsk> asks){
    int glassAsksLevel=0;
    int glassBidsLevel=0;
    for(int i=0;i<20;i++){
      if(bids[i].size>asks[i].size){
        glassAsksLevel++;
      }else{
        glassBidsLevel++;
      }

        if(glassAsksLevel>glassBidsLevel){
          trandUp=true;
        }else{
          trandUp=false;
        }


    }
  }

  getSubscribeOrders(){
    _webSocketClient.subscribeOrders(update: (data){
      print('Open order ${data}');
    });
  }

  getTicker(){
    _webSocketClient.subscribeTicker(update: (ModelTickerPrice data){
      pB = data.ask;
      pS = data.bid;
      if(isTrade){
       botTrade(pB,pS);
      }
    });
  }

  botTrade(double pB,double pS){
    if(state==1){
      buy();
    }
    if(state==2){
      handlerTrade(pS);
    }
  }

  sell(bool isProfit){
    print('Price client sell $pS}');
    if(isProfit){
      takeProfit=pS-buyPrice;
    }else{
      takeLosses=pS-buyPrice;
    }
    buyPrice=0;
    stopLoss=0;
    state=1;
    //_strategyLimitOrder.placeOrderSell(market: Constant.MARKET_DOGE_USD, percentageOfBalance: 100, price: pB);
    // _strategyMarket.placeOrderMarketSell(market: Constant.MARKET_DOGE_USD);
  }
 handlerTrade(double pS){
    print('buyPrice $buyPrice pS $pS');
   if(pS>buyPrice){
     sell(true);
   }
   if(stopLoss>pS){
     sell(false);
   }
 }
  buy(){
    if(buyPrice==0){
      buyPrice=pB;
      stopLoss=bidsFinal[5].price;
      state=2;
      print('buyPrice $buyPrice stopLoss $stopLoss');
    }
    //_strategyLimitOrder.placeOrderBuy(market: Constant.MARKET_DOGE_USD, percentageOfBalance: 100, price: pS);
    //_strategyMarket.placeOrderMarketBuy(market: Constant.MARKET_DOGE_USD);
  }
  // @action
  // getTrade(){
  //   _webSocketClient.subscribeTrades(update: (value){
  //     List trades= value as List;
  //     trades.forEach((element) {
  //       _trading.add(ModelTrades.fromApi(map:element as Map<String,dynamic>));
  //
  //     });
  //     print('Current price $priceCurrent');
  //     _trading.forEach((element) {
  //       if(priceCurrent==element.price){
  //         print('Succees Order');
  //       }
  //       print('Trades ${element.price} side ${element.side}');
  //     });
  //   });
  // }


  @action
  close(){
    _webSocketClient.close();
  }


  handlerPriceBid(double bid){

  }
}