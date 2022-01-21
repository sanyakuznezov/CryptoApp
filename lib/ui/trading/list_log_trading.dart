





  import 'package:flutter/material.dart';
import 'package:payarapp/domain/model/trading/model_log_trading.dart';

class ListLogTrading extends StatefulWidget{

  List<ModelLogTrading> listmodelLogTrading;

  ListLogTrading({required this.listmodelLogTrading});


  @override
  State<ListLogTrading> createState() => _ListLogTradingState();
}

class _ListLogTradingState extends State<ListLogTrading> {


  @override
  Widget build(BuildContext context) {
      return Container(
        child: ViewDataStatistics(widget.listmodelLogTrading)
      );
  }
}



  class ViewDataStatistics extends StatelessWidget{

   final List<ModelLogTrading> _list;
   ViewDataStatistics(this._list);

  @override
  Widget build(BuildContext context) {
     return Wrap(
       crossAxisAlignment: WrapCrossAlignment.center,
       children: [
             Container(
               margin:const EdgeInsets.all(5.0),
               height: 100,
               width: 100,
               decoration: BoxDecoration(
                 borderRadius: BorderRadius.circular(10.0),
                 color: Colors.blueGrey[500]
               ),
               child: Padding(
                 padding: const EdgeInsets.all(8.0),
                 child: Column(
                   mainAxisAlignment: MainAxisAlignment.center,
                   children: [
                     Icon(Icons.psychology_outlined,color:Colors.blueGrey[800],size: 30,),
                     Padding(
                       padding: const EdgeInsets.all(3.0),
                       child: Text('ALL LOG',style: TextStyle(
                           color:  Colors.blueGrey[900],
                           fontSize: 13,

                       ),),
                     ),
                     Text('${getAllLog(_list)}',style: TextStyle(
                       color: Colors.blueGrey[900],
                       fontSize: 11,
                       fontWeight: FontWeight.bold
                     ),)
                   ],
                 ),
               ),
             ),
         Container(
           margin:const EdgeInsets.all(5.0),
           height: 100,
           width: 100,
           decoration: BoxDecoration(
               borderRadius: BorderRadius.circular(10.0),
               color: Colors.blueGrey[500]
           ),
           child: Padding(
             padding: const EdgeInsets.all(8.0),
             child: Column(
               mainAxisAlignment: MainAxisAlignment.center,
               children: [
                 Icon(Icons.local_grocery_store,color: Colors.blueGrey[800],size: 30,),
                 Padding(
                   padding: const EdgeInsets.all(3.0),
                   child: Text('BUY/SEll',style: TextStyle(
                       color:  Colors.blueGrey[900],
                       fontSize: 13
                   ),),
                 ),
               Row(
                 mainAxisAlignment: MainAxisAlignment.center,
                 children: [
                   Text('${getBuyAndSellProfitDown(_list)}',style: TextStyle(
                       color:  Colors.blueGrey[900],
                       fontSize: 11,
                       fontWeight: FontWeight.bold
                   ),),
                   Padding(
                     padding: const EdgeInsets.fromLTRB(3.0,0,0,0),
                     child: Icon(Icons.arrow_circle_down_rounded,color:Colors.red,size: 11,),
                   )
                 ],
               ),
                 Row(
                   mainAxisAlignment: MainAxisAlignment.center,
                   children: [
                     Text('${getBuyAndSellProfitUp(_list)}',style: TextStyle(
                         color:  Colors.blueGrey[900],
                         fontSize: 11,
                         fontWeight: FontWeight.bold
                     ),),
                     Padding(
                       padding: const EdgeInsets.fromLTRB(3.0,0,0,0),
                       child: Icon(Icons.arrow_circle_up_rounded,color:Colors.green,size: 11,),
                     )
                   ],
                 )


               ],
             ),
           ),
         ),
         Container(
           margin:const EdgeInsets.all(5.0),
           height: 100,
           width: 100,
           decoration: BoxDecoration(
               borderRadius: BorderRadius.circular(10.0),
               color: Colors.blueGrey[500]
           ),
           child: Padding(
             padding: const EdgeInsets.all(8.0),
             child: Column(
               mainAxisAlignment: MainAxisAlignment.center,
               children: [
                 Icon(Icons.arrow_circle_up_sharp,color: Colors.blueGrey[800],size: 30,),
                 Padding(
                   padding: const EdgeInsets.all(3.0),
                   child: Text('PROFIT',style: TextStyle(
                       color:  Colors.blueGrey[900],
                       fontSize: 13
                   ),),
                 ),
                 Text('${getProfit(_list)}',style: TextStyle(
                     color: Colors.blueGrey[900],
                     fontSize: 11,
                     fontWeight: FontWeight.bold
                 ),)
               ],
             ),
           ),
         )
       ],
     );
  }
   getAllLog(List<ModelLogTrading> list){

      return list.length;
  }

  getBuyAndSellProfitUp(List<ModelLogTrading> list){
    int c=0;
    list.forEach((element) {
      if(element.nameLog=='Sell End'){
        c++;
      }
    });
    return c;
  }

   getBuyAndSellProfitDown(List<ModelLogTrading> list){
     int c=0;
     list.forEach((element) {
       if(element.nameLog=='Sell End Trend Fell'){
         c++;
       }
     });
     return c;
   }

   getProfit(List<ModelLogTrading> list){
    double result=0.0;
    list.forEach((element){
       result+=element.profit;
    });
    return result;

   }


  }




 class _ItemList extends StatelessWidget{

  ModelLogTrading modelLogTrading;

   _ItemList({required this.modelLogTrading});


  @override
  Widget build(BuildContext context) {
        return Container(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
                children: [
                  Row(
                    children: [
                      Text('Status: ',
                      style: TextStyle(
                        color: Colors.grey,
                      ),),
                      Text('${modelLogTrading.status}',
                        style: TextStyle(
                            color: Colors.grey
                        ),)
                    ],
                  ),
                  Row(
                    children: [
                      Text('Mapket: ',
                        style: TextStyle(
                            color: Colors.grey
                        ),),
                      Text('${modelLogTrading.market}',
                        style: TextStyle(
                            color: Colors.grey
                        ),)
                    ],
                  ),
                  Row(
                    children: [
                      Text('Time: ',
                        style: TextStyle(
                            color: Colors.grey
                        ),),
                      Text('${modelLogTrading.timeStamp}',
                        style: TextStyle(
                            color: Colors.grey
                        ),)
                    ],
                  ),
                  Row(
                    children: [
                      Text('Profit: ',
                        style: TextStyle(
                            color: Colors.grey
                        ),),
                      Text('${modelLogTrading.profit}',
                        style: TextStyle(
                            color: Colors.grey
                        ),)
                    ],
                  ),
                  Row(
                    children: [
                      Text('Size: ',
                        style: TextStyle(
                            color: Colors.grey
                        ),),
                      Text('${modelLogTrading.size}',
                        style: TextStyle(
                            color: Colors.grey
                        ),)
                    ],
                  ),
                  Row(
                    children: [
                      Text('Price: ',
                        style: TextStyle(
                            color: Colors.grey
                        ),),
                      Text('${modelLogTrading.price}',
                        style: TextStyle(
                            color: Colors.grey
                        ),)
                    ],
                  ),
                  Row(
                    children: [
                      Text('Op: ',
                        style: TextStyle(
                            color: Colors.grey
                        ),),
                      Text('${modelLogTrading.nameLog}',
                        style: TextStyle(
                            color: Colors.grey
                        ),)
                    ],
                  ),
                  Divider(color: Colors.grey[600],)
                ],
            ),
          ),
        );
  }


 }



