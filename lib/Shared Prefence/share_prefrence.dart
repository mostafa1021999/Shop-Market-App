import 'package:shared_preferences/shared_preferences.dart';

class Save{
  static SharedPreferences? sharedPrefrences;
  static init()async{
    sharedPrefrences= await SharedPreferences.getInstance();
  }

  static Future<bool> putdata({required String key, required bool value})
  async{
    return await sharedPrefrences!.setBool(key, value);
}
  static dynamic getdata({required String key}){
    return sharedPrefrences!.get(key);
  }
  static Future savedata({
  required String key,
  required dynamic value,
})async {
  if(value is bool)  return await sharedPrefrences!.setBool(key,value);
  if(value is String)  return await sharedPrefrences!.setString(key,value);
  if(value is int)  return await sharedPrefrences!.setInt(key,value);
  return await sharedPrefrences!.setDouble(key,value);
}
  static Future<bool> remove({required String key})async
  {
    return await sharedPrefrences!.remove(key);
  }
}
