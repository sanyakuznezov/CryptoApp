
 import 'package:payarapp/data/repository/firebase_data_repository.dart';
import 'package:payarapp/data/repository/socket_data_repository.dart';
import 'package:payarapp/domain/repository/firebase_repository.dart';
import 'package:payarapp/domain/repository/socket_repository.dart';
import 'package:payarapp/internal/dependencies/api_modul.dart';

class RepositoryModule{
    static FirebaseRepository? _firebaseRepository;
    static SocketRepository? _socketRepository;

    static FirebaseRepository firebaseRepository(){
      if(_firebaseRepository==null){
        _firebaseRepository=FirebaseDataRepository(ApiModule.apiUtil());
      }
      return _firebaseRepository!;
    }

    static SocketRepository socketRepository(){
      if(_socketRepository==null){
        _socketRepository=SocketDataRepository(ApiModule.socketUtil());
      }
      return _socketRepository!;
    }
}