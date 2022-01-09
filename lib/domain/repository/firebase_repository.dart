

 import 'package:flutter/cupertino.dart';
import 'package:payarapp/domain/model/order.dart';
import 'package:payarapp/domain/model/tickets.dart';
import 'package:payarapp/domain/model/trading/model_ticker_price.dart';

abstract class FirebaseRepository{

   // Future<Order> getOrder({@required String idUser});
   //  Future<List<Tickets>> getTickets({@required String idUser});
   //  Future<void> addOrders({@required String id_puschase,@required String price, @required Order order});
  Future<List<ModelTickerPrice>> getListTickerPrice();
  Future<void> startWS();
  Future<void> stopWS();
  Future<void> addOrdersell();
  Future<void> addOrderbuy();
  Future<void> startTrending();
 }