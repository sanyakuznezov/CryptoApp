





import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:mobx/mobx.dart';
import 'package:payarapp/domain/model/trading/model_ticker_price.dart';
import 'package:payarapp/internal/dependencies/repository_module.dart';
part 'state_list_ticker.g.dart';
class StateListTicker=StateListTickerBase with _$StateListTicker;
abstract class StateListTickerBase with Store{

    @observable
    bool isLoading=true;
    @observable
    bool isError=false;
    @observable
    List<ModelTickerPrice>? listTicker;
    Timer? _timer;

    @action
    updateListData(){
      getListTicker();
      _timer=Timer.periodic(Duration(seconds:5), (timer) {
        getListTicker();
      });

    }

  @action
   Future<void> getListTicker()async{
    final list=await RepositoryModule.firebaseRepository().getListTickerPrice().catchError(
        (error){
          isLoading=false;
          isError=true;
          print('Error $error');
        }

    );

    if(list.isNotEmpty){
      listTicker=list;
      isLoading=false;
      isError=false;
      print('List ${listTicker!.length}');
    }

   }

   @action
    dispose(){
      _timer!.cancel();
   }

}