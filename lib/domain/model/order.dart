


import 'package:flutter/cupertino.dart';

class Order{

    final String? avatar;
     final String? nik;
     final String? prize;
     final String? id;
     final String? img;


     Order({@required this.id,@required this.prize,@required this.img,@required this.avatar,@required this.nik});


     get getAvatar{
      return this.avatar;
    }

    get getNik{
      return this.nik;
    }
 get getPrize=>this.prize;
     get getId=>this.id;
     get getImg=>this.img;







}