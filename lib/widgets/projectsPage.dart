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
      child: Padding(
        padding: const EdgeInsets.only(
          left: 20,
        ),
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
                ),
              ],
            ),
            const SizedBox(height: 25),
            ...(projects?.isNotEmpty ?? false)
                ? projects!
                    .map(
                      (e) => Column(
                        children: [
                          Row(
                            children: [
                              SizedBox(
                                width: MediaQuery.of(context).size.width / 4,
                                height: 125,
                                child: ListTile(
                                  title: Text(
                                    e.name,
                                    style: const TextStyle(
                                      fontSize: 28,
                                    ),
                                  ),
                                  subtitle: Text(
                                    e.description,
                                    style: const TextStyle(
                                      fontSize: 18,
                                    ),
                                  ),
                                  onTap: () {},
                                  tileColor: Colors.grey.shade200,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    )
                    .toList()
                    .cast<Widget>()
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
        ),
      ),
    );
  }
}
