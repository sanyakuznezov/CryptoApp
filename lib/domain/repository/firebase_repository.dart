

import 'package:payarapp/data/api/model/modelorderplaceapi.dart';
import 'package:payarapp/domain/model/trading/model_all_balances.dart';

abstract class FirebaseRepository{

  Future<List<ModelAllBalances>> getBalance();
  Future<bool> placeOrder({required ModelOrderRequestPlaceApi modelOrderRequestPlaceApi});
  Future<void> getTrades({required String market});
  Future<void> getOpenOrders();
  Future<void> startWS();
  Future<void> stopWS();
  Future<void> addOrdersell();
  Future<void> addOrderbuy();
  Future<void> startTrending();
 }