// 项目常量
import 'package:shared_preferences/shared_preferences.dart';

class Util {
  static String kJuheUrl = 'http://v.juhe.cn/movie/movies.today';

  static String kMainUrl = 'https://cloudapi.mankuhome.com/v2/';
  static String kMankuSystemAdmin = 'manku-system-admin/';
  static String kMankuItemAdmin = 'manku-item-admin/';
  static String kMankuOrderAdmin = 'manku-order-admin/';

  static String token = '';
  static String shopId = '';

//  增
  static addSharePreference(String key, String value) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString(key, value);
  }
//  删
  static removeSharePreference(String key) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.remove(key);
  }
//  查
  static Future<String> getSharePreference(String key) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString(key);
  }
}