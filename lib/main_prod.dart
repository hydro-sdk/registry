import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:hydro_sdk/registry/registryApi.dart';
import 'package:js/js_util.dart';

import 'package:registry/firebase.dart';
import 'package:registry/util/userController.dart';
import 'package:registry/widgets/app.dart';

final registryTestHost = const String.fromEnvironment("REGISTRY_TEST_HOST");
final registryTestPort =
    int.tryParse(const String.fromEnvironment("REGISTRY_TEST_PORT"));
final registryTestScheme = const String.fromEnvironment("REGISTRY_TEST_SCHEME");

Future<void> main() async {
  initializeApp(jsify({
    "apiKey": "AIzaSyCpwINU5tsSZ_QRzcHRAuhj-QsiCPTEiSY",
    "authDomain": "hydro-reservoir-staging.firebaseapp.com",
    "projectId": "hydro-reservoir-staging",
    "storageBucket": "hydro-reservoir-staging.appspot.com",
    "messagingSenderId": "314512543852",
    "appId": "1:314512543852:web:99fdf42edf468fccb10849",
    "measurementId": "G-YFTHEJGBPM"
  }));
  analytics();

  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  final registryApi = RegistryApi(
    scheme: registryTestScheme,
    host: registryTestHost,
    port: registryTestPort,
  );
  final userController = UserController(
    registryApi: registryApi,
  );
  await userController.init();

  await FirebaseAuth.instance.setPersistence(Persistence.LOCAL);
  runApp(
    App(
      registryApi: registryApi,
      userController: userController,
    ),
  );
}
