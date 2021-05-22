  
  
  import 'package:flutter/cupertino.dart';
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
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Text('Avatar: ${widget.order.getAvatar}'),
        Text('Nik: ${widget.order.getNik}'),
        Text('Prize: ${widget.order.getPrize}'),
        Text('Id ${widget.order.getId}'),
        Text('List lenght ${widget.list.length}')
      ],
    );
  }
  
   }