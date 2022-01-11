



  class ModelTickerPriceApi {


    double bid;
    double ask;
    double last;
    double time;


    ModelTickerPriceApi.fromApi({required Map<String, dynamic> map}):
          bid=map['bid']??0.0,
          ask=map['ask']??0.0,
          last=map['last']??0.0,
          time=map['time']??0.0;


  }