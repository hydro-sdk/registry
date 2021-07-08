import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:provider/provider.dart';
import 'package:hydro_sdk/registry/registryApi.dart';
import 'package:registry/hooks/useCurrentUserProjects.dart';
import 'package:registry/util/pushProjectDetails.dart';
import 'package:registry/widgets/appScaffold.dart';
import 'package:registry/util/userController.dart';
import 'package:registry/widgets/entryCard.dart';
import 'package:registry/widgets/showCreateProjectDialog.dart';
import 'package:registry/widgets/showNewProjectDialog.dart';

class ProjectsPage extends StatefulHookWidget {
  final RegistryApi registryApi;

  const ProjectsPage({
    required this.registryApi,
  });

  @override
  _ProjectsPageState createState() => _ProjectsPageState();
}

class _ProjectsPageState extends State<ProjectsPage> {
  bool hideProjectList = false;

  void refreshProjectList() {
    if (mounted) {
      setState(() {
        hideProjectList = true;
      });
    }
    Future<void>.delayed(const Duration(milliseconds: 500)).then((_) {
      if (mounted) {
        setState(() {
          hideProjectList = false;
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<UserController>(context).user;
    final projects = useCurrentUserProjects(
      hideProjectList ? null : user,
      registryApi: widget.registryApi,
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
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    const SizedBox(
                      width: 20,
                    ),
                    TextButton(
                      onPressed: () async {
                        final result = await showNewProjectDialog(
                          context,
                          registryApi: widget.registryApi,
                        );

                        await result?.maybeWhen(
                          fromNewProjectDialogAcceptDto: (val) =>
                              showCreateProjectDialog(
                            context,
                            registryApi: widget.registryApi,
                            name: val.name,
                            description: val.description,
                            user: user!,
                          ),
                          orElse: () => null,
                        );

                        refreshProjectList();
                      },
                      child: const Text("New Project"),
                    ),
                  ],
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
                              Padding(
                                padding: const EdgeInsets.only(
                                  bottom: 10,
                                ),
                                child: EntryCard(
                                  onTap: () => pushProjectDetails(
                                    projectId: e.id,
                                    context: context,
                                  ),
                                  title: e.name,
                                  subTitle: e.description,
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
                    : [
                        const CircularProgressIndicator(),
                      ],
          ],
        ),
      ),
    );
  }
}
