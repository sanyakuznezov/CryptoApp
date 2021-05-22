


import 'package:cloud_firestore/cloud_firestore.dart';

class ApiOrder{

  final String avatar;
  final String nik;
  final String prize;
  final String id;

  ApiOrder.fromApi(DocumentSnapshot<Map<String,dynamic>> value):
      avatar = value['avatar'],
      prize=value['prize'],
      id=value.id,
      nik=value['nik'];


}




