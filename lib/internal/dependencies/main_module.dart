

import 'package:flutter/cupertino.dart';
import 'package:payarapp/internal/dependencies/repository_module.dart';

class MainModule{
   static BuildContext _buildContext;
   static  setContext(BuildContext context){
      _buildContext=context;
   }
   static BuildContext getContext(){
   return _buildContext;
   }
 }