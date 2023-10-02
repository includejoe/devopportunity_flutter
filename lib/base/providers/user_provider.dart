import 'dart:convert';
import 'package:dev_opportunity/user/domain/models/user.dart';
import 'package:flutter/cupertino.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UserProvider with ChangeNotifier {
  late SharedPreferences _prefs;
  late UserModel? _user;

  UserProvider() {
    init();
  }

  UserModel? get user => _user;

  set user(UserModel? user) {
    _user = user;
    _prefs.setString("user", jsonEncode(user?.toJson()));
    notifyListeners();
  }

  clearUser() {
    _prefs.remove("user");
    _user = null;
    notifyListeners();
  }

  void init() async {
    _prefs = await SharedPreferences.getInstance();
    final userJson = _prefs.getString("user");
    if (userJson != null) {
      _user = UserModel.fromJson(json.decode(_prefs.getString("user")!));
    }
    notifyListeners();
  }
}