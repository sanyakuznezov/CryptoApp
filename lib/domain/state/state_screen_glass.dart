




import 'dart:async';
import 'dart:convert';

import 'package:flutter/services.dart';
import 'package:mobx/mobx.dart';
import 'package:payarapp/constant.dart';
import 'package:payarapp/data/api/service/socket/websocketclient.dart';
import 'package:payarapp/domain/features/strategy_limit_order_place.dart';
import 'package:payarapp/domain/features/strategy_market_order_place.dart';
import 'package:payarapp/domain/model/trading/model_log_trading.dart';
import 'package:payarapp/domain/model/trading/model_open_order.dart';
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
  int levelUpAsk=0;
  @observable
  int levelUpBid=0;
  double _dot=0.0;
  Timer? _timer;
  bool _isClearLevel=false;
  List<double> _i=[];
  List<double> _i1=[];
  int _index=0;
  int _idOrder=0;
  bool _isPlace=false;
  Map _log={'takeProfit':0.0,'stopLoss':0.0,'timeStampBuy':0,'profit':0.0,'priceBuy':0.0,'priceSell':0.0,'intervalAskBidBuy':0.0,'glassAskDischargedBuy':false,
  'levelUpBuy':0.0,'isUpSell':0,'timeStampSell':0,'intervalAskBidSell':0.0,'glassAskDischargedSell':false,
    'levelUpSell':0.0,'isUpBuy':0};




  @action
  getOrderBook()async{
    hasData=false;
   _webSocketClient.subscribeOrderBookGrouped(update: (data){
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
      if(_isPlace){
        trandHandler(bidsFinal, asksFinal);
      }

    });
  }

  @action
  trandHandler(List<ModelOrderBookBid> bids,List<ModelOrderBookAsk> asks) {
    _index=0;
    if(state==2){
      bids.forEach((element) {
        _index++;
        if(element.price==buyPrice){
          print('Position order buy $_index');
          if(_index>20){
            cancelOrder();
          }
        }
      });
    }else if(state==4){
      asks.forEach((element) {
        _index++;
        if(element.price==sellPrice){
          print('Position order sell $_index');
          if(_index>20){
            cancelOrder();
          }
        }
      });
    }

    // int glassAsksLevel=0;
    // int glassBidsLevel=0;
    // for(int i=0;i<20;i++){
    //   if(bids[i].size>asks[i].size){
    //     glassAsksLevel++;
    //   }else{
    //     glassBidsLevel++;
    //   }
    //
    //     if(glassAsksLevel>glassBidsLevel){
    //       trandUp=true;
    //     }else{
    //       trandUp=false;
    //     }
    //
    //
    // }
  }

  cancelOrder()async{
    isTrade=false;
    _isPlace=false;
    final result= await RepositoryModule.apiRepository().cancelOrder(id: _idOrder.toString());
    print('Cancel Order Result $result');
  }
  // getSubscribeOrders(){
  //   _webSocketClient.subscribeOrders(update: (data){
  //     print('Open order ${data}');
  //   });
  // }

  getTicker(){
   _timer= Timer.periodic(Duration(minutes: 5), (timer) {
      _dot=0.0;
      _i.clear();
      levelUpAsk=0;
      levelUpBid=0;
    });
    _webSocketClient.subscribeTicker(update: (ModelTickerPrice data){
      _pB = data.ask;
      _pS = data.bid;
      if(isTrade){
        candle(_pB,_pS);
        botTrade();

      }
    });
  }

   candle(double pB,double pS){
     // if(_dot==0.0){
     //   _dot=pB;
     // }else{
     //   if(_dot>pB){
     //     if(!_isClearLevel&&isUp==3){
     //       levelUpAsk=0;
     //       _isClearLevel=true;
     //     }
     //     isUp=1;
     //   }else if(_dot==pB){
     //     _i.clear();
     //     levelUpAsk=0;
     //     isUp=2;
     //   }else{
     //     if(_isClearLevel&&isUp==1){
     //       levelUpAsk=0;
     //       _isClearLevel=false;
     //     }
     //     isUp=3;
     //   }
     // }

     levelUpCandleAsk(pB);
     levelUpCandleBid(pS);
   }
  //not work
  @action
  levelUpCandleAsk(double pB){
    if(_i.isEmpty){
      _i.add(pB);
    }else if(_i.length==1){
      _i.add(pB);
    }else if(_i.length==2){
      if(_i[1]!=pB){
        _i[0]=_i[1];
        _i[1]=pB;
      }
    }

    if(_i.length==2){
      if(_i[0]>_i[1]){
        if(levelUpAsk>0){
          levelUpAsk=0;
        }
        levelUpAsk--;
      }else if(_i[0]<_i[1]){
        if(levelUpAsk<0){
          levelUpAsk=0;
        }
        levelUpAsk++;
      }
    }

    if(levelUpAsk<0){
      isUp=1;
    }else{
      isUp=3;
    }

  }

  @action
  levelUpCandleBid(double pS){
    if(_i1.isEmpty){
      _i1.add(pS);
    }else if(_i1.length==1){
      _i1.add(pS);
    }else if(_i1.length==2){
      if(_i1[1]!=pS){
        _i1[0]=_i1[1];
        _i1[1]=pS;
      }
    }

    if(_i1.length==2){
      if(_i1[0]>_i1[1]){
        if(levelUpBid>0){
          levelUpBid=0;
        }
        levelUpBid--;
      }else if(_i[0]<_i[1]){
        if(levelUpBid<0){
          levelUpBid=0;
        }
        levelUpBid++;
      }
    }


  }



  botTrade(){
    if(state==1){
      buy();
    }
    if(state==3){
      sell();

    }
  }

  buy()async{
    buyPrice=bidsFinal[0].price;
    sellPrice=0.0;
    state=2;
    print('Method BUY price $buyPrice');
    final buy=await _strategyLimitOrder.placeOrderBuy(market: Constant.MARKET_DOGE_USD, percentageOfBalance: 100, price: bidsFinal[0].price);
    //_strategyMarket.placeOrderMarketBuy(market: Constant.MARKET_DOGE_USD);
    if(buy>0){
      _idOrder=buy;
      _isPlace=true;
      print('Order place buy ID $buy Price $buyPrice');
      handlerOpenOrder();
    }else{
      print('Order sell place error');
    }
  }

  sell()async{
    sellPrice=asksFinal[0].price;
    buyPrice=0.0;
    state=4;
    print('Method SELL price $sellPrice');
   final sell=await _strategyLimitOrder.placeOrderSell(market: Constant.MARKET_DOGE_USD, percentageOfBalance: 100, price: asksFinal[0].price);
    // _strategyMarket.placeOrderMarketSell(market: Constant.MARKET_DOGE_USD);
    if(sell>0){
      _idOrder=sell;
      _isPlace=true;
      print('Order place sell ID $sell Price $sellPrice');
      handlerOpenOrder();
    }else{
      print('Order sell place error');
    }
  }


  getInterval(double ask,double bid){
    return ask-bid;
  }

  Future<List<ModelLogTrading>?> getListLog()async{
    return await RepositoryModule.apiRepository().getListTrading();
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

//todo проратать стратегию buy-market sell-limit
  testTrade(int status)async{
    state=2;
  // final result=await _strategyMarket.placeOrderMarketBuy(market: Constant.MARKET_DOGE_USD);
       buyPrice=_pB;
     // _priceTakeProfit=asksFinal[1].price;
      // _log.update('takeProfit', (value) => _priceTakeProfit);
      // _log.update('priceBuy', (value) => buyPrice);
      // _log.update('intervalAskBidBuy', (value) => getInterval(_pB, _pS));
      // _log.update('glassAskDischargedBuy', (value) => trandUp);
      // _log.update('levelUpBuy', (value) => levelUp);
      // _log.update('isUpBuy', (value) => isUp);
      // _log.update('timeStampBuy', (value) => DateTime.now().toString());
      // _log.update('stopLoss', (value) => _stopLoss);


      sellPrice=asksFinal[0].price;
     final sell=await _strategyLimitOrder.placeOrderBuy(market: Constant.MARKET_DOGE_USD, percentageOfBalance: 100, price:asksFinal[0].price);
      if(sell>0){
        _idOrder=sell;
        _isPlace=true;
        handlerOpenOrder();
      }else{
        print('order sell place error');
      }


  }

  handlerOpenOrder(){
   Timer.periodic(Duration(seconds: 2), (timer) async{
  final model=await RepositoryModule.apiRepository().getOpenOrders();
     if(model!.isEmpty){
       print('Close order');
       // _log.update('profit', (value) => takeProfit);
       // _log.update('priceSell', (value) => sellPrice);
       // _log.update('intervalAskBidSell', (value) => getInterval(_pB, _pS));
       // _log.update('glassAskDischargedSell', (value) =>trandUp );
       // _log.update('levelUpSell', (value) => levelUp);
       // _log.update('isUpSell', (value) => isUp);
       // _log.update('timeStampSell', (value) => DateTime.now().toString());
       // RepositoryModule.apiRepository().insertLogTrading(modelLogTrading:ModelLogTrading(
       //     takeProfit: _log['takeProfit'],
       //     stopLoss: _log['stopLoss'],
       //     priceBuy: _log['priceBuy'],
       //     priceSell: _log['priceSell'],
       //     intervalAskBidSell: _log['intervalAskBidSell'],
       //     intervalAskBidBuy: _log['intervalAskBidBuy'],
       //     glassAskDischargedBuy: _log['glassAskDischargedBuy'],
       //     glassAskDischargedSell: _log['glassAskDischargedSell'],
       //     levelUpBuy: _log['levelUpBuy'],
       //     levelUpSell: _log['levelUpSell'],
       //     isUpSell: _log['isUpSell'],
       //     isUpBuy: _log['isUpBuy'],
       //     timeStampBuy: _log['timeStampBuy'],
       //     timeStampSell: _log['timeStampSell'],
       //     profit: _log['profit']));
       sellPrice=0.0;
       buyPrice=0.0;
       _idOrder=0;
       _isPlace=false;
       isUp=0;
       levelUpAsk=0;
       levelUpBid=0;
       if(state==2){
         state=3;
       }else if(state==4){
         state=1;
       }
       timer.cancel();
     }
   });
  }




}