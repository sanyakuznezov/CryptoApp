






import 'package:mobx/mobx.dart';
import 'package:payarapp/constant.dart';
import 'package:payarapp/data/api/service/socket/websocketclient.dart';
import 'package:payarapp/domain/model/trading/model_all_balances.dart';
import 'package:payarapp/domain/model/trading/model_ticker_price.dart';
import 'package:payarapp/internal/dependencies/repository_module.dart';
part 'state_list_ticker.g.dart';
class StateListTicker=StateListTickerBase with _$StateListTicker;
abstract class StateListTickerBase with Store{

    @observable
    bool hasDataTicker=false;
    @observable
    bool hasDataBalances=false;
    @observable
     List<ModelAllBalances>? listBalances;
    @observable
    bool isError=false;
    @observable
    ModelTickerPrice? ticker;
    WebSocketClient? webSocketClient=WebSocketClient();


    @action
    getTicker(){
      hasDataTicker=false;
      webSocketClient!.subscribeTicker(channel: Constant.CHANNEL_TICKER,update: (ModelTickerPrice data){
        ticker=data;
        hasDataTicker=true;
      });


   }

   @action
   getOrders(){
      // webSocketClient!.subscribeOrders(channel: Constant.CHANNEL_ORDERS, update:(data){
      //   print('Orders $data');
      // });
     RepositoryModule.firebaseRepository().getOrders();
   }

    @action
    Future<void> getAllBalances() async{
       hasDataBalances=false;
       final result=await RepositoryModule.firebaseRepository().getBalance().catchError((error){
         //error hendler
       });
       hasDataBalances=true;
        listBalances=result;

    }

   @action
    close(){
      webSocketClient!.close();
   }

}