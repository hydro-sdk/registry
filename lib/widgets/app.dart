import 'package:flutter/material.dart';
import 'package:hydro_sdk/registry/registryApi.dart';
import 'package:registry/widgets/homePage.dart';
import 'package:registry/widgets/unknownPage.dart';

class App extends StatelessWidget {
  final RegistryApi registryApi;

  const App({
    required this.registryApi,
  });

  @override
  Widget build(BuildContext context) => MaterialApp(
        theme: ThemeData(
          primaryColor: Colors.black,
        ),
        onGenerateRoute: (settings) {
          if (settings.name == "/") {
            return MaterialPageRoute<void>(
                builder: (context) => HomePage(
                      registryApi: registryApi,
                    ));
          }

          return MaterialPageRoute<void>(builder: (context) => UnkownPage());
        },
      );
}
