


   import 'package:flutter/material.dart';

class Sizer{

     final BuildContext buildContext;
     final int maxSize;

     Sizer({buildContext,maxSize}): this.buildContext=buildContext, this.maxSize=maxSize;


      witch (value){
        var g=MediaQuery.of(buildContext).size.width*value/100;
        var r;
        if(maxSize<g){
          r=maxSize;
        }else{
          r=g;
        }
        return  r;
    }

     height (value){
       var g=MediaQuery.of(buildContext).size.height*value/100;
       var r;
       if(maxSize<g){
         r=maxSize;
       }else{
         r=g;
       }
       return  r;
     }


   double size (value){
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