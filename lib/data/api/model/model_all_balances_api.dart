



 class ModelAllBalancesApi{


   String coin;
   double total;
   double usdValue;

   ModelAllBalancesApi.fromApi({required Map<String,dynamic> map}):
       coin=map['coin'],
       total=map['total'],
       usdValue=map['usdValue'];


 }