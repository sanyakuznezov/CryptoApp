


 import 'package:floor/floor.dart';
import 'package:payarapp/domain/model/trading/model_log_trading.dart';

@dao
 abstract class LogTradingDao{

 @Query('SELECT * FROM ModelLogTrading')
 Future<List<ModelLogTrading>?> getListLog();

 @insert
 Future<void> insertDataUser(ModelLogTrading modelLogTrading);

 @Query('DELETE FROM ModelLogTrading')
 Future<void> clear();

 }