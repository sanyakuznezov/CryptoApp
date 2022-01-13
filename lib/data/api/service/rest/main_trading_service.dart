




import 'dart:convert';

import 'package:cloud_functions/cloud_functions.dart';
import 'package:crypto/crypto.dart';
import 'package:dio/dio.dart';
import 'package:payarapp/data/api/model/model_all_balances_api.dart';
import 'package:payarapp/data/api/model/modelorderplaceapi.dart';

class MainTradingService{

 static const _BASE_URL='https://ftx.com/api/';
 static const API_KEY='AQmjcrH8Q-vWS8tsrzZjqWDRzNXH-QVIysguGeu9';
 static const API_PRIVATE_KEY='S3FtewQslutLHbji4hm2_FyJOpjjDMRN0imc6xjY';
   final Dio _dio=Dio(BaseOptions(baseUrl: _BASE_URL));


   //main balsnse
    Future<List<ModelAllBalancesApi>?> getBalance() async{
     try{
       final ts=DateTime.now().millisecondsSinceEpoch;
       var key = utf8.encode(API_PRIVATE_KEY);
       var signaturePayload = utf8.encode('${ts}GET/api/wallet/all_balances');
       final hmac256=Hmac(sha256, key);
       Digest sha256Result = hmac256.convert(signaturePayload);
       final response = await _dio.get(
           'wallet/all_balances',
           options: Options(
             sendTimeout: 5000,
             receiveTimeout: 10000,
              headers: {'FTX-KEY':API_KEY,'FTX-SIGN':sha256Result,'FTX-TS': ts},
           )
       );

       return (response.data['result']['main'] as List)
           .map((x) => ModelAllBalancesApi.fromApi(map: x))
           .toList();
     }on DioError catch(error){
       if (error.type == DioErrorType.receiveTimeout ||
           error.type == DioErrorType.sendTimeout) {
       //  timeout error
       }


       return null;
     }

    }


    Future<bool> placeOrder({required ModelOrderRequestPlaceApi modelOrderRequestPlaceApi})async{
      try{
        final ts=DateTime.now().millisecondsSinceEpoch;
        var key = utf8.encode(API_PRIVATE_KEY);
        var signaturePayload = utf8.encode('${ts}GET/api/orders');
        final hmac256=Hmac(sha256, key);
        Digest sha256Result = hmac256.convert(signaturePayload);
        final response = await _dio.post(
            'orders',
            data: {
              "market": modelOrderRequestPlaceApi.market,
              "side": modelOrderRequestPlaceApi.side,
              "price":modelOrderRequestPlaceApi.price,
              "type": modelOrderRequestPlaceApi.type,
              "size": modelOrderRequestPlaceApi.size,
              "reduceOnly": false,
              "ioc": false,
              "postOnly": false,
              "clientId": null
            },
            options: Options(
              sendTimeout: 5000,
              receiveTimeout: 10000,
              headers: {'FTX-KEY':API_KEY,'FTX-SIGN':sha256Result,'FTX-TS': ts},
            )
        );

        return response.data['success'];

      }on DioError catch(error){
        if (error.type == DioErrorType.receiveTimeout ||
            error.type == DioErrorType.sendTimeout) {
          //  timeout error
        }


        return false;
      }



    }


























    Future<void> startWS() async{
   HttpsCallable callable = FirebaseFunctions.instance.httpsCallable('startWS');
   await callable.call(
     <String,dynamic>{
       'start':123456,
     },
   );
 }


 Future<void> stopWS() async{
   HttpsCallable callable = FirebaseFunctions.instance.httpsCallable('stopWS');
   await callable.call(
     <String,dynamic>{
       'stop':123456,
     },
   );
 }


 Future<void> addOrdersell() async{
   HttpsCallable callable = FirebaseFunctions.instance.httpsCallable('addOrdersell');
   await callable.call(
     <String,dynamic>{
       'stop':123456,
     },
   );
 }

 Future<void> addOrderbuy() async{
   HttpsCallable callable = FirebaseFunctions.instance.httpsCallable('addOrderbuy');
   await callable.call(
     <String,dynamic>{
       'stop':123456,
     },
   );
 }

 Future<void> startTrending() async{
   HttpsCallable callable = FirebaseFunctions.instance.httpsCallable('startTrending');
   await callable.call(
     <String,dynamic>{
       'stop':123456,
     },
   );
 }

}