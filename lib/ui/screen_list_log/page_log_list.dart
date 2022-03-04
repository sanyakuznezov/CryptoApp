




 import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:payarapp/domain/model/trading/model_log_trading.dart';
import 'package:payarapp/internal/dependencies/repository_module.dart';
import 'package:payarapp/ui/screen_list_log/widgets/item_log.dart';

class PageLogList extends StatelessWidget{



  final PageController _controller=PageController();

  PageLogList();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          Text(
            'LogList'
          )
        ],
      ),
      body: FutureBuilder<List<ModelLogTrading>?>(
        future: RepositoryModule.apiRepository().getListTrading(),
        builder: (context,data){
          if(data.hasData){
            print('data ${data.data!.length}');
            return PageView(
              controller: _controller,
              children: [
                ListView(
                  children: List.generate(data.data!.length, (index){
                    return ItemLog(modelLogTrading: data.data![index],);
                  }),
                ),
                ListView(
                  children: List.generate(data.data!.length, (index){
                    return ItemLog(modelLogTrading: data.data![index],);
                  }),
                )
              ],
            );
          }
          return Center(child: CircularProgressIndicator());
        },
      ),
    );
  }

  }




