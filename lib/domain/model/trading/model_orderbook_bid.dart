


import 'package:json_annotation/json_annotation.dart';


 class ModelOrderBookBid{

   int checksum;
   double bids;

   double time;


   ModelOrderBookBid({required this.time,required this.bids,required this.checksum});


   }