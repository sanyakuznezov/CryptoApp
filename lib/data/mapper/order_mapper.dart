



 import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:payarapp/data/api/model/api_order.dart';
import 'package:payarapp/domain/model/order.dart';
import 'package:payarapp/domain/model/tickets.dart';

class OrderMapper{

  static Order fromApi(ApiOrder apiOrder){
     return Order(date_game:apiOrder.date_game,id_user:apiOrder.id_user,status:apiOrder.status,id:apiOrder.id,prize:apiOrder.prize,img:apiOrder.img,avatar: apiOrder.avatar, nik: apiOrder.nik);
   }


   static List<Tickets> fromApiTickets(QuerySnapshot querySnapshot){
         List<Tickets> d=[];
        querySnapshot.docs.forEach((element) {
             d.add(Tickets(combi: element['combi'], id:element.id));
        });

        return d;
  }

 }


