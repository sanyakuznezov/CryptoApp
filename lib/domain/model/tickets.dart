


  import 'package:flutter/cupertino.dart';

class Tickets{

    final String? combi;
    final String? id;

    Tickets({@required this.combi,@required this.id});

    String get getStatus => id!;

  String get getCombi => combi!;
}