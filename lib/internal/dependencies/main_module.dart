

import 'package:flutter/cupertino.dart';

class MainModule{
   static BuildContext _buildContext;
   static  setContext(BuildContext context){
      _buildContext=context;
   }
   static BuildContext getContext(){
   return _buildContext;
   }
 }