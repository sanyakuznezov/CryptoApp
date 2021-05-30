

  import 'package:payarapp/data/api/api_util.dart';
import 'package:payarapp/domain/model/order.dart';
import 'package:payarapp/domain/model/tickets.dart';
import 'package:payarapp/domain/repository/firebase_repository.dart';

class FirebaseDataRepository extends FirebaseRepository{

   ApiUtil _apiUtil;

   FirebaseDataRepository(this._apiUtil);

  @override
  Future<Order> getOrder({String? idUser}) {
    return _apiUtil.getOrder(idUser: idUser!);
  }

  @override
  Future<List<Tickets>> getTickets({String? idUser}) {
    return _apiUtil.getTickets(idUser: idUser!);
  }
  

  }