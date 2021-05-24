  
  

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:payarapp/domain/model/order.dart';
import 'package:payarapp/domain/model/tickets.dart';
import 'package:payarapp/ui/artifacts_widget.dart';
import 'package:payarapp/util/combi_to_array.dart';
import 'package:payarapp/util/path_to_img.dart';

class UserOrderScreen extends StatefulWidget{

   final Order order;
   final List<Tickets> list;
   const UserOrderScreen({Key key,@required this.order,@required this.list}):super(key: key);

  @override
  _UserOrderScreenState createState() {
    // TODO: implement createState
   return _UserOrderScreenState();
  }
  
  
}
    class _UserOrderScreenState extends State<UserOrderScreen>{


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        decoration: BoxDecoration(
          image: DecorationImage(
            image: Image.asset('assets/bg_page.png').image,
            fit: BoxFit.cover
          ),
        ),
        child: Column(
          children: [
            Container(
              width: MediaQuery.of(context).size.width,
              height: 80,
              color: Colors.black45,
              child: Padding(
                padding: const EdgeInsets.fromLTRB(10.0, 40.0, 10.0,10.0),
                child:Row(
                  children: [
                     Container(
                       alignment: Alignment.centerLeft,
                       child: Row(
                         children: [
                           Container(
                             width: 50,
                             height: 50,
                             decoration: BoxDecoration(
                                 shape: BoxShape.circle,
                                 image: DecorationImage(
                                     image: NetworkImage(widget.order.getAvatar),
                                     fit: BoxFit.fill
                                 )
                             ),
                           ),
                           Padding(
                             padding: const EdgeInsets.fromLTRB(5.0,0.0, 0.0, 0.0),
                             child: Text(widget.order.getNik,
                               textAlign: TextAlign.start,
                               style: TextStyle(
                                   fontSize: 15.0,
                                   color: Colors.white
                               ),),
                           ),

                         ],
                       ),
                     ),
                    Expanded(
                      child:  Container(
                        alignment: Alignment.centerRight,
                        child: Text('order id: ${widget.order.getId}',
                          textAlign: TextAlign.right,
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 15.0
                          ),),
                      )
                    )
                    ],
                )
              )
            ),
            _widget(widget.order.getImg, widget.order.prize, widget.list, context),


          ],
        ),
      ),
    );
  }

  @override
  void initState() {
    super.initState();
  }
}
   
   Widget _widget(String url,String prize,List<Tickets> list,BuildContext context){
      return Container(
        height: MediaQuery.of(context).size.height,
          margin: EdgeInsets.all(10.0),
          child:
            ListView(
              children: [
                Container(
                  width: 200,
                  height: 200,
                  decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      image: DecorationImage(
                          image: NetworkImage(url)
                      )
                  ),
                ),
                Center(
                  child: Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Text(prize,
                      style: TextStyle(
                          fontSize: 30,
                          color: Colors.white
                      ),),
                  ),
                ),
                ArtifactsWidget(CombiToArray.toArray(list[0].getCombi)),
                ArtifactsWidget(CombiToArray.toArray(list[1].getCombi))
              ],
            ));




   }
