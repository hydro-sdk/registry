import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:provider/provider.dart';
import 'package:hydro_sdk/registry/registryApi.dart';
import 'package:registry/hooks/useCurrentUserProjects.dart';
import 'package:registry/util/pushProjectDetails.dart';
import 'package:registry/widgets/appScaffold.dart';
import 'package:registry/util/userController.dart';
import 'package:registry/widgets/entryCard.dart';

class ProjectsPage extends HookWidget {
  final RegistryApi registryApi;

  const ProjectsPage({
    required this.registryApi,
  });

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<UserController>(context).user;
    final projects = useCurrentUserProjects(
      user,
      registryApi: registryApi,
    );

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
                  "${user?.displayName}'s Projects",
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
                              EntryCard(
                                onTap: () => pushProjectDetails(
                                  projectId: e.id,
                                  context: context,
                                ),
                                title: e.name,
                                subTitle: e.description,
                              )
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
