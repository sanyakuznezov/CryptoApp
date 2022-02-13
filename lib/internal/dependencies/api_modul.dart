

  import 'package:payarapp/data/api/api_util.dart';
import 'package:payarapp/data/api/service/rest/main_trading_service.dart';
import 'package:payarapp/data/api/service/socket/websocketclient.dart';


class ApiModule{
      static ApiUtil? _apiUtil;
      static WebSocketClient? _webSocketClient;


      static ApiUtil apiUtil(){
        if(_apiUtil==null){
          _apiUtil=ApiUtil(MainTradingService());
      }
        return _apiUtil!;
       }




  }