import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:hydro_sdk/registry/registryApi.dart';
import 'package:hydro_sdk/registry/dto/createUserDto.dart';
import 'package:hydro_sdk/registry/dto/loginUserDto.dart';
import 'package:registry/widgets/appScaffold.dart';
import 'package:registry/util/userController.dart';

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
  final TextEditingController usernameTextEditingController =
      TextEditingController();
  final TextEditingController passwordTextEditingController =
      TextEditingController();

  _SignupPageState({
    required this.registryApi,
  });

  bool signingUp = false;

  Future<void> _signup(BuildContext context) async {
    if (usernameTextEditingController.text.isNotEmpty &&
        passwordTextEditingController.text.isNotEmpty) {
      if (mounted) {
        setState(() {
          signingUp = true;
        });
      }
      final createResponse = await registryApi.createUser(
          dto: CreateUserDto(
        username: usernameTextEditingController.text,
        password: passwordTextEditingController.text,
      ));

      if (createResponse) {
        final loginResponse = await registryApi.login(
          dto: LoginUserDto(
            username: usernameTextEditingController.text,
            password: passwordTextEditingController.text,
          ),
        );

        if (loginResponse!.authenticatedUser != null) {
          final userController =
              Provider.of<UserController>(context, listen: false);
          await userController.setSession(loginResponse);
          await Navigator.of(context).maybePop();
        }
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return AppScaffold(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Card(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Padding(
                      padding: EdgeInsets.all(10),
                      child: Text(
                        "Sign Up",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 26,
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(10),
                      child: SizedBox(
                        height: 26,
                        width: 252,
                        child: TextField(
                          controller: usernameTextEditingController,
                          decoration: const InputDecoration(
                            border: OutlineInputBorder(),
                            labelText: "Username",
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(10),
                      child: SizedBox(
                        height: 26,
                        width: 252,
                        child: TextField(
                          controller: passwordTextEditingController,
                          obscureText: true,
                          decoration: const InputDecoration(
                            border: OutlineInputBorder(),
                            labelText: "Password",
                          ),
                        ),
                      ),
                    ),
                    Padding(
                        padding: const EdgeInsets.all(10),
                        child: !signingUp
                            ? TextButton(
                                child: const Text("Sign Up"),
                                onPressed: () async {
                                  await _signup(context);
                                },
                              )
                            : const CircularProgressIndicator()),
                  ],
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}
