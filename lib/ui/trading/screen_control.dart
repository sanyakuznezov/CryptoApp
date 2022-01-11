



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
        appBar: AppBar(
          backgroundColor: Colors.black,
        ),
        body: Container(
          child: Column(
            children: [
              Observer(builder: (_){
                if(!_stateListTicker!.hasData){
                  return CircularProgressIndicator();
                }
                return Column(
                  children: [
                    Text('Ask: ${_stateListTicker!.ticker!.ask}'),
                    Text('Bid: ${_stateListTicker!.ticker!.bid}'),
                  ],
                );
              }),
              ElevatedButton(onPressed: (){
                _stateListTicker!.close();
              }, child: Text('close')
              )
            ],
          ),
        ),
      );
  }
}