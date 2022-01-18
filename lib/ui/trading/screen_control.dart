



import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:payarapp/data/api/model/model_ticker_price_api.dart';
import 'package:payarapp/data/api/service/socket/websocketclient.dart';
import 'package:payarapp/data/mapper/mapper_trading_data.dart';
import 'package:payarapp/domain/model/trading/model_log_trading.dart';
import 'package:payarapp/domain/model/trading/model_ticker_price.dart';
import 'package:payarapp/domain/state/state_screen_control.dart';
import 'package:payarapp/internal/dependencies/repository_module.dart';
import 'package:payarapp/ui/trading/list_log_trading.dart';

class  ScreenControl extends StatefulWidget{
  @override
  State<ScreenControl> createState() => _ScreenControlState();
}

class _ScreenControlState extends State<ScreenControl> {

  StateListTicker? _stateListTicker;


  @override
  void dispose() {
    super.dispose();
   _stateListTicker!.close();
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _stateListTicker=StateListTicker();
    _stateListTicker!.getTicker();
    _stateListTicker!.getOrders();
    _stateListTicker!.getAllBalances();
  }


  @override
  Widget build(BuildContext context) {
      return Scaffold(
        floatingActionButton: FloatingActionButton(
          backgroundColor: Colors.orange,
          child: Icon(Icons.update,color: Colors.white,),
          onPressed: () {
            _stateListTicker!.startTrading();

        },
        ),
        backgroundColor: Colors.blueGrey[800],
        appBar: AppBar(
          backgroundColor: Colors.blueGrey[900],
          actions: [
            Observer(builder: (_){
              if(!_stateListTicker!.hasDataTicker){
                return Expanded(
                  child: Center(
                      child: SizedBox(
                    height: 30,
                      width: 30,
                      child: CircularProgressIndicator(color: Colors.blueGrey[800],))),
                );
              }
              return Expanded(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text('ASK',
                              style: TextStyle(
                                  color: Colors.red,
                                  fontWeight: FontWeight.bold
                              )),

                        ),
                        //ask
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text('${_stateListTicker!.ticker!.ask}',
                          style: TextStyle(
                            color: Colors.red,
                            fontWeight: FontWeight.bold
                          ),),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Container(
                            width: 2,
                            color: Colors.red,
                          ),
                        ),
                      ],
                    ),
                    Text('DOGE/USD',
                      style:
                      TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 11,
                        color: Colors.white,
                      ),),
                    Row(
                      children: [
                        //bid
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Container(
                            width: 2,
                            color: Colors.green,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text('${_stateListTicker!.ticker!.bid}',
                            style: TextStyle(
                                color: Colors.green,
                                fontWeight: FontWeight.bold
                            )),

                        ),

                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text('BID',
                              style: TextStyle(
                                  color: Colors.green,
                                  fontWeight: FontWeight.bold
                              )),

                        ),
                      ],
                    ),
                  ],
                ),
              );
            }),
          ],
        ),
        body: SingleChildScrollView(
          child: Container(
            child: Column(
              children: [
                Container(
                  child: Observer(
                    builder: (_) {
                      if(_stateListTicker!.hasDataBalances){
                        return Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            children: List.generate(_stateListTicker!.listBalances!.length, (index){
                              return _ItemBalances(usdValue:_stateListTicker!.listBalances![index].usdValue,coin: _stateListTicker!.listBalances![index].coin, free: _stateListTicker!.listBalances![index].total);
                            }),
                          ),
                        );
                      }
                      return SizedBox(
                          height: 30,
                          width: 30,
                          child: CircularProgressIndicator(color: Colors.blueGrey[800],));

                    }
                  ),
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [

                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text('Log trading',
                        textAlign: TextAlign.left,
                        style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 20
                        ),),
                    ),

                    Observer(
                      builder: (context) {
                       if(_stateListTicker!.listLogTrading.isNotEmpty){
                         return ListLogTrading(modelLogTrading: _stateListTicker!.listLogTrading);
                       }else{
                         return Center(child: Icon(Icons.do_not_disturb_alt,color:Colors.grey,size: 60,));

                       }

                      },
                    )
                  ],
                )


              ],
            ),
          ),
        )

      );
  }
}

   class _ItemBalances extends StatelessWidget{

   String coin;
   double free;
   double usdValue;
    _ItemBalances({required this.coin, required this.free,required this.usdValue});

  @override
  Widget build(BuildContext context) {
   return  Column(
     children: [
       Row(
         mainAxisAlignment: MainAxisAlignment.spaceBetween,
         children: [
           Text('$coin: $free',
             style:
             TextStyle(
               fontWeight: FontWeight.bold,
               fontSize: 11,
               color: Colors.white,
             ),),
           Row(
             children: [
               Text('$usdValue USD',
                 style:
                 TextStyle(
                   fontWeight: FontWeight.normal,
                   fontSize: 12,
                   color: Colors.orange,
                 ),),
               Padding(
                 padding: const EdgeInsets.all(5.0),
                 child: Icon(Icons.arrow_circle_down_rounded,color:Colors.red,size: 15,),
               ),
             ],
           ),

         ],
       ),
       Divider(color: Colors.grey[600],)
     ],
   );
  }


   }