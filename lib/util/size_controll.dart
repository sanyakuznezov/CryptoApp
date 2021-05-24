


   import 'dart:ffi';

import 'package:flutter/material.dart';

class Sizer{

     final BuildContext buildContext;
     final double maxSize;

     Sizer({buildContext,maxSize}): this.buildContext=buildContext, this.maxSize=maxSize;


      double witch (dynamic value){
        var g=MediaQuery.of(buildContext).size.width*value/100;
        var r;
        if(maxSize<g){
          r=maxSize;
        }else{
          r=g;
        }
        return  r;
    }

      double height (dynamic value){
       var g=MediaQuery.of(buildContext).size.height*value/100;
       var r;
       if(maxSize<g){
         r=maxSize;
       }else{
         r=g;
       }
       return  r;
     }


      size ( value){
     var g=MediaQuery.of(buildContext).size.width*value/100;
     var r;
     if(maxSize<g){
       r=maxSize;
     }else{
       r=g;
     }
     return  r;
    }

}