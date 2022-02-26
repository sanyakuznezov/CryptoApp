



 class ModelOrderRequestPlaceApi{

   String market;
   String side;
   double? price;
  String type;
  double size;
  bool reduceOnly;
  bool ioc;
  bool  postOnly;
  String? clientId;

   ModelOrderRequestPlaceApi({required this.market,required this.side,required this.price,required this.type,required this.size,
   required this.reduceOnly,required this.ioc,required this.postOnly,required this.clientId});

 }