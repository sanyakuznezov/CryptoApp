


import 'package:cloud_firestore/cloud_firestore.dart';

class ApiOrder{

  final String avatar;
  final String nik;

  ApiOrder.fromApi(DocumentSnapshot<Map<String,dynamic>> value):
      avatar = value['avatar'],
      nik=value['nik'];

}

