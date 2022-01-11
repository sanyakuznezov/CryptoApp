

 import 'package:payarapp/data/api/socket_util.dart';
import 'package:payarapp/domain/model/trading/model_ticker_price.dart';
import 'package:payarapp/domain/repository/socket_repository.dart';

class SocketDataRepository extends SocketRepository{

  SocketUtil _socketUtil;
  SocketDataRepository(this._socketUtil);

  // @override
  // // TODO: implement getTicker
  // Stream<ModelTickerPrice> get getTicker => _socketUtil.getTicker;

  closeTicker(){
    _socketUtil.closeTicker();
  }




}