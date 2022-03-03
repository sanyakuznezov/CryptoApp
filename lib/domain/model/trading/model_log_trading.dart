

 import 'package:floor/floor.dart';

@entity
 class ModelLogTrading{
   @primaryKey
   int? id;
   String timeStamp;
   double profit;
   double priceBuy;
   double priceSell;
   double intervalAskBid;
   bool glassAskDischarged;
   double levelUp;
   bool isUp;

   ModelLogTrading({required this.priceBuy,required this.priceSell,required this.intervalAskBid,required this.glassAskDischarged,required this.levelUp,
     required this.isUp,required this.timeStamp,required this.profit});


 }