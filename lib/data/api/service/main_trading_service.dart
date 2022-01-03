




import 'package:dio/dio.dart';
import 'package:payarapp/data/api/model/model_ticker_price_api.dart';

class MainTradingService{

 static const _BASE_URL='https://ftx.com/api/';

   final Dio _dio=Dio(BaseOptions(baseUrl: _BASE_URL));


   //список цена тикера
    Future<List<ModelTickerPriceApi>?> getListTickerPrice() async{
     try{
       final response = await _dio.get(
           'markets',
           options: Options(
             sendTimeout: 5000,
             receiveTimeout: 10000,
             contentType: 'application/x-www-form-urlencoded',
           )
       );
       return (response.data['result'] as List)
           .map((x) => ModelTickerPriceApi.fromApi(map: x))
           .toList();
     }on DioError catch(error){
       if (error.type == DioErrorType.receiveTimeout ||
           error.type == DioErrorType.sendTimeout) {
       //  timeout error
       }


     }

    return null;

    }

}