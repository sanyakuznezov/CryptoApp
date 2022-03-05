




 import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:payarapp/domain/model/trading/model_log_trading.dart';
import 'package:payarapp/internal/dependencies/repository_module.dart';
import 'package:payarapp/ui/screen_list_log/widgets/item_log.dart';

class PageLogList extends StatefulWidget{




  PageLogList();

  @override
  State<PageLogList> createState() => _PageLogListState();
}

class _PageLogListState extends State<PageLogList> with SingleTickerProviderStateMixin{
  late TabController _controller;

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        floatingActionButton: FloatingActionButton(
          onPressed: (){
             RepositoryModule.apiRepository().cleanListLog();
          },
        ),
        appBar: AppBar(
          actions: [
            Expanded(
              child: Center(
                child: Text(
                  'LogList',
                  style: TextStyle(fontSize: 20),
                ),
              ),
            )
          ],

          bottom: TabBar(
            controller: _controller, tabs: [
              Text('Up profit'),
            Text('Down profit'),
          ],
          ),
        ),

        body: FutureBuilder<List<ModelLogTrading>?>(
          future: RepositoryModule.apiRepository().getListTrading(),
          builder: (context,data){
            if(data.hasData){
              return TabBarView(
                controller: _controller,
                children: [
                  ListView(
                    children: List.generate(getListUpProfit(data.data).length, (index){
                      return ItemLog(modelLogTrading: getListUpProfit(data.data)[index],);
                    }),
                  ),
                  ListView(
                    children: List.generate(getListDownProfit(data.data).length, (index){
                      return ItemLog(modelLogTrading: getListDownProfit(data.data)[index],);
                    }),
                  )
                ],
              );
            }
            return Center(child: CircularProgressIndicator());
          },
        ),
      ),
    );
  }

    List<ModelLogTrading> getListUpProfit(List<ModelLogTrading>? list){
    List<ModelLogTrading> g=[];
       list!.forEach((element) {
           if(element.profit>0){
             g.add(element);
           }
       });
       return g;
    }

  List<ModelLogTrading> getListDownProfit(List<ModelLogTrading>? list){
    List<ModelLogTrading> g=[];
    list!.forEach((element) {
      if(element.profit<0){
        g.add(element);
      }
    });
    return g;
  }

  @override
  void initState() {
    super.initState();
    _controller=TabController(length: 2, vsync: this);
  }
}




