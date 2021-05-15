import 'package:flutter/material.dart';
import 'package:hydro_sdk/registry/registryApi.dart';

class SignupPage extends StatefulWidget {
  final RegistryApi registryApi;

  SignupPage({
    required this.registryApi,
  });

  @override
  _SignupPageState createState() => _SignupPageState(
        registryApi: registryApi,
      );
}

class _SignupPageState extends State<SignupPage> {
  final RegistryApi registryApi;

  _SignupPageState({
    required this.registryApi,
  });

  bool signingUp = false;
  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
