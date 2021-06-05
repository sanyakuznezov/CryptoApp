


import 'package:cloud_firestore/cloud_firestore.dart';

class ApiOrder{

  final String avatar;
  final String nik;
  final String prize;
  final String id;
  final String img;
  final String status;
  final String id_user;
  final String date_game;

  ApiOrder.fromApi(DocumentSnapshot<Map<String,dynamic>> value):
       avatar = value['avatar'],
       prize=value['prize'],
       id=value.id,
       nik=value['nik'],
       img=value['img'],
       id_user=value['id_user'],
       status=value['status'],
       date_game=value['date_game'];






}




