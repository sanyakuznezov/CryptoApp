



  class ModelTickerPriceApi{

   String symbol;
   String price;

   ModelTickerPriceApi.fromApi({required Map<String,dynamic> map}):
     symbol=map['symbol'],
     price=map['price'];
    }