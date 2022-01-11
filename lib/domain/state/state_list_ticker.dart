






import 'package:mobx/mobx.dart';
import 'package:payarapp/data/api/service/socket/websocketclient.dart';
import 'package:payarapp/domain/model/trading/model_ticker_price.dart';
part 'state_list_ticker.g.dart';
class StateListTicker=StateListTickerBase with _$StateListTicker;
abstract class StateListTickerBase with Store{

    @observable
    bool hasData=false;
    @observable
    bool isError=false;
    @observable
    ModelTickerPrice? ticker;
    WebSocketClient? webSocketClient=WebSocketClient();


    @action
    getTicker(){
      hasData=false;
      webSocketClient!.subscribe(channel: 'ticker',update: (ModelTickerPrice data){
        ticker=data;
        hasData=true;
      });

   }

   @action
    close(){
      webSocketClient!.close();
   }

}