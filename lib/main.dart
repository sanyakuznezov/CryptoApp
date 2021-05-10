import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:payarapp/ui/enter_code_screen.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(InitFire());
}




class MyApp extends StatefulWidget {

  // This widget is the root of your application.
  @override
  _MyAppState createState() => _MyAppState();
}
class _MyAppState extends State<MyApp>{


  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return  MaterialApp(
      debugShowCheckedModeBanner: false,
      home:  EnterCodeScreen(),
    );
  }

}


     class InitFire extends StatefulWidget{
  @override
  _InitFireState createState()=>_InitFireState();

}

   class _InitFireState extends State<InitFire> {
     final Future<FirebaseApp> _initialization = Firebase.initializeApp();

     @override
     Widget build(BuildContext context) {
       // TODO: implement build
       return  FutureBuilder(
           // Initialize FlutterFire:
           future: _initialization,
           builder: (context, snapshot) {
             // Check for errors
             if (snapshot.hasError) {
               print('hasError');
               return Container(
                 color: Colors.red,
                 width: 200,
                 height: 200,
               );

             }

             // Once complete, show your application
             if (snapshot.connectionState == ConnectionState.done) {
               print('connectionState done');
               return MyApp();
             }
             // Otherwise, show something whilst waiting for initialization to complete
               return Container(
                 color: Colors.orange,
                 width: 200,
                 height: 200,
               );
           },

       );

     }
     }




