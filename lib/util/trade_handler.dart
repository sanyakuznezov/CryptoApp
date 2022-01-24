



 class TradeHandler{

    static const double TAKE_PROFIT=0.08;
    static const double STOP_LOSS=0.07;
    bool _isCall=false;
    double? priceSell;
    double? priceSellTrendFell;
    double? profit;
    buy(priceBuy){
      _isCall=false;
      priceSell=priceBuy+(priceBuy*TAKE_PROFIT)/100;
    }

    bid(priceBid){
      priceSellTrendFell=priceBid-(priceBid*STOP_LOSS)/100;
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