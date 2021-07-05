import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hydro_sdk/registry/registryApi.dart';
import 'package:registry/util/userController.dart';
import 'package:registry/widgets/app.dart';
import 'package:firebase_core/firebase_core.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  final registryApi =
      const RegistryApi(baseUrl: "hydro-reservoir.herokuapp.com");
  final userController = UserController();
  await userController.init();
  runApp(
    App(
      registryApi: registryApi,
      userController: userController,
    ),
  );
}
