import 'package:shared_preferences/shared_preferences.dart';

class SharedPrefs{

  Future setDBChange(bool status) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setBool('DBChanges', status);
  }

  Future<bool> getDBChanged() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    if (!prefs.containsKey('DBChanges')) {
      print("Not Contais key");

      return false;
    }
    return prefs.getBool('DBChanges')!;
  }
}