

  import 'package:flutter/cupertino.dart';
import 'package:payarapp/data/mapper/order_mapper.dart';
import 'package:payarapp/data/api/service/order_service.dart';
import 'package:payarapp/domain/model/order.dart';
import 'package:payarapp/domain/model/tickets.dart';

class ApiUtil{

    OrderService _orderService;

    ApiUtil(this._orderService);

    Future<Order> getOrder({@required String? idUser}) async{
      final result = await _orderService.getOrder(idUser: idUser!);
      return OrderMapper.fromApi(result);
    }

    Future <List<Tickets>> getTickets({@required String? idUser}) async{
         final result=await _orderService.getTickets(idUser: idUser!);
         return  OrderMapper.fromApiTickets(result);
    }



}