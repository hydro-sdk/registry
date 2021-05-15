import 'package:flutter/material.dart';
import 'package:hydro_sdk/registry/registryApi.dart';

class UserController extends ChangeNotifier {
  String? _token;

  UserController();

  void setToken(String token) {
    _token = token;
  }
}
