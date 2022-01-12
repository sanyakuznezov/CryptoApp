




import 'dart:convert';

import 'package:cloud_functions/cloud_functions.dart';
import 'package:crypto/crypto.dart';
import 'package:dio/dio.dart';

class MainTradingService{

 static const _BASE_URL='https://ftx.com/api/';
 static const API_KEY='AQmjcrH8Q-vWS8tsrzZjqWDRzNXH-QVIysguGeu9';
 static const API_PRIVATE_KEY='S3FtewQslutLHbji4hm2_FyJOpjjDMRN0imc6xjY';
   final Dio _dio=Dio(BaseOptions(baseUrl: _BASE_URL));


   //main balsnse
    Future<void> getBalance() async{
     try{

       final ts=DateTime.now().millisecondsSinceEpoch;
       var key = utf8.encode(API_PRIVATE_KEY);
       var signaturePayload = utf8.encode('f${ts}GET/api/wallet/balances');
       final hmac256=Hmac(sha256, key);
       Digest sha256Result = hmac256.convert(signaturePayload);
       final value = {
         'FTX-KEY': API_KEY,
         'FTX-SIGN': sha256Result,
         'FTX-TS': ts};
       final response = await _dio.get(
           'wallet/balances',
           queryParameters: value,
           options: Options(
             sendTimeout: 5000,
             receiveTimeout: 10000,
             contentType: 'application/x-www-form-urlencoded',
           )
       );
       print('Response $response');
       // return (response.data['result'] as List)
       //     .map((x) => ModelTickerPriceApi.fromApi(map: x))
       //     .toList();
     }on DioError catch(error){
       print('Error respounse $error');
       if (error.type == DioErrorType.receiveTimeout ||
           error.type == DioErrorType.sendTimeout) {
       //  timeout error
       }


     }

    return null;

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