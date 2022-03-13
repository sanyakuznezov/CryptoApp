

  import 'package:payarapp/data/api/api_util.dart';
import 'package:payarapp/data/api/model/modelorderplaceapi.dart';
import 'package:payarapp/data/local_data_base/app_data_base.dart';
import 'package:payarapp/domain/model/trading/model_all_balances.dart';
import 'package:payarapp/domain/model/trading/model_log_trading.dart';
import 'package:payarapp/domain/model/trading/model_open_order.dart';
import 'package:payarapp/domain/repository/api_repository.dart';

class ApiDataRepository extends ApiRepository{

   ApiUtil _apiUtil;

   ApiDataRepository(this._apiUtil);

  @override
  Future<List<ModelAllBalances>> getBalance(){
      return _apiUtil.getBalance();
  }

  @override
  Future<void> startWS() async {
    await _apiUtil.startWS();
  }

  @override
  Future<void> stopWS() async{
    await _apiUtil.stopWS();
  }

  @override
  Future<void> addOrdersell() async{
    await _apiUtil.addOrdersell();
  }

  @override
  Future<void> addOrderbuy() async{
    await _apiUtil.addOrderbuy();
  }

   Future<void> startTrending() async{
    await _apiUtil.startTrending();
   }

  @override
  Future<List<ModelOpenOrder>?> getOpenOrders() async{
    // TODO: implement getOrders
   return await _apiUtil.getOpenOrders();
  }

  @override
  Future<int> placeOrder({required ModelOrderRequestPlaceApi modelOrderRequestPlaceApi}) async{
    return await _apiUtil.placeOrder(modelOrderRequestPlaceApi: modelOrderRequestPlaceApi);
  }

  @override
  Future<void> getTrades({required String market}) {
    return _apiUtil.getTrades(market:market);
  }

  @override
  Future<void> insertLogTrading({required ModelLogTrading modelLogTrading}) async{
    print('Dtat model ${modelLogTrading.stopLoss}');
    final database = await $FloorAppDataBase.databaseBuilder('app_database.db').build();
    final logDao = database.logtradingDao;
    await logDao.insertDataUser(modelLogTrading).catchError((error){
      print('Error db $error');
    });

  }

  @override
  Future<List<ModelLogTrading>?> getListTrading() async{
    final database = await $FloorAppDataBase.databaseBuilder('app_database.db').build();
    final logDao = database.logtradingDao;
    print('Get data base ${logDao.getListLog()}');
    return logDao.getListLog();
  }

  @override
  Future<void> cleanListLog() async{
    final database = await $FloorAppDataBase.databaseBuilder('app_database.db').build();
    final logDao = database.logtradingDao;
    await logDao.clear();
  }

   Future<bool> cancelOrder({required String id})async{
       return await _apiUtil.cancelOrder(id: id);
   }

  // @override
  // Future<Order> getOrder({String? idUser}) {
  //   return _apiUtil.getOrder(idUser: idUser!);
  // }
  //
  // @override
  // Future<List<Tickets>> getTickets({String? idUser}) {
  //   return _apiUtil.getTickets(idUser: idUser!);
  // }
  //
  // @override
  // Future<void> addOrders({String? id_puschase,String? price, Order? order}) async {
  //      return _apiUtil.addOrder(id_puschase: id_puschase, price: price, order: order);
  }
