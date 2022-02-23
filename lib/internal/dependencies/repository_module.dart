
 import 'package:payarapp/data/repository/api_data_repository.dart';

import 'package:payarapp/domain/repository/api_repository.dart';

import 'package:payarapp/internal/dependencies/api_modul.dart';

class RepositoryModule{
    static ApiRepository? _apiRepository;


    static ApiRepository apiRepository(){
      if(_apiRepository==null){
        _apiRepository=ApiDataRepository(ApiModule.apiUtil());
      }
      return _apiRepository!;
    }


}