


import 'package:flutter/cupertino.dart';

class Order{

    final String avatar;
     final String nik;

     Order({@required this.avatar,@required this.nik});


     get getAvatar{
      return this.avatar;
    }

    get getNik{
      return this.nik;
    }
}