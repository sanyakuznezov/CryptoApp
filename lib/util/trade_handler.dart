



 class TradeHandler{

    static const double SALE_THRESHOLD=0.05;
    static const double PURCHASE_THRESHOLD=0.03;
    bool _isCall=false;
    double? priceSell;
    double? priceSellTrendFell;
    double? profit;
    buy(priceBuy){
      _isCall=false;
      priceSell=priceBuy+(priceBuy*SALE_THRESHOLD)/100;
    }

    bid(priceBid){
      priceSellTrendFell=priceBid-(priceBid*SALE_THRESHOLD)/100;
    }



    control({required double bidPriceOfTicker,required Function callback}){
        if(priceSell!<bidPriceOfTicker){
          if(!_isCall){
            profit=bidPriceOfTicker-priceSell!;
            callback(1,bidPriceOfTicker,profit);
            _isCall=true;
          }

        }

        if(priceSellTrendFell!>bidPriceOfTicker){
          if(!_isCall){
            profit=bidPriceOfTicker-priceSell!;
            callback(2,bidPriceOfTicker,profit);
            _isCall=true;
          }
        }

    }





 }