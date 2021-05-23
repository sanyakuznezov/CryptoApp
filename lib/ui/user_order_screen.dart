  
  

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:payarapp/domain/model/order.dart';
import 'package:payarapp/domain/model/tickets.dart';

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
                      padding: const EdgeInsets.fromLTRB(8.0,0.0, 0.0, 0.0),
                      child: Text(widget.order.getNik,
                        textAlign: TextAlign.start,
                        style: TextStyle(
                            fontSize: 15.0,
                            color: Colors.white
                        ),),
                    ),
                    Text('order id: ${widget.order.getId}',
                      textAlign: TextAlign.end,
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 15.0
                      ),)

                  ],
                ),
              )
            ),
            Padding(padding: EdgeInsets.fromLTRB(0.0, 20.0, 0.0, 10.0),
            child: _widget(widget.order.getImg,widget.order.prize))

          ],
        ),
      ),
    );
  }
  
   }
   
   Widget _widget(String url,String prize){
      return SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
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
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: Text(prize,
              style: TextStyle(
                fontSize: 30,
                color: Colors.white
              ),),
            )
          ],
        ),
      );
   }