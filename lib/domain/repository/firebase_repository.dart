

 import 'package:flutter/cupertino.dart';
import 'package:payarapp/domain/model/order.dart';

abstract class FirebaseRepository{

   Future<Order> getOrder({@required String idUser});


 }