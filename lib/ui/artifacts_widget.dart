
  import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:payarapp/util/path_to_img.dart';


    class ArtifactsWidget extends StatelessWidget{

      List<String> combi=[];
      ArtifactsWidget(this.combi);

      @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return GridView.builder(gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          crossAxisSpacing: 20,
         childAspectRatio: 3 / 2,
          mainAxisSpacing: 20
      ),itemCount: 30, itemBuilder: (BuildContext b,index){
        return Image.asset(PathToImg.toPath(combi[index]),
        width: 100,
        height: 100,);
      });
  }

    }