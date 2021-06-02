

 import 'package:flutter/cupertino.dart';
import 'package:payarapp/domain/model/order.dart';
import 'package:payarapp/domain/model/tickets.dart';

abstract class FirebaseRepository{

   Future<Order> getOrder({@required String idUser});
    Future<List<Tickets>> getTickets({@required String idUser});
    Future<void> addOrders({@required String id_puschase,@required String price, @required Order order,@required List<Tickets> tickets});

 }