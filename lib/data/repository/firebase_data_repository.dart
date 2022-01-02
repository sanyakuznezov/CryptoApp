

  import 'package:payarapp/data/api/api_util.dart';
import 'package:payarapp/domain/model/trading/model_ticker_price.dart';
import 'package:payarapp/domain/repository/firebase_repository.dart';

class FirebaseDataRepository extends FirebaseRepository{

   ApiUtil _apiUtil;

   FirebaseDataRepository(this._apiUtil);

  @override
  Future<List<ModelTickerPrice>> getListTickerPrice(){
      return _apiUtil.getListTickerPrice();
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
