import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hydro_sdk/registry/registryApi.dart';
import 'package:registry/widgets/app.dart';

void main() {
  final registryApi = const RegistryApi(baseUrl: "");
  runApp(App(
    registryApi: registryApi,
  ));
}

