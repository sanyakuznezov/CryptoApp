




import 'package:floor/floor.dart';
import 'package:payarapp/domain/model/trading/model_log_trading.dart';
import 'dart:async';
import 'package:sqflite/sqflite.dart' as sqflite;
import 'dao/log_trading_dao.dart';
part 'app_data_base.g.dart';


@Database(version: 1, entities: [ModelLogTrading])
abstract class AppDataBase extends FloorDatabase{
  LogTradingDao get logtradingDao;


}