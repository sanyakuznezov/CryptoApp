

  import 'package:payarapp/data/api/api_util.dart';
import 'package:payarapp/data/api/model/modelorderplaceapi.dart';
import 'package:payarapp/domain/model/trading/model_all_balances.dart';
import 'package:payarapp/domain/model/trading/model_ticker_price.dart';
import 'package:payarapp/domain/repository/firebase_repository.dart';

class FirebaseDataRepository extends FirebaseRepository{

   ApiUtil _apiUtil;

   FirebaseDataRepository(this._apiUtil);

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
  Future<void> getOpenOrders() async{
    // TODO: implement getOrders
    await _apiUtil.getOpenOrders();
  }

  @override
  Future<bool> placeOrder({required ModelOrderRequestPlaceApi modelOrderRequestPlaceApi}) async{
    return await _apiUtil.placeOrder(modelOrderRequestPlaceApi: modelOrderRequestPlaceApi);
  }

  @override
  Future<void> getTrades({required String market}) {
    return _apiUtil.getTrades(market:market);
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
