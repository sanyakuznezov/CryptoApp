



import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:payarapp/domain/state/state_screen_control.dart';
import 'package:payarapp/ui/screen_control_trade/widgets/items_log_trading.dart';


class  PageControl extends StatefulWidget{
  @override
  State<PageControl> createState() => _PageControlState();
}

class _PageControlState extends State<PageControl> {

  StateListTicker? _stateListTicker;
  bool _isTrade=false;


  @override
  void dispose() {
    super.dispose();
   _stateListTicker!.close();
  }

  @override
  void initState() {
    super.initState();
    _stateListTicker=StateListTicker();
    _stateListTicker!.getTicker();
    //_stateListTicker!.getOrderBook();
    //_stateListTicker!.getTrade();
    _stateListTicker!.getAllBalances();
  }


  @override
  Widget build(BuildContext context) {
      return Scaffold(
        floatingActionButton: FloatingActionButton(
          backgroundColor: Colors.orange,
          child: Icon(Icons.update,color: Colors.white,),
          onPressed: () {
            if(!_isTrade){
              _stateListTicker!.startTrading();
              _isTrade=true;
              ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Trade Start')));
            }else{
              _stateListTicker!.stopTrading();
              _isTrade=false;
              ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Trade Stop')));
            }


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
        body: Container(
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
                        return PageListLogTrading(listmodelLogTrading: _stateListTicker!.listLogTrading);
                      }
                      return PageListLogTrading(listmodelLogTrading: _stateListTicker!.listLogTrading);

                    },
                  )
                ],
              )


            ],
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