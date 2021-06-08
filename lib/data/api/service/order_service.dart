


 import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cloud_functions/cloud_functions.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:payarapp/data/api/model/api_order.dart';
import 'package:payarapp/domain/model/order.dart';
import 'package:payarapp/domain/model/tickets.dart';


class OrderService{

  final CollectionReference order = FirebaseFirestore.instance.collection('orders');
  final CollectionReference receipt=FirebaseFirestore.instance.collection('receipt');


  Future<ApiOrder> getOrder({@required String? idUser}) async{
     final dynamic result=await order.doc(idUser).get();
     return ApiOrder.fromApi(result);
   }


  Future <QuerySnapshot> getTickets({@required String? idUser})async {
   final result= await order.doc(idUser).collection('tickets').get();
   return result;
  }


  Future<void> addOrder({@required String? id_puschase,@required String? price, @required Order? order}) async{
    HttpsCallable callable = FirebaseFunctions.instance.httpsCallable('addPurchase');
     await callable.call(
      <String,dynamic>{
          'prize':order!.getPrize,
         'id_order':order.getId,
        'id_puschase':id_puschase!,
        'ava_user':order.getAvatar,
        'id_user':order.getIdUser,
        'nik_user':order.getNik,
        'payment':order.getPrize
      },
    );
  }



  


 }