


 import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:payarapp/domain/state/state_screen_glass.dart';

class PageGlass extends StatefulWidget{



  @override
  State<PageGlass> createState() => _PageGlassState();
}

class _PageGlassState extends State<PageGlass> {

  StateScreenGlass? _stateScreenGlass;


  @override
  Widget build(BuildContext context) {

    return Scaffold(
      body: Container(
        margin: const EdgeInsets.fromLTRB(0, 30, 0, 0),
        child: Observer(builder: (_){
           if(_stateScreenGlass!.hasData){
             return SingleChildScrollView(
               child: Center(
                 child: Container(
                   height: MediaQuery.of(context).size.height,
                   child: _stateScreenGlass!.trandUp?Icon(Icons.arrow_circle_up,color: Colors.green,size: 100,):Icon(Icons.arrow_circle_down,color: Colors.red,size: 100,),
                 ),
               ),
               // child: Row(
               //   crossAxisAlignment: CrossAxisAlignment.start,
               //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
               //   children: [
               //
               //     // Column(
               //     //   crossAxisAlignment: CrossAxisAlignment.start,
               //     //   children: List.generate(_stateScreenGlass!.asksFinal.length, (index){
               //     //     return _ItemGlassAsk(stateScreenGlass:_stateScreenGlass!,price: _stateScreenGlass!.asksFinal[index].price, size:  _stateScreenGlass!.asksFinal[index].size);
               //     //   }),
               //     // ),
               //     // Column(
               //     //   crossAxisAlignment: CrossAxisAlignment.end,
               //     //   children: List.generate(_stateScreenGlass!.bidsFinal.length, (index){
               //     //     return _ItemGlassBid(price: _stateScreenGlass!.bidsFinal[index].price, size:  _stateScreenGlass!.bidsFinal[index].size);
               //     //   }),
               //     // ),
               //     //  ElevatedButton(
               //     //     style: ButtonStyle(
               //     //       backgroundColor: MaterialStateProperty.all<Color>(Colors.red),
               //     //     ),
               //     //     onPressed: (){
               //     //       _stateScreenGlass!.sell();
               //     //     },
               //     //     child: Text('Sell')),
               //     // ElevatedButton(
               //     //     style: ButtonStyle(
               //     //       backgroundColor: MaterialStateProperty.all<Color>(Colors.green),
               //     //     ),
               //     //     onPressed: (){
               //     //       _stateScreenGlass!.buy();
               //     //     },
               //     //     child: Text('Buy'))
               //   ],
               // ),
             );
           }

          return Center(child: CircularProgressIndicator());
        },),
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    _stateScreenGlass=StateScreenGlass();
    _stateScreenGlass!.getOrderBook();
    //_stateScreenGlass!.getSubscribeOrders();
    //_stateScreenGlass!.getTicker();



  }

  @override
  void dispose() {
    super.dispose();
    _stateScreenGlass!.close();
  }
}




 class _ItemGlassAsk extends StatelessWidget {

   final double price;
   final double size;
   final StateScreenGlass stateScreenGlass;

   _ItemGlassAsk({required this.price, required this.size,required this.stateScreenGlass});

   @override
   Widget build(BuildContext context) {
     // TODO: implement build
     return Container(
       color: Colors.redAccent,
       child: GestureDetector(
         onTap: (){
           stateScreenGlass.priceCurrent=price;
         },
         child: Row(
           mainAxisAlignment: MainAxisAlignment.spaceAround,
           children: [
             Padding(
               padding: const EdgeInsets.all(5.0),
               child: Text('$price'),
             ),
             Divider(),
             Text('$size',style: TextStyle(
               fontWeight: FontWeight.bold
             ),),
           ],
         ),
       ),
     );
   }


 }



 class _ItemGlassBid extends StatelessWidget {

   final double price;
   final double size;

   _ItemGlassBid({required this.price, required this.size});


   @override
   Widget build(BuildContext context) {
     // TODO: implement build
     return Container(
       color: Colors.greenAccent,
       child: Row(
         mainAxisAlignment: MainAxisAlignment.spaceAround,
         children: [
           Padding(
             padding: const EdgeInsets.all(5.0),
             child: Text('$price'),
           ),
           Divider(),
           Text('$size',style: TextStyle(
               fontWeight: FontWeight.bold
           ),),
         ],
       ),
     );
   }
 }
