import 'package:flutter/material.dart';
import 'package:hydro_sdk/registry/registryApi.dart';
import 'package:registry/widgets/homePage.dart';
import 'package:registry/widgets/unknownPage.dart';
import 'package:registry/widgets/componentDetailsPage.dart';

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
        initialRoute: "/",
        onGenerateRoute: (settings) {
          if (settings.name == "/") {
            return MaterialPageRoute<void>(
                builder: (context) => HomePage(
                      registryApi: registryApi,
                    ));
          } else {
            final uri = Uri.parse(settings.name ?? "");
            if (uri.pathSegments.length == 3 &&
                uri.pathSegments.first == "component") {
              return MaterialPageRoute<void>(
                  settings: RouteSettings(
                    name: uri.toString(),
                  ),
                  builder: (context) => ComponentDetailsPage(
                        projectName: uri.pathSegments[1],
                        componentName: uri.pathSegments.last,
                        registryApi: registryApi,
                      ));
            }
          }

          return MaterialPageRoute<void>(builder: (context) => UnknownPage());
        },
      );
}
