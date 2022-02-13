


 import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:payarapp/domain/state/state_screen_glass.dart';

class PageGlass extends StatefulWidget{



  @override
  State<PageGlass> createState() => _PageGlassState();
}

class _PageGlassState extends State<PageGlass> {

  StateScreenGlass? _stateScreenGlass;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Colors.red,
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    _stateScreenGlass=StateScreenGlass();
    _stateScreenGlass!.getOrderBook();
  }

  @override
  void dispose() {
    super.dispose();
    _stateScreenGlass!.close();
  }
}