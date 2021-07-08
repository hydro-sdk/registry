import 'package:flutter/material.dart';

import 'package:hydro_sdk/registry/registryApi.dart';

import 'package:registry/util/userController.dart';
import 'package:registry/widgets/changeNotifier.dart';
import 'package:registry/widgets/componentDetailsPage.dart';
import 'package:registry/widgets/homePage.dart';
import 'package:registry/widgets/projectDetailsPage.dart';
import 'package:registry/widgets/projectsPage.dart';
import 'package:registry/widgets/unknownPage.dart';

class App extends StatelessWidget {
  final RegistryApi registryApi;
  final UserController userController;

  const App({
    required this.registryApi,
    required this.userController,
  });

  @override
  Widget build(BuildContext context) => MaterialApp(
        theme: ThemeData(
          primaryColor: Colors.black,
        ),
        initialRoute: "/",
        onGenerateRoute: (settings) {
          final uri = Uri.parse(settings.name ?? "");
          if (settings.name == "/") {
            return MaterialPageRoute<void>(
              settings: RouteSettings(
                name: uri.toString(),
              ),
              builder: (context) => changeNotifier(
                userController: userController,
                child: HomePage(
                  registryApi: registryApi,
                ),
              ),
            );
          } else if (settings.name == "/projects") {
            return MaterialPageRoute<void>(
              settings: RouteSettings(
                name: uri.toString(),
              ),
              builder: (context) => changeNotifier(
                userController: userController,
                child: ProjectsPage(
                  registryApi: registryApi,
                ),
              ),
            );
          } else {
            if (uri.pathSegments.length == 2 &&
                uri.pathSegments.first == "component") {
              return MaterialPageRoute<void>(
                settings: RouteSettings(
                  name: uri.toString(),
                ),
                builder: (context) => changeNotifier(
                  userController: userController,
                  child: ComponentDetailsPage(
                    componentId: uri.pathSegments[1],
                    registryApi: registryApi,
                  ),
                ),
              );
            } else if (uri.pathSegments.length == 2 &&
                uri.pathSegments.first == "project") {
              return MaterialPageRoute<void>(
                settings: RouteSettings(
                  name: uri.toString(),
                ),
                builder: (context) => changeNotifier(
                  userController: userController,
                  child: ProjectDetailsPage(
                    projectId: uri.pathSegments[1],
                    registryApi: registryApi,
                  ),
                ),
              );
            }
          }

          return MaterialPageRoute<void>(
            builder: (context) => changeNotifier(
              userController: userController,
              child: UnknownPage(),
            ),
          );
        },
      );
}
