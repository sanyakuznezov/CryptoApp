



  class ModelTickerPriceApi {


    double bid;
    double ask;
    double last;
    double time;


    ModelTickerPriceApi.fromApi({required Map<String, dynamic> map}):
          bid=map['bid'] as double,
          ask=map['ask'] as double,
          last=map['last'] as double,
          time=map['time'] as double;


  }