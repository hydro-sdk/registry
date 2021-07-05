import 'dart:convert';
import 'package:firebase_auth/firebase_auth.dart';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:hydro_sdk/registry/registryApi.dart';
import 'package:hydro_sdk/registry/dto/sessionDto.dart';

class UserController extends ChangeNotifier {
  SessionDto? _sessionDto;
  SessionDto? get session => _sessionDto;

  UserController();

  Future<void> init() async {
    final prefs = await SharedPreferences.getInstance();
    final storedSession = prefs.getString("session");

    if (storedSession?.isNotEmpty ?? false) {
      _sessionDto = SessionDto.fromJson(jsonDecode(storedSession!));
    }

    FirebaseAuth.instance.authStateChanges().listen((event) {
      print(event);
    });
  }

  Future<void> setSession(SessionDto sessionDto) async {
    _sessionDto = sessionDto;

    final prefs = await SharedPreferences.getInstance();
    await prefs.setString("session", jsonEncode(sessionDto.toJson()));
    notifyListeners();
  }
}
