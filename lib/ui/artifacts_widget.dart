
  import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:payarapp/util/path_to_img.dart';
import 'package:payarapp/util/size_controll.dart';


    // ignore: must_be_immutable
    class ArtifactsWidget extends StatelessWidget{

      List<String> combi=[];
      ArtifactsWidget(this.combi);

      @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Container(
      padding: EdgeInsets.all(8.0),
      decoration: BoxDecoration(
        shape: BoxShape.rectangle,
            color: Colors.black45,

      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.all(5.0),
                child: Text('a',
                style: TextStyle(
                  fontFamily: 'Old',
                  color: Colors.orange,
                  fontSize: 15.0
                ),),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text('1',
                    style: TextStyle(
                        fontFamily: 'Old',
                        color: Colors.orange,
                        fontSize: 15.0
                    ),),
                  _widget(combi[0],context),
                ],
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text('2',
                    style: TextStyle(
                        fontFamily: 'Old',
                        color: Colors.orange,
                        fontSize: 15.0
                    ),),
                  _widget(combi[1],context),
                ],
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text('3',
                    style: TextStyle(
                        fontFamily: 'Old',
                        color: Colors.orange,
                        fontSize: 15.0
                    ),),
                  _widget(combi[2],context),
                ],
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text('4',
                    style: TextStyle(
                        fontFamily: 'Old',
                        color: Colors.orange,
                        fontSize: 15.0
                    ),),
                  _widget(combi[3],context),
                ],
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text('5',
                    style: TextStyle(
                        fontFamily: 'Old',
                        color: Colors.orange,
                        fontSize: 15.0
                    ),),
                  _widget(combi[4],context),
                ],
              )
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.all(5.0),
                child: Text('b',
                  style: TextStyle(
                      fontFamily: 'Old',
                      color: Colors.orange,
                      fontSize: 15.0
                  ),),
              ),
              _widget(combi[5],context),
              _widget(combi[6],context),
              _widget(combi[7],context),
              _widget(combi[8],context),
              _widget(combi[9],context)
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
             children: [
               Padding(
                 padding: const EdgeInsets.all(5.0),
                 child: Text('c',
                   style: TextStyle(
                       fontFamily: 'Old',
                       color: Colors.orange,
                       fontSize: 15.0
                   ),),
               ),
               _widget(combi[10],context),
               _widget(combi[11],context),
               _widget(combi[12],context),
               _widget(combi[13],context),
               _widget(combi[14],context)
             ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
             children: [
               Padding(
                 padding: const EdgeInsets.all(5.0),
                 child: Text('d',
                   style: TextStyle(
                       fontFamily: 'Old',
                       color: Colors.orange,
                       fontSize: 15.0
                   ),),
               ),
               _widget(combi[15],context),
               _widget(combi[16],context),
               _widget(combi[17],context),
               _widget(combi[18],context),
               _widget(combi[19],context)
             ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
             children: [
               Padding(
                 padding: const EdgeInsets.all(5.0),
                 child: Text('e',
                   style: TextStyle(
                       fontFamily: 'Old',
                       color: Colors.orange,
                       fontSize: 15.0
                   ),),
               ),
               _widget(combi[20],context),
               _widget(combi[21],context),
               _widget(combi[22],context),
               _widget(combi[23],context),
               _widget(combi[24],context)
             ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
             children: [
               Padding(
                 padding: const EdgeInsets.all(5.0),
                 child: Text('f',
                   style: TextStyle(
                       fontFamily: 'Old',
                       color: Colors.orange,
                       fontSize: 15.0
                   ),),
               ),
               _widget(combi[25],context),
               _widget(combi[26],context),
               _widget(combi[27],context),
               _widget(combi[28],context),
               _widget(combi[29],context)
             ],
          )
        ],
      ),
    );
  }

    }




     Widget _widget(String id,BuildContext context){
        return Padding(
          padding: const EdgeInsets.all(2.0),
          child: Container(
            width: Sizer(buildContext: context,maxSize: 60.0).witch(60.0),
            height: Sizer(buildContext: context,maxSize: 70.0).height(70.0),
            child: Image.asset(PathToImg.toPath(id),
            fit: BoxFit.fill,),
          ),
        );
     }