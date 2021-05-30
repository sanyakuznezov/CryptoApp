import 'dart:async';

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

import 'package:payarapp/internal/dependencies/main_module.dart';
import 'package:payarapp/ui/enter_code_screen.dart';


void main() {
  WidgetsFlutterBinding.ensureInitialized();
  MainModule.ininBillingAndroid();
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
       return MaterialApp(
         debugShowCheckedModeBanner: false,
         home: FutureBuilder(
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
               startTime(context);
               //return MyApp();

             }
             // Otherwise, show something whilst waiting for initialization to complete
             return LoadIndicator();

           },

         )
       );



     }

     @override
  void initState() {
       super.initState();

     }





}


Future startTime(BuildContext context)async{
 await Timer(Duration(seconds: 3),()=>Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context)=>MyApp())));
}


class LoadIndicator extends StatefulWidget {

  // This widget is the root of your application.
  @override
  _StateLoadIndicator createState() => _StateLoadIndicator();
}
class _StateLoadIndicator extends State<LoadIndicator>{


  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return  MaterialApp(
      debugShowCheckedModeBanner: false,
      home:  Scaffold(
        body: SplashScreen()
      )
    );
  }

}


class SplashScreen extends StatelessWidget{

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Center(
        child: MyStatefulWidget());
  }

}

class MyStatefulWidget extends StatefulWidget {
  const MyStatefulWidget({key}) : super(key: key);

  @override
  _MyStatefulWidgetState createState() => _MyStatefulWidgetState();
}


class _MyStatefulWidgetState extends State<MyStatefulWidget> with TickerProviderStateMixin {
  late final AnimationController _controller = AnimationController(
    duration: const Duration(seconds: 2),
    vsync: this,
  )..repeat(reverse: true);
  late final Animation<double> _animation = CurvedAnimation(
    parent: _controller,
    curve: Curves.elasticOut,
  );




  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: RotationTransition(
          turns: _animation,
          child:  Padding(
            padding: EdgeInsets.all(8.0),
            child: Image.asset('assets/ic_load.png',
                width: 60,
                height: 60),
          ),
        ),
      ),
    );
  }




}