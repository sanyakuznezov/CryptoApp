





  import 'package:flutter/material.dart';
import 'package:payarapp/domain/model/trading/model_log_trading.dart';

class ListLogTrading extends StatefulWidget{

  List<ModelLogTrading> modelLogTrading;

  ListLogTrading({required this.modelLogTrading});


  @override
  State<ListLogTrading> createState() => _ListLogTradingState();
}

class _ListLogTradingState extends State<ListLogTrading> {


  @override
  Widget build(BuildContext context) {
      return Container(
        child: _ItemList(modelLogTrading: widget.modelLogTrading[widget.modelLogTrading.length-1]),
      );
  }
}


 class _ItemList extends StatelessWidget{

  ModelLogTrading modelLogTrading;

   _ItemList({required this.modelLogTrading});


  @override
  Widget build(BuildContext context) {
        return Container(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
                children: [
                  Row(
                    children: [
                      Text('Status: ',
                      style: TextStyle(
                        color: Colors.grey,
                      ),),
                      Text('${modelLogTrading.status}',
                        style: TextStyle(
                            color: Colors.grey
                        ),)
                    ],
                  ),
                  Row(
                    children: [
                      Text('Mapket: ',
                        style: TextStyle(
                            color: Colors.grey
                        ),),
                      Text('${modelLogTrading.market}',
                        style: TextStyle(
                            color: Colors.grey
                        ),)
                    ],
                  ),
                  Row(
                    children: [
                      Text('Time: ',
                        style: TextStyle(
                            color: Colors.grey
                        ),),
                      Text('${modelLogTrading.timeStamp}',
                        style: TextStyle(
                            color: Colors.grey
                        ),)
                    ],
                  ),
                  Row(
                    children: [
                      Text('Profit: ',
                        style: TextStyle(
                            color: Colors.grey
                        ),),
                      Text('${modelLogTrading.profit}',
                        style: TextStyle(
                            color: Colors.grey
                        ),)
                    ],
                  ),
                  Row(
                    children: [
                      Text('Size: ',
                        style: TextStyle(
                            color: Colors.grey
                        ),),
                      Text('${modelLogTrading.size}',
                        style: TextStyle(
                            color: Colors.grey
                        ),)
                    ],
                  ),
                  Row(
                    children: [
                      Text('Price: ',
                        style: TextStyle(
                            color: Colors.grey
                        ),),
                      Text('${modelLogTrading.price}',
                        style: TextStyle(
                            color: Colors.grey
                        ),)
                    ],
                  ),
                  Row(
                    children: [
                      Text('Op: ',
                        style: TextStyle(
                            color: Colors.grey
                        ),),
                      Text('${modelLogTrading.nameLog}',
                        style: TextStyle(
                            color: Colors.grey
                        ),)
                    ],
                  ),
                  Divider(color: Colors.grey[600],)
                ],
            ),
          ),
        );
  }



 }



