


 import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:payarapp/data/api/model/api_order.dart';

class OrderService{

   Future<ApiOrder> getOrder({@required String idUser}) async{
     CollectionReference order = FirebaseFirestore.instance.collection('orders');
     final result=await order.doc(idUser).get();
     return ApiOrder.fromApi(result);

   }

 }