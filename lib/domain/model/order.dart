


import 'package:flutter/cupertino.dart';

class Order{

    final String avatar;
     final String nik;
     final bool notFond;


     Order({@required this.notFond,@required this.avatar,@required this.nik});


     get getAvatar{
      return this.avatar;
    }

    get getNik{
      return this.nik;
    }

    get isNotFound{
       return this.notFond;
    }




}