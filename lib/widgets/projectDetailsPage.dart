import 'package:flutter/material.dart';

import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hydro_sdk/registry/registryApi.dart';
import 'package:provider/provider.dart';

import 'package:registry/hooks/useProjectById.dart';
import 'package:registry/util/userController.dart';
import 'package:registry/widgets/appScaffold.dart';
import 'package:registry/widgets/projectComponentsList.dart';
import 'package:registry/widgets/showCreateComponentDialog.dart';
import 'package:registry/widgets/showNewComponentDialog.dart';

class ProjectDetailsPage extends HookWidget {
  final RegistryApi registryApi;
  final String projectId;

  ProjectDetailsPage({
    required this.registryApi,
    required this.projectId,
  });

  @override
  Widget build(BuildContext context) {
    final project = useProjectById(
      projectId,
      registryApi: registryApi,
    );

    final userController = Provider.of<UserController>(context);

    return AppScaffold(
      child: project == null
          ? const Center(child: CircularProgressIndicator())
          : Padding(
              padding: const EdgeInsets.only(
                left: 30,
                right: 30,
                top: 30,
              ),
              child: ListView(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text(
                        project.name,
                        style: const TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w500,
                            color: Colors.black),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          const SizedBox(
                            width: 20,
                          ),
                          TextButton(
                            onPressed: () async {
                              final result = await showNewComponentDialog(
                                context,
                                projectEntity: project,
                                registryApi: registryApi,
                              );

                              await result?.maybeWhen(
                                fromNewComponentDialogAcceptDto: (val) =>
                                    showCreateComponentDialog(
                                  context,
                                  registryApi: registryApi,
                                  projectEntity: project,
                                  name: val.name,
                                  description: val.description,
                                  user: userController.user!,
                                ),
                                orElse: () => null,
                              );
                            },
                            child: const Text("New Component"),
                          ),
                        ],
                      )
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.only(
                      top: 20,
                    ),
                    child: ProjectComponentsList(
                      projectId: projectId,
                      registryApi: registryApi,
                    ),
                  ),
                ],
              )),
    );
  }
}
