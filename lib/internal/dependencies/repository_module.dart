
 import 'package:payarapp/data/repository/firebase_data_repository.dart';

import 'package:payarapp/domain/repository/firebase_repository.dart';

import 'package:payarapp/internal/dependencies/api_modul.dart';

class RepositoryModule{
    static FirebaseRepository? _firebaseRepository;


    static FirebaseRepository firebaseRepository(){
      if(_firebaseRepository==null){
        _firebaseRepository=FirebaseDataRepository(ApiModule.apiUtil());
      }
      return _firebaseRepository!;
    }


}