



 import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:payarapp/domain/model/trading/model_log_trading.dart';

class ItemLog extends StatelessWidget{

 final ModelLogTrading modelLogTrading;

  ItemLog({required this.modelLogTrading});


  @override
  Widget build(BuildContext context) {
   return Container(
     margin: EdgeInsets.all(5),
     padding: EdgeInsets.all(5),
     decoration: BoxDecoration(
       color: Colors.grey,
       borderRadius: BorderRadius.all(Radius.circular(15))
     ),
     child: Column(
        children: [
          Text('Buy',style: TextStyle(fontWeight: FontWeight.bold,fontSize: 15)),
          Row(
            children: [
              Text('priceBuy: '),
              Text('${modelLogTrading.priceBuy}')
            ],

          ),
          Row(
            children: [
              Text('priceBuy: '),
              Text('${modelLogTrading.priceBuy}')
            ],

          ),
          Row(
            children: [
              Text('stopLoss: '),
              Text('${modelLogTrading.stopLoss}')
            ],

          ),
          Row(
            children: [
              Text('intervalAskBidBuy: '),
              Text('${modelLogTrading.intervalAskBidBuy}')
            ],

          ),
          Row(
            children: [
              Text('glassAskDischargedBuy: '),
              Text('${modelLogTrading.glassAskDischargedBuy}')
            ],

          ),
          Row(
            children: [
              Text('levelUpBuy: '),
              Text('${modelLogTrading.levelUpBuy}')
            ],

          ),
          Row(
            children: [
              Text('isUpBuy: '),
              Text('${modelLogTrading.isUpBuy}')
            ],

          ),
          Row(
            children: [
              Text('timeStampBuy: '),
              Text('${modelLogTrading.timeStampBuy}')
            ],

          ),
          SizedBox(
            height: 10,
          ),
          Text('Sell',style: TextStyle(fontWeight: FontWeight.bold,fontSize: 15)),
          Row(
            children: [
              Text('priceSell: '),
              Text('${modelLogTrading.priceSell}')
            ],

          ),
          Row(
            children: [
              Text('intervalAskBidSell: '),
              Text('${modelLogTrading.intervalAskBidSell}')
            ],

          ),
          Row(
            children: [
              Text('glassAskDischargedSell: '),
              Text('${modelLogTrading.glassAskDischargedSell}')
            ],

          ),
          Row(
            children: [
              Text('levelUpSell: '),
              Text('${modelLogTrading.levelUpSell}')
            ],

          ),
          Row(
            children: [
              Text('isUpSell: '),
              Text('${modelLogTrading.isUpSell}')
            ],

          ),
          Row(
            children: [
              Text('timeStampSell: '),
              Text('${modelLogTrading.timeStampSell}')
            ],

          ),
          SizedBox(
            height: 15,
          ),
          Row(
            children: [
              Text('profit: '),
              Text('${modelLogTrading.profit}')
            ],

          ),
        ],
     ),
   );
  }



}