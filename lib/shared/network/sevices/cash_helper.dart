// Package imports:
import 'package:shared_preferences/shared_preferences.dart';

// Project imports:
import 'package:resturant_app/models/user_model.dart';

class CashHelper {
  static late SharedPreferences sharedPreference;
  static init() async {
    sharedPreference = await SharedPreferences.getInstance();
    //sharedPreference.clear();
  }

  static Future<bool> putData({
    required String key,
    required dynamic value,
  }) async {
    if (value is UserModel) {
      return await sharedPreference.setString(key, value.toJson());
    }
    if (value is String) return await sharedPreference.setString(key, value);
    if (value is bool) return await sharedPreference.setBool(key, value);
    if (value is int) return await sharedPreference.setInt(key, value);
    return await sharedPreference.setDouble(key, value);
  }

  static UserModel? getUserData({required String key}) {
    var data = sharedPreference.getString(key);
    if (data != null) {
      return UserModel.fromJson(data);
    } else {
      return null;
    }
  }

  static getData({required String key}) {
    return sharedPreference.get(key);
  }

  static Future<bool> clearKey({required String key}) async {
    return await sharedPreference.remove(key);
  }
}
