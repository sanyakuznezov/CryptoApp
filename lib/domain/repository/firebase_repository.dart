

import 'package:payarapp/domain/model/trading/model_ticker_price.dart';

abstract class FirebaseRepository{

  Future<List<ModelTickerPrice>> getListTickerPrice();
  Future<void> startWS();
  Future<void> stopWS();
  Future<void> addOrdersell();
  Future<void> addOrderbuy();
  Future<void> startTrending();
 }