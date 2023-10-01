import 'package:dev_opportunity/user/presentation/view_models/user_view_model.dart';
import 'package:flutter/material.dart';
import 'package:dev_opportunity/user/domain/models/user.dart';

class UserProvider with ChangeNotifier {
  UserModel? _user;
  final UserViewModel _userViewModel = UserViewModel();

  UserModel get getUser => _user!;

  Future<void> refreshUser() async {
    UserModel user = await _userViewModel.getUserDetails();
    _user = user;
    notifyListeners();
  }
}