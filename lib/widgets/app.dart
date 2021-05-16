import 'package:flutter/material.dart';
import 'package:hydro_sdk/registry/registryApi.dart';
import 'package:registry/widgets/homePage.dart';
import 'package:registry/widgets/unknownPage.dart';
import 'package:registry/widgets/componentDetailsPage.dart';
import 'package:registry/widgets/signupPage.dart';
import 'package:registry/widgets/projectsPage.dart';
import 'package:registry/widgets/changeNotifier.dart';
import 'package:registry/util/userController.dart';

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
          if (settings.name == "/") {
            return MaterialPageRoute<void>(
              builder: (context) => changeNotifier(
                userController: userController,
                child: HomePage(
                  registryApi: registryApi,
                ),
              ),
            );
          } else if (settings.name == "/signup") {
            return MaterialPageRoute<void>(
              settings: RouteSettings(
                name: settings.name,
              ),
              builder: (context) => changeNotifier(
                userController: userController,
                child: SignupPage(
                  registryApi: registryApi,
                ),
              ),
            );
          } 
          else if (settings.name == "/projects") {
            return MaterialPageRoute<void>(
              settings: RouteSettings(
                name: settings.name,
              ),
              builder: (context) => changeNotifier(
                userController: userController,
                child: ProjectsPage(
                  registryApi: registryApi,
                  userController: userController,
                ),
              ),
            );
          } 
          else {
            final uri = Uri.parse(settings.name ?? "");
            if (uri.pathSegments.length == 3 &&
                uri.pathSegments.first == "component") {
              return MaterialPageRoute<void>(
                settings: RouteSettings(
                  name: uri.toString(),
                ),
                builder: (context) => changeNotifier(
                  userController: userController,
                  child: ComponentDetailsPage(
                    projectName: uri.pathSegments[1],
                    componentName: uri.pathSegments.last,
                    registryApi: registryApi,
                  ),
                ),
              );
            }
          }

          return MaterialPageRoute<void>(builder: (context) => UnknownPage());
        },
      );
}
