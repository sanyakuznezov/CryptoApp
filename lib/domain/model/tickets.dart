


  import 'package:flutter/cupertino.dart';

class Tickets{

    final String? combi;
    final String? status;

    Tickets({@required this.combi,@required this.status});

    String get getStatus => status!;

  String get getCombi => combi!;
}