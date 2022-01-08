



import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:payarapp/internal/dependencies/repository_module.dart';

class  ScreenControl extends StatefulWidget{
  @override
  State<ScreenControl> createState() => _ScreenControlState();
}

class _ScreenControlState extends State<ScreenControl> {
  @override
  Widget build(BuildContext context) {
      return Scaffold(
        body: Container(
          child: Center(
            child:
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: ElevatedButton(
                      onPressed: ()async{
                        await RepositoryModule.firebaseRepository().startWS();
                  },
                      child:
                  const Text('start')),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: ElevatedButton(
                      onPressed: ()async{
                        await RepositoryModule.firebaseRepository().stopWS();
                  },
                      child:
                      const Text('stop')),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: ElevatedButton(
                      onPressed: ()async{
                        await RepositoryModule.firebaseRepository().addOrdersell();
                      },
                      child:
                      const Text('sell')),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: ElevatedButton(
                      onPressed: ()async{
                       await RepositoryModule.firebaseRepository().addOrderbuy();
                      },
                      child:
                      const Text('buy')),
                )
              ],
            ),
          ),
        ),
      );
  }
}