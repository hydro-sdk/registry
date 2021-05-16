import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:hydro_sdk/registry/registryApi.dart';
import 'package:hydro_sdk/registry/dto/projectEntity.dart';
import 'package:registry/widgets/appScaffold.dart';
import 'package:registry/util/userController.dart';

class ProjectsPage extends StatefulWidget {
  final RegistryApi registryApi;
  final UserController userController;

  ProjectsPage({
    required this.registryApi,
    required this.userController,
  });

  @override
  _ProjectsPageState createState() => _ProjectsPageState();
}

class _ProjectsPageState extends State<ProjectsPage> {
  _ProjectsPageState();

  List<ProjectEntity>? projects;

  @override
  void initState() {
    widget.registryApi
        .canUpdateProjects(sessionDto: widget.userController.session)
        .then((value) {
      print(value);
      if (mounted) {
        setState(() {
          projects = value;
        });
      }
    }).onError((error, stackTrace) {
      print(error);
      print(stackTrace);
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return AppScaffold(
        child: Column(
      children: [
        Row(
          children: [
            Text(
              "${widget.userController.session!.authenticatedUser.username}'s Projects",
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 38,
              ),
            )
          ],
        ),
        ...(projects?.isNotEmpty ?? false)
            ? projects!.map((e) => Text(e.name)).toList().cast<Widget>()
            : (projects?.isEmpty ?? false)
                ? [
                    const Text(
                      "No projects",
                      style: TextStyle(
                        fontSize: 28,
                      ),
                    )
                  ]
                : [const CircularProgressIndicator()],
      ],
    ));
  }
}
