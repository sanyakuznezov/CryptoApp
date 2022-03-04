

 import 'package:floor/floor.dart';

@entity
 class ModelLogTrading{
   @primaryKey
   int? id;
   String timeStampBuy;
   String timeStampSell;
   double profit;
   double stopLoss;
   double priceBuy;
   double priceSell;
   double intervalAskBidBuy;
   double intervalAskBidSell;
   bool glassAskDischargedBuy;
   bool glassAskDischargedSell;
   int levelUpBuy;
   int levelUpSell;
   int isUpBuy;
   int isUpSell;

   ModelLogTrading({required this.stopLoss,required this.priceBuy,required this.priceSell,required this.intervalAskBidSell,required this.intervalAskBidBuy,required this.glassAskDischargedBuy,
     required this.glassAskDischargedSell,required this.levelUpBuy,
     required this.levelUpSell, required this.isUpSell,required this.isUpBuy,
     required this.timeStampBuy,required this.timeStampSell,
     required this.profit});


 }