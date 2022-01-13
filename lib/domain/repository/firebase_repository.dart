

import 'package:payarapp/domain/model/trading/model_all_balances.dart';

abstract class FirebaseRepository{

  Future<List<ModelAllBalances>> getBalance();
  Future<void> startWS();
  Future<void> stopWS();
  Future<void> addOrdersell();
  Future<void> addOrderbuy();
  Future<void> startTrending();
 }