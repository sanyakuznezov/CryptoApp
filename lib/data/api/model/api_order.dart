


import 'package:cloud_firestore/cloud_firestore.dart';

class ApiOrder{

  final String avatar;
  final String nik;
  final bool notFond;

  ApiOrder.fromApi(DocumentSnapshot<Map<String,dynamic>> value):
      avatar = value['avatar'],
        notFond=value.exists,
      nik=value['nik'];


}




