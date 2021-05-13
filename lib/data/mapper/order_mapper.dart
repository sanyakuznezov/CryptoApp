



 import 'package:payarapp/data/api/model/api_order.dart';
import 'package:payarapp/domain/model/order.dart';

class OrderMapper{

  static Order fromApi(ApiOrder apiOrder){
     return Order(avatar: apiOrder.avatar, nik: apiOrder.nik);
   }

 }