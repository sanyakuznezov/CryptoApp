




 import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:payarapp/domain/state/state_list_ticker.dart';

class ListCrypts extends StatefulWidget{
  @override
  State<ListCrypts> createState() => _ListCryptsState();
}

class _ListCryptsState extends State<ListCrypts> {

  StateListTicker _stateListTicker=StateListTicker();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black26,
        actions: [
          Expanded(
            child: Center(child: Text('Список пар',
            style: TextStyle(
              fontSize: 25
            ),)),
          )
        ],
      ),
      body: Observer(
          builder: (_){
             if(_stateListTicker.isLoading){
               return Center(
                 child: CircularProgressIndicator(
                   color: Colors.white,
                 ),
               );
             }else {
               return ListView(
                 children: List.generate(_stateListTicker.listTicker!.length, (index){
                   return _ItemPrice(symbol: _stateListTicker.listTicker![index].symbol,price:
                     _stateListTicker.listTicker![index].price,);
                 }),
               );
             }
      }),
    );
  }

  @override
  void initState() {
    super.initState();
    _stateListTicker.updateListData();
  }

  @override
  void dispose() {
    super.dispose();
    _stateListTicker.dispose();
  }
}


 class _ItemPrice extends StatelessWidget{

   final String symbol;
   final String price;
   _ItemPrice({required this.symbol,required this.price});
  @override
  Widget build(BuildContext context) {
   return Padding(
     padding: const EdgeInsets.fromLTRB(8.0,10.0,8.0,10.0),
     child: Column(
       crossAxisAlignment: CrossAxisAlignment.start,
       children: [
         Text('$symbol',
           style: TextStyle(
             color: Colors.white,
             fontWeight: FontWeight.bold,
             fontSize: 12,
           ),
         ),
         Text('$price USD',
           style: TextStyle(
             color: Colors.white,
             fontSize: 10,
           ),
         ),
         Divider(color: Colors.white30),
       ],
     ),
   );
  }

 }

