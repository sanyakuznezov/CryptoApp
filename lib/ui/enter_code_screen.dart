


import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:connectivity/connectivity.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:payarapp/domain/model/order.dart';
import 'package:payarapp/internal/dependencies/main_module.dart';
import 'package:payarapp/internal/dependencies/repository_module.dart';
import 'package:payarapp/ui/user_order_screen.dart';
import 'package:payarapp/util/size_controll.dart';


TextEditingController _textEditingController;
FocusNode _focusNode;
bool _isEditingCode=false;
bool isEmptyCode=false;


class EnterCodeScreen extends StatefulWidget{
  @override
  _EnterCodeScreeState createState()=> _EnterCodeScreeState();


}
   class _EnterCodeScreeState extends State<EnterCodeScreen> {
     bool isLoader=false;
     bool _connectionStatus = false;
     final Connectivity _connectivity = Connectivity();
      StreamSubscription<ConnectivityResult> _connectivitySubscription;
     @override
     Widget build(BuildContext context) {
       MainModule.setContext(context);
       return  Scaffold(
           body: Container(
             width: MediaQuery.of(context).size.height,
             height: MediaQuery.of(context).size.height,
             decoration: BoxDecoration(
                 image: DecorationImage(
                     image: Image.asset('assets/bg_page.png').image,
                     fit:BoxFit.cover
                 )
             ),
             child: Center(
               child: Column(
                 mainAxisAlignment: MainAxisAlignment.center,
                 children: [
                        Image.asset('assets/img_logo.png',
                        width:Sizer(buildContext: context,maxSize: 200).size(50)),
                    SizedBox(
                      width: Sizer(buildContext: context,maxSize: 300).size(50),
                      child: TextField(
                        focusNode: _focusNode,
                        controller: _textEditingController,
                        keyboardType: TextInputType.text,
                        autofocus: false,
                        onChanged: (value) {
                          setState(() {
                            _isEditingCode = true;
                          });
                        },
                        onSubmitted: (value) {
                          _focusNode.unfocus();
                          FocusScope.of(context).requestFocus(_focusNode);
                        },
                        style: TextStyle(color: Colors.orange),
                        decoration: InputDecoration(
                          border: new OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide: BorderSide(
                              color: Colors.black45,
                              width: 3,
                            ),
                          ),
                          filled: true,
                          hintStyle: new TextStyle(
                            color: Colors.white24,
                          ),
                          hintText: "Code",
                          fillColor: Colors.black38,
                          errorText: _isEditingCode
                              ? isEmptyText(idUser: _textEditingController.text)
                              : null,
                          errorStyle: TextStyle(
                            fontSize: 12,
                            color: Colors.redAccent,
                          ),
                        ),
                      ),
                        ),
                   Padding(
                     padding: const EdgeInsets.all(20.0),
                     child: FlatButton(
                       color: Colors.black54,
                       hoverColor: Colors.blueGrey[900],
                       highlightColor: Colors.black,
                       onPressed: ()=>{
                          if(_connectionStatus){
                         setState(() {
                           validateCode(idUser: _textEditingController.text);
                        })
                          }else{
                         ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                       backgroundColor: Colors.black,
                       content: Text('No network connection....',
                         style: TextStyle(
                             fontSize: 15.0,
                             color: Colors.white
                         ),),
                     ))
                     }
                       },
                       shape: RoundedRectangleBorder(
                         borderRadius: BorderRadius.circular(15),
                       ),
                       child: Padding(
                         padding: EdgeInsets.only(top: 15.0, bottom: 15.0),
                         child: isLoader
                             ? SizedBox(
                           height: 16,
                           width: 16,
                           child: CircularProgressIndicator(
                             strokeWidth: 2,
                             valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                           ),
                         )
                             : Text(
                             'To confirm',
                             style: TextStyle(fontSize: 14, color: Colors.white)))),
                   ),


       ],
               ),
             ),
           ),
         );



     }

     Future <void>getUserDate({@required String idUser}) async {
       isLoader=true;
       try {
         final data = await RepositoryModule.firebaseRepository().getOrder(idUser: idUser);
         final tickets=await RepositoryModule.firebaseRepository().getTickets(idUser:idUser);
          Navigator.push(context,MaterialPageRoute(builder:(context)=>UserOrderScreen(order: data,list:tickets)));
       }on StateError catch(e){
         ScaffoldMessenger.of(context).showSnackBar(SnackBar(
           backgroundColor: Colors.black,
             content: Text('Nothing found....',
             style: TextStyle(
               color: Colors.white
             ),)));
       }on FirebaseException catch(e){
         ScaffoldMessenger.of(context).showSnackBar(SnackBar(
             backgroundColor: Colors.black,
             content: Text('Something went wrong....',
               style: TextStyle(
                   color: Colors.white
               ),)));
       }
         setState(() {
           isLoader=false;
         });


     }

      validateCode({@required String idUser}){
       if(idUser.isNotEmpty){
         getUserDate(idUser: idUser);
       }
     }

    String isEmptyText({@required String idUser}){
       if(idUser.isEmpty){
         return 'Enter the code';
       }else{
         return null;
       }
     }


     @override
  void initState() {
       initConnectivity();
       _connectivitySubscription =
           _connectivity.onConnectivityChanged.listen(_updateConnectionStatus);
    _textEditingController=TextEditingController();
    _focusNode=FocusNode();
     }


     @override
     void dispose() {
       _connectivitySubscription.cancel();
       super.dispose();
     }

     Future<void> initConnectivity() async {
       ConnectivityResult result = ConnectivityResult.none;
       // Platform messages may fail, so we use a try/catch PlatformException.
       try {
         result = await _connectivity.checkConnectivity();
       } on PlatformException catch (e) {
         print(e.toString());
       }

       // If the widget was removed from the tree while the asynchronous platform
       // message was in flight, we want to discard the reply rather than calling
       // setState to update our non-existent appearance.
       if (!mounted) {
         return Future.value(null);
       }

       return _updateConnectionStatus(result);
     }


     Future<void> _updateConnectionStatus(ConnectivityResult result) async {
       switch (result) {
         case ConnectivityResult.wifi:
           setState(() {
             _connectionStatus = true;
           });
           break;
         case ConnectivityResult.mobile:
           setState(() {
             _connectionStatus = true;
           });

           break;
         case ConnectivityResult.none:
           ScaffoldMessenger.of(context).showSnackBar(SnackBar(
             backgroundColor: Colors.black,
             content: Text('No network connection....',
               style: TextStyle(
                   fontSize: 15.0,
                   color: Colors.white
               ),),
           ));
           setState(() => _connectionStatus = false);
           break;
         default:
           setState(() => _connectionStatus = false);
           ScaffoldMessenger.of(context).showSnackBar(SnackBar(
             backgroundColor: Colors.white,
             content: Text('No network connection....',
               style: TextStyle(
                   fontSize: 20.0,
                   color: Colors.red
               ),),
           ));
           break;

       }



     }

}





