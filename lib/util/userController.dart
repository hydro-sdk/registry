import 'package:flutter/material.dart';
import 'package:hydro_sdk/registry/registryApi.dart';
import 'package:hydro_sdk/registry/dto/sessionDto.dart';

class UserController extends ChangeNotifier {
  SessionDto? _sessionDto;

  UserController();

  void setSession(SessionDto sessionDto) {
    _sessionDto = sessionDto;
    notifyListeners();
  }
}
