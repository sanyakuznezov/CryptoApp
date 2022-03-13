

import 'package:payarapp/data/api/model/modelorderplaceapi.dart';
import 'package:payarapp/domain/model/trading/model_all_balances.dart';
import 'package:payarapp/domain/model/trading/model_log_trading.dart';
import 'package:payarapp/domain/model/trading/model_open_order.dart';

abstract class ApiRepository{

  Future<List<ModelAllBalances>> getBalance();
  Future<int> placeOrder({required ModelOrderRequestPlaceApi modelOrderRequestPlaceApi});
  Future<void> getTrades({required String market});
  Future<List<ModelOpenOrder>?> getOpenOrders();
  Future<void> startWS();
  Future<void> stopWS();
  Future<void> addOrdersell();
  Future<void> addOrderbuy();
  Future<void> startTrending();
  Future<void> insertLogTrading({required ModelLogTrading modelLogTrading});
  Future<List<ModelLogTrading>?> getListTrading();
  Future<void> cleanListLog();
  Future<bool> cancelOrder({required String id});
 }