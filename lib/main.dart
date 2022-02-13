import 'dart:async';
import 'dart:convert';

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';

import 'package:payarapp/internal/dependencies/main_module.dart';

import 'package:payarapp/ui/screen_control_trade/page_control.dart';
import 'package:web_socket_channel/web_socket_channel.dart';


void main() {
  WidgetsFlutterBinding.ensureInitialized();
 MainModule.ininBillingAndroid();
 runApp(InitFire());

}




class MyApp extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return  MaterialApp(
      debugShowCheckedModeBanner: false,
      home:  PageControl(),
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
         home: Scaffold(
           body: FutureBuilder(
             // Initialize FlutterFire:
             future: _initialization,
             builder: (context, snapshot) {
               // Check for errors
               if (snapshot.hasError) {
                 return Container(
                   width: MediaQuery.of(context).size.width,
                   height: MediaQuery.of(context).size.height,
                   child: Column(
                     mainAxisAlignment: MainAxisAlignment.center,
                     crossAxisAlignment: CrossAxisAlignment.center,
                     children: [
                       Image.asset('assets/dinamite.png',width: 100.0,height: 100.0),
                       Padding(
                         padding: const EdgeInsets.all(15.0),
                         child: Text('Something went wrong',
                           textAlign: TextAlign.center,
                           style: TextStyle(
                               fontSize: 20.0,
                               fontFamily: 'Old',
                               color: Colors.red
                           ),),
                       )
                     ],
                   ),
                 );
               }

               // Once complete, show your application
               if (snapshot.connectionState == ConnectionState.done) {
                 startTime(context);

               }
               // Otherwise, show something whilst waiting for initialization to complete
               return LoadIndicator();

             },

           )
         )
       );



     }

     @override
  void initState() {
       super.initState();

     }





}


Future startTime(BuildContext context)async{

    await Timer(Duration(seconds: 3), () =>
        Navigator.of(context).pushReplacement(PageTransition(type: PageTransitionType.fade,duration: Duration(seconds: 2), child:MyApp())));
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