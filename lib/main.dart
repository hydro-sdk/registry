import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hydro_sdk/registry/registryApi.dart';
import 'package:registry/util/userController.dart';
import 'package:registry/widgets/app.dart';
import 'package:firebase_core/firebase_core.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  final registryApi = const RegistryApi(
    scheme: "http",
    host: "localhost",
    port: 5000
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
