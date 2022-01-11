

  import 'package:payarapp/data/api/api_util.dart';
import 'package:payarapp/data/api/service/rest/main_trading_service.dart';
import 'package:payarapp/data/api/service/socket/websocketclient.dart';
import 'package:payarapp/data/api/socket_util.dart';

class ApiModule{
      static ApiUtil? _apiUtil;
      static SocketUtil? _socketUtil;

      static ApiUtil apiUtil(){
        if(_apiUtil==null){
          _apiUtil=ApiUtil(MainTradingService());
      }
        return _apiUtil!;
       }


       static SocketUtil socketUtil(){
         if(_socketUtil==null){
            _socketUtil=SocketUtil(WebSocketClient());
         }
         return _socketUtil!;
       }

  }