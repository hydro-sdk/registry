import 'package:flutter/material.dart';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:hydro_sdk/registry/dto/sessionDto.dart';
import 'package:hydro_sdk/registry/registryApi.dart';

class UserController extends ChangeNotifier {
  final RegistryApi registryApi;

  UserController({
    required this.registryApi,
  });

  User? _user;

  User? get user => _user;

  Future<void> init() async {
    FirebaseAuth.instance.authStateChanges().listen((event) async {
      print(event);
      _user = event;

      if (_user != null) {
        final provisionResponse = await registryApi.provisionUser(
          sessionDto: SessionDto(authToken: await _user?.getIdToken() ?? ""),
        );

        if (!provisionResponse) {
          print("Failed to provision ${user?.displayName}");
        }
      }
      notifyListeners();
    });
  }

  Future<void> setSession(SessionDto sessionDto) async {}
}
