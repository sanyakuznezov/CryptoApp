


import 'package:flutter/cupertino.dart';

class Order{

    final String? avatar;
     final String? nik;
     final String? prize;
     final String? id;
     final String? img;
     final String? status;
     final String? id_user;
     final String? date_game;



     Order({@required this.date_game,@required this.id_user,@required this.status,@required this.id,@required this.prize,@required this.img,@required this.avatar,@required this.nik});

     get getDateGame{
       return this.date_game;
     }
     get getAvatar{
      return this.avatar;
    }

    get getNik{
      return this.nik;
    }

    get getIdUser=>this.id_user;
    get getStatus=>this.status;
 get getPrize=>this.prize;
     get getId=>this.id;
     get getImg=>this.img;







}