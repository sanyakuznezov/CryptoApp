



import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:payarapp/data/api/model/model_ticker_price_api.dart';
import 'package:payarapp/data/api/service/socket/websocketclient.dart';
import 'package:payarapp/data/mapper/mapper_trading_data.dart';
import 'package:payarapp/domain/model/trading/model_ticker_price.dart';
import 'package:payarapp/domain/state/state_list_ticker.dart';
import 'package:payarapp/internal/dependencies/repository_module.dart';

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
  }


  @override
  Widget build(BuildContext context) {
      return Scaffold(
        backgroundColor: Colors.blueGrey[800],
        appBar: AppBar(
          backgroundColor: Colors.blueGrey[900],
          actions: [
            Observer(builder: (_){
              if(!_stateListTicker!.hasData){
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
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Icon(Icons.arrow_circle_down_rounded,color:Colors.red,size: 15,),
                        ),
                        Text('USD: 7.98',
                          style:
                          TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 13,
                            color: Colors.white,
                          ),),
                      ],
                    ),
                    Row(
                      children: [
                        Text('47.05 DOGE',
                          style:
                          TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 13,
                            color: Colors.white,
                          ),),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Icon(Icons.arrow_circle_up_sharp,color:Colors.green,size: 15,),
                        ),
                      ],
                    ),
                  ],
                ),
                ElevatedButton(onPressed: (){
                  RepositoryModule.firebaseRepository().getBalance();
                }, child: Text('res'))
              ],
            ),
          ),
        )

      );
  }
}