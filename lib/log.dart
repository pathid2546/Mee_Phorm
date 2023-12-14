import 'package:flutter/material.dart';

class UserProvider extends ChangeNotifier {
  String? userId;

  void setUserId(String newUserId) {
    userId = newUserId;
    notifyListeners();
  }
}
