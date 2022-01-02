

  import 'package:payarapp/data/api/api_util.dart';
import 'package:payarapp/data/api/service/main_trading_service.dart';
import 'package:payarapp/data/api/service/order_service.dart';

class ApiModule{
      static ApiUtil? _apiUtil;
      static ApiUtil apiUtil(){

        if(_apiUtil==null){
          _apiUtil=ApiUtil(MainTradingService());
      }
        return _apiUtil!;
}

  }