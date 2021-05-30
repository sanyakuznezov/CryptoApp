


 import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:payarapp/data/api/model/api_order.dart';


class OrderService{

  final CollectionReference order = FirebaseFirestore.instance.collection('orders');


  Future<ApiOrder> getOrder({@required String? idUser}) async{
     final dynamic result=await order.doc(idUser).get();
     return ApiOrder.fromApi(result);
   }


  Future <QuerySnapshot> getTickets({@required String? idUser})async {
   final result= await order.doc(idUser).collection('tickets').get();
   return result;
  }


 }