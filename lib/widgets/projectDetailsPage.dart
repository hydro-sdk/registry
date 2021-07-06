import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hydro_sdk/registry/registryApi.dart';
import 'package:registry/hooks/useProjectById.dart';
import 'package:registry/widgets/appScaffold.dart';

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
    return AppScaffold(
      child: project == null
          ? const Center(child: CircularProgressIndicator())
          : Padding(
              padding: const EdgeInsets.only(
                left: 30,
                right: 30,
                top: 30,
              ),
              child: Row(
                children: [
                  Text(
                    project.name,
                    style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w500,
                        color: Colors.black),
                  ),
                ],
              ),
            ),
    );
  }
}
