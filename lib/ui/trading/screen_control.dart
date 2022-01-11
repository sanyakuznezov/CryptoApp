



import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:payarapp/data/api/model/model_ticker_price_api.dart';
import 'package:payarapp/data/api/service/socket/websocketclient.dart';
import 'package:payarapp/domain/model/trading/model_ticker_price.dart';
import 'package:payarapp/internal/dependencies/repository_module.dart';

class  ScreenControl extends StatefulWidget{
  @override
  State<ScreenControl> createState() => _ScreenControlState();
}

class _ScreenControlState extends State<ScreenControl> {


  late WebSocketClient _webSocketClient;

  @override
  void dispose() {
    super.dispose();
    //RepositoryModule.socketRepository().closeTicker();
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _webSocketClient=WebSocketClient();
  }


  @override
  Widget build(BuildContext context) {
      return Scaffold(
        body: Container(
          child: Center(
            child:
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                StreamBuilder<dynamic>(
                  stream: _webSocketClient.getTicker,
                    builder:(context,ticker){
                  if (ticker.connectionState == ConnectionState.waiting) {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  }
                  if (ticker.connectionState == ConnectionState.active && ticker.hasData) {

                    print('Data ${ticker.data}');
                    return Column(
                      children: [
                        Text(
                          'ASk - ',
                          style: TextStyle(
                            color: Colors.red,
                            fontSize: 14.0,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          'Bid - ',
                          style: TextStyle(
                            color: Colors.green,
                            fontSize: 14.0,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    );
                  }
                  if (ticker.connectionState == ConnectionState.done) {
                    return const Center(
                      child: Text(
                        'No more data',
                        style: TextStyle(
                          color: Colors.red,
                        ),
                      ),
                    );
                  }
                    return const Center(
                      child: Text('No data'),
                    );
                }),

                  ElevatedButton(onPressed: (){
                    _webSocketClient.closeTicker();
                  }, child: Text('close')
        )

              ],
            ),
          ),
        ),
      );
  }
}