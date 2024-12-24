import 'dart:convert';

import 'package:get_storage/get_storage.dart';
import 'package:vtinter_chat/models/user_model.dart';

class GetStorageLocal {
  static const String checkAccess = 'checkAccess';
  static const String userKey = 'user';

  static final GetStorage _storage = GetStorage();
  static Future<void> initialise() async {
    await GetStorage.init();
  }

  static bool get isLogin {
    String? data = _storage.read(userKey);
    if (data == null) return false;
    return true;
  }

  static bool get isAccessed => _storage.read(checkAccess) ?? false;
  static set isAccessed(bool access) => _storage.write(checkAccess, access);

  static UserModel? get user {
    String? data = _storage.read(userKey);
    if (data == null) return null;
    return UserModel.fromJson(jsonDecode(data));
  }

  static set user(UserModel? user) =>
      _storage.write(userKey, jsonEncode(user?.toJson()));

  static removeSeason() {
    _storage.remove(userKey);
  }
}
