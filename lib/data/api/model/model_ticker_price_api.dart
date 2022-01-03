



  class ModelTickerPriceApi{

   String symbol;
   //  bool enabled;
   // bool postOnly;
   // double priceIncrement;
   // double sizeIncrement;
   //  double minProvideSize;
   // double last;
   // double bid;
   // double ask;
   double price;
   // String type;
   // dynamic baseCurrency;
   // dynamic quoteCurrency;
   // String underlying;
   // bool restricted;
   // bool highLeverageFeeExempt;
   // double change1h;
   // double change24h;
   // double changeBod;
   // double quoteVolume24h;
   // double volumeUsd24h;

   ModelTickerPriceApi.fromApi({required Map<String,dynamic> map}):
      symbol=map['name']??'Null',
   //       enabled=map['enabled'],
   //       postOnly=map['postOnly'],
   // priceIncrement=map['priceIncrement'],
   // sizeIncrement=map['sizeIncrement'],
   // minProvideSize=map['minProvideSize'],
   // last=map['last'],
   // bid=map['bid'],
   // ask=map['ask'],
   // type=map['type'],
   // baseCurrency=map['baseCurrency'],
   // quoteCurrency=map['quoteCurrency'],
   // underlying=map['underlying'],
   // restricted=map['restricted'],
   // highLeverageFeeExempt=map['highLeverageFeeExempt'],
   // change1h=map['change1h'],
   // change24h=map['change24h'],
   // changeBod=map['changeBod'],
   // quoteVolume24h=map['quoteVolume24h'],
   // volumeUsd24h=map['volumeUsd24h'],
     price=map['price']??0.0000;
    }