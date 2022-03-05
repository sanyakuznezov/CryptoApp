




import 'dart:async';
import 'dart:convert';

import 'package:flutter/services.dart';
import 'package:mobx/mobx.dart';
import 'package:payarapp/constant.dart';
import 'package:payarapp/data/api/service/socket/websocketclient.dart';
import 'package:payarapp/domain/features/strategy_limit_order_place.dart';
import 'package:payarapp/domain/features/strategy_market_order_place.dart';
import 'package:payarapp/domain/model/trading/model_log_trading.dart';
import 'package:payarapp/domain/model/trading/model_order_book.dart';
import 'package:payarapp/domain/model/trading/model_orderbook_ask.dart';
import 'package:payarapp/domain/model/trading/model_orderbook_bid.dart';
import 'package:payarapp/domain/model/trading/model_ticker_price.dart';
import 'package:payarapp/domain/model/trading/model_trades.dart';
import 'package:payarapp/internal/dependencies/repository_module.dart';




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
  double _priceCurrent=0.0;
  double _pB=0;
  double _pS=0;
  @observable
  double profit=0;
  @observable
  double takeLosses=0;
  @observable
  double takeProfit=0;
  double _stopLoss=0;
  double buyPrice=0;
  double sellPrice=0;
  @observable
  bool trandUp=true;
  @observable
  bool isTrade=false;
  int state=1;
  @observable
  int isUp=0;
  double _priceTakeProfit=0.0;
  @observable
  int levelUp=0;
  double _dot=0.0;
  Timer? _timer;
  bool _isClearLevel=false;
  List<double> _i=[];
  Map _log={'takeProfit':0.0,'stopLoss':0.0,'timeStampBuy':0,'profit':0.0,'priceBuy':0.0,'priceSell':0.0,'intervalAskBidBuy':0.0,'glassAskDischargedBuy':false,
  'levelUpBuy':0.0,'isUpSell':0,'timeStampSell':0,'intervalAskBidSell':0.0,'glassAskDischargedSell':false,
    'levelUpSell':0.0,'isUpBuy':0};




  @action
  getOrderBook()async{
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
   _timer= Timer.periodic(Duration(seconds: 60), (timer) {
      _dot=0.0;
      _i.clear();
      levelUp=0;
    });
    _webSocketClient.subscribeTicker(update: (ModelTickerPrice data){
      _pB = data.ask;
      _pS = data.bid;
      if(isTrade){
        candle(_pS);
        botTrade(_pB,_pS);

      }
    });
  }

   candle(double pS){
     if(_dot==0.0){
       _dot=pS;
     }else{
       if(_dot>pS){
         if(!_isClearLevel&&isUp==3){
           levelUp=0;
           _isClearLevel=true;
         }
         isUp=1;
       }else if(_dot==pS){
         _i.clear();
         levelUp=0;
         isUp=2;
       }else{
         if(_isClearLevel&&isUp==1){
           levelUp=0;
           _isClearLevel=false;
         }
         isUp=3;
       }
     }

     levelUpCandle(pS);
   }
  //not work
  @action
  levelUpCandle(double pS){
    if(_i.isEmpty){
      _i.add(pS);
    }else if(_i.length==1){
      _i.add(pS);
    }else if(_i.length==2){
      if(_i[1]!=pS){
        _i[0]=_i[1];
        _i[1]=pS;
      }
    }

    if(_i.length==2){
      if(_i[0]>_i[1]){
        levelUp--;
      }else if(_i[0]==_i[1]){
        levelUp=0;
      }else if(_i[0]<_i[1]){
        levelUp++;
      }
    }
  }




  botTrade(double pB,double pS){
    if(state==1){
      // if(isUp==3&&levelUp>50){
      //   buy();
      // }
      buy();
    }
    if(state==2){
      handlerTrade(pS);
    }
  }

  sell(bool isProfit){
    sellPrice=_pS;
    if(isProfit){
      takeProfit+=_pS-buyPrice;
      _log.update('profit', (value) => takeProfit);
    }else{
      takeLosses+=_pS-buyPrice;
      _log.update('profit', (value) => takeLosses);

    }
    buyPrice=0;
    _stopLoss=0;
    state=1;
    _log.update('priceSell', (value) => sellPrice);
    _log.update('intervalAskBidSell', (value) => getInterval(_pB, _pS));
    _log.update('glassAskDischargedSell', (value) =>trandUp );
    _log.update('levelUpSell', (value) => levelUp);
    _log.update('isUpSell', (value) => isUp);
    _log.update('timeStampSell', (value) => DateTime.now().toString());
    RepositoryModule.apiRepository().insertLogTrading(modelLogTrading:ModelLogTrading(
        takeProfit: _log['takeProfit'],
      stopLoss: _log['stopLoss'],
        priceBuy: _log['priceBuy'],
        priceSell: _log['priceSell'],
        intervalAskBidSell: _log['intervalAskBidSell'],
        intervalAskBidBuy: _log['intervalAskBidBuy'],
        glassAskDischargedBuy: _log['glassAskDischargedBuy'],
        glassAskDischargedSell: _log['glassAskDischargedSell'],
        levelUpBuy: _log['levelUpBuy'],
        levelUpSell: _log['levelUpSell'],
        isUpSell: _log['isUpSell'],
        isUpBuy: _log['isUpBuy'],
        timeStampBuy: _log['timeStampBuy'],
        timeStampSell: _log['timeStampSell'],
        profit: _log['profit']));
    //_strategyLimitOrder.placeOrderSell(market: Constant.MARKET_DOGE_USD, percentageOfBalance: 100, price: pB);
    // _strategyMarket.placeOrderMarketSell(market: Constant.MARKET_DOGE_USD);
  }
 handlerTrade(double pS){
   if(pS>_priceTakeProfit){
     sell(true);
   }
   if(_stopLoss>pS){
     sell(false);
   }
 }

  getInterval(double ask,double bid){
    return ask-bid;
  }

  Future<List<ModelLogTrading>?> getListLog()async{
    return await RepositoryModule.apiRepository().getListTrading();
  }


  buy(){
    if(buyPrice==0.0){
      buyPrice=_pB;
      sellPrice=0.0;
      _priceTakeProfit=asksFinal[2].price;
      _stopLoss=bidsFinal[4].price;
      state=2;
      _log.update('takeProfit', (value) => _priceTakeProfit);
      _log.update('priceBuy', (value) => buyPrice);
      _log.update('intervalAskBidBuy', (value) => getInterval(_pB, _pS));
      _log.update('glassAskDischargedBuy', (value) => trandUp);
      _log.update('levelUpBuy', (value) => levelUp);
      _log.update('isUpBuy', (value) => isUp);
      _log.update('timeStampBuy', (value) => DateTime.now().toString());
      _log.update('stopLoss', (value) => _stopLoss);

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
    _timer!.cancel();
  }

}