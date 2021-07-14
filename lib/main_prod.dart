import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:hydro_sdk/registry/registryApi.dart';
import 'package:js/js_util.dart';

import 'package:registry/firebase.dart';
import 'package:registry/util/userController.dart';
import 'package:registry/widgets/app.dart';

Future<void> main() async {
  initializeApp(jsify({
    "apiKey": "AIzaSyCgydlG1jJdCGWZmUxCUq3VPVZRRh-KvxI",
    "authDomain": "hydro-registry.firebaseapp.com",
    "projectId": "hydro-registry",
    "storageBucket": "hydro-registry.appspot.com",
    "messagingSenderId": "406676884567",
    "appId": "1:406676884567:web:3aea62755cc3c02e25a712",
    "measurementId": "G-SE5BCYJ57L"
  }));
  analytics();

  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  final registryApi = const RegistryApi(
    scheme: "https",
    host: "api.registry.hydro-sdk.io",
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
