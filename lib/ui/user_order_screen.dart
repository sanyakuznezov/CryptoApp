  
  
  import 'package:flutter/cupertino.dart';
import 'package:payarapp/domain/model/order.dart';

class UserOrderScreen extends StatefulWidget{

   final Order order;
   const UserOrderScreen({Key key,@required this.order}):super(key: key);

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
        Text('Nik: ${widget.order.getNik}')
      ],
    );
  }
  
   }