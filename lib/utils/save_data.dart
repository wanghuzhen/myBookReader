import 'package:shared_preferences/shared_preferences.dart';

class SharedPreferencesDataUtils {
  // 保存数据
  Future setUserInfo(key, value) async {
    SharedPreferences sp = await SharedPreferences.getInstance();
    sp.setStringList(key, value);
  }

  // 获取数据
  Future getUserInfo(key) async {
    SharedPreferences sp = await SharedPreferences.getInstance();
    return sp.containsKey(key)?sp.getStringList(key):null;
  }

  // 清除数据
  Future deleteUserInfo(key) async {
    SharedPreferences sp = await SharedPreferences.getInstance();
    sp.remove(key);
  }
}
