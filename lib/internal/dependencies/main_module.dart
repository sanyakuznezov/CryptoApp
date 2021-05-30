

import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:in_app_purchase_android/in_app_purchase_android.dart';




class MainModule{
   static BuildContext? _buildContext;
   static  setContext(BuildContext context){
      _buildContext=context;
   }
   static BuildContext getContext(){
   return _buildContext!;
   }

   static ininBillingAndroid(){
      if (defaultTargetPlatform == TargetPlatform.android) {
         InAppPurchaseAndroidPlatformAddition.enablePendingPurchases();
      }
   }
 }