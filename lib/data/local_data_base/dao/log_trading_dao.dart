


 import 'package:floor/floor.dart';

@dao
 class LogTradingDao{

 @Query('SELECT * FROM ModelLogTrading')
 Future<List<LogTradingDao>?> getListLog();

 @insert
 Future<void> insertDataUser(LogTradingDao logTradingDao);

 @Query('DELETE FROM ModelLogTrading')
 Future<void> clear();

 }